package service;


import bean.Goods;
import dao.DaoGoodsImpl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

public class GoodsService {
    public ArrayList<Goods> getAllGoodsList() throws SQLException {
        return DaoGoodsImpl.selectAllGoods();
    }

    public Goods getGoodsById(int id) throws SQLException {
        return DaoGoodsImpl.getGoodsById(id);
    }
}
