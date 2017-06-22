package dao;

import bean.Order;
import service.GoodsService;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by jiyang on 17-6-20.
 * 订单数据库操作
 */
public class DaoOrderImpl {
    public static boolean insertOrder(Order order) throws SQLException {
        Connection conn = Dao.getConnection();
        Statement st = conn.createStatement();
        String sql = "INSERT INTO t_order " +
                "(serialNumber," +
                "orderUserId," +
                "address," +
                "phoneNumber," +
                "orderDate," +
                "orderGoodsIds) " +
                "VALUES " +
                "('%s','%s','%s','%s','%s','%s');";
        sql = String.format(sql,
                order.getSerialNumber(),
                order.getOrderUserId(),
                order.getAddress(),
                order.getPhoneNumber(),
                order.getOrderDate(),
                order.getOrderGoodsIds());
        return st.executeUpdate(sql) > 0;
    }


    public static ArrayList<Order> getUserAllOrders(int userId) throws SQLException {
        ArrayList<Order> orders = new ArrayList<>();
        Connection conn = Dao.getConnection();
        Statement st = conn.createStatement();
        String sql = "SELECT * FROM t_order WHERE orderUserId='" + userId + "' ORDER BY orderId DESC;";
        ResultSet rs = st.executeQuery(sql);
        while (rs.next()) {
            constructorOrderList(orders, rs);
        }
        return orders;
    }

    public static ArrayList<Order> getAllOrders() throws SQLException {
        ArrayList<Order> orders = new ArrayList<>();
        Connection conn = Dao.getConnection();
        Statement st = conn.createStatement();
        String sql = "SELECT * FROM t_order  ORDER BY orderId DESC;";
        ResultSet rs = st.executeQuery(sql);
        while (rs.next()) {
            constructorOrderList(orders, rs);
        }
        return orders;
    }


    public static boolean updateOrderStatus(int orderId, ArrayList<HashMap<String, Object>> array) throws SQLException {
        Connection conn = Dao.getConnection();
        Statement st = conn.createStatement();
        String sql = "UPDATE t_order SET hasOver='1' WHERE orderId='" + orderId + "';";
        GoodsService gs = new GoodsService();
        boolean re;
        for (HashMap<String, Object> map : array) {
            Double d = (Double) map.get("number");
            int num = -d.intValue();
            System.out.println(map.get("goods").toString());
            d = (Double) ((Map) map.get("goods")).get("id");
            int goodsNo = d.intValue();
            gs.updateGoodsNumber(goodsNo, num);
        }
        re = st.executeUpdate(sql) > 0;
        return re;
    }

    private static void constructorOrderList(ArrayList<Order> orders, ResultSet rs) throws SQLException {
        int id = rs.getInt("orderId");
        int serialNum = rs.getInt("serialNumber");
        String address = rs.getString("address");
        String phoneNum = rs.getString("phoneNumber");
        String date = rs.getString("orderDate");
        String goodsStr = rs.getString("orderGoodsIds");
        int userId = rs.getInt("orderUserId");
        int hasOver = rs.getInt("hasOver");
        Order order = new Order(id, userId, serialNum, address, phoneNum, date, goodsStr, hasOver == 1);
        orders.add(order);
    }


}
