package service;


import bean.Order;
import dao.DaoOrderImpl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

public class OrderService {

    public boolean insertOrder(Order order) {
        boolean re = false;
        try {
            re = DaoOrderImpl.insertOrder(order);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return re;
    }

    public ArrayList<Order> getUserAllOrders(int userId) {
        ArrayList<Order> orders = null;
        try {
            orders = DaoOrderImpl.getUserAllOrders(userId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public ArrayList<Order> getAllOrders() throws SQLException {
        ArrayList<Order> orders;
        orders = DaoOrderImpl.getAllOrders();
        return orders;
    }

    public boolean updateOrderStatus(int orderId, ArrayList<HashMap<String, Object>> array) throws SQLException {
        return DaoOrderImpl.updateOrderStatus(orderId, array);
    }
}
