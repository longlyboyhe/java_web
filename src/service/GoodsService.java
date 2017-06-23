package service;


import bean.Goods;
import dao.DaoGoodsImpl;

import java.sql.SQLException;
import java.util.ArrayList;

public class GoodsService {
    public ArrayList<Goods> getAllGoodsList() throws SQLException {
        return DaoGoodsImpl.selectAllGoods();
    }

    public Goods getGoodsById(Object id) throws SQLException {
        return DaoGoodsImpl.getGoodsById(id);
    }

    public boolean updateGoodsNumber(int goodsNo, int addNum) throws SQLException {
        return DaoGoodsImpl.updateGoodsNum(goodsNo, addNum);
    }

    public boolean insertGoods(Goods goods) throws SQLException {
        return DaoGoodsImpl.insertGoods(goods);
    }

    public boolean updateGoods(Goods goods) throws SQLException {
        return DaoGoodsImpl.updateGoods(goods);
    }

    public boolean deleteGoodsById(int deleteGoodsNo) throws SQLException {
        return DaoGoodsImpl.deleteGoodsById(deleteGoodsNo);
    }
}
