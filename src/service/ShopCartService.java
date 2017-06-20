package service;

import dao.DaoShopCartImpl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

public class ShopCartService {
    public int addToShopCart(int userId, int goodsId, int number) {
        int num = 0;
        try {
            String result = DaoShopCartImpl.selectByUserId(goodsId, userId);
            if (result.equals(DaoShopCartImpl.EXISTS)) {
                num = DaoShopCartImpl.updateGoodsInShopCart(goodsId, userId, number);
            } else if (result.equals(DaoShopCartImpl.NOT_EXISTS)) {
                num = DaoShopCartImpl.insertNewGoodsToShopCart(goodsId, userId, number);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return num;
    }

    public ArrayList<HashMap<String, Object>> getUserShopCart(int userId) {
        ArrayList<HashMap<String, Object>> result = null;
        try {
            result = DaoShopCartImpl.getUserShopCart(userId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }


    public boolean updateShopCart(int goodsNo, int userId, int number) {
        boolean re = false;
        try {
            int num = DaoShopCartImpl.updateGoodsInShopCart(goodsNo, userId, number);
            re = num > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return re;
    }

    public boolean deleteShopCart(int goodsNo, int userId) {
        boolean re = false;
        try {
            re = DaoShopCartImpl.deleteShopCart(goodsNo, userId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return re;
    }
}
