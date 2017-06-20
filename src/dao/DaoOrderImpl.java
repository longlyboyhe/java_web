package dao;

import bean.Order;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Created by jiyang on 17-6-20.
 * 订单数据库操作
 */
public class DaoOrderImpl {
    public static boolean insertOrder(Order order) throws SQLException {
        Connection conn = Dao.getConnection();
        Statement st = conn.createStatement();
        String sql = "INSERT INTO t_order " +
                "(orderId,serialNumber,orderUserId,address,orderDate,orderTime) " +
                "VALUES " +
                "('%s','%s','%s','%s',NOW(),CURDATE());";
        sql = String.format(sql, order.getOrderId(), order.getSerialNumber(), order.getOrderId(), order.getAddress());
        System.out.println(sql);
        return st.execute(sql);
    }
}
