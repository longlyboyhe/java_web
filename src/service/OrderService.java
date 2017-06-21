package service;


import bean.Order;
import dao.Dao;
import dao.DaoOrderImpl;

import java.sql.SQLException;
import java.util.ArrayList;

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

    public ArrayList<Order> getAllOrders(int userId) {
        ArrayList<Order> orders = null;
        try {
            orders = DaoOrderImpl.getAllOrders(userId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }
}
