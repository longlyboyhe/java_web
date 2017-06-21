package dao;

import bean.Order;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

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


    public static ArrayList<Order> getAllOrders(int userId) throws SQLException {
        ArrayList<Order> orders = new ArrayList<>();
        Connection conn = Dao.getConnection();
        Statement st = conn.createStatement();
        String sql = "SELECT * FROM t_order WHERE orderUserId = " + userId;
        ResultSet rs = st.executeQuery(sql);
        while (rs.next()) {
            int id = rs.getInt("orderId");
            int serialNum = rs.getInt("serialNumber");
            String address = rs.getString("address");
            String phoneNum = rs.getString("phoneNumber");
            String date = rs.getString("orderDate");
            String goodsStr = rs.getString("orderGoodsIds");
            Order order = new Order(id, serialNum, address, phoneNum, date, goodsStr);
            orders.add(order);
        }
        return orders;
    }

}
