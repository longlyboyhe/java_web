package service;


import dao.DaoGoodsImpl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

public class GoodsService {
    public ArrayList<HashMap<String, Object>> getAllGoodsList() throws SQLException {
        return DaoGoodsImpl.selectAllGoods();
    }
}
