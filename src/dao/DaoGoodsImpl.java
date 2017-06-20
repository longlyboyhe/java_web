package dao;


import bean.Goods;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

public class DaoGoodsImpl {
    public static ArrayList<HashMap<String, Object>> selectAllGoods() throws SQLException {
        Connection conn = Dao.getConnection();
        if (conn == null) {
            return null;
        }
        Statement st = conn.createStatement();
        String sql = "SELECT * FROM t_goods";
        ResultSet rs = st.executeQuery(sql);
        ArrayList<HashMap<String, Object>> goodsList = new ArrayList<>();
        while (rs.next()) {
            String goodsId = rs.getString("goodsNo");
            String goodsName = rs.getString("goodsName");
            String goodsType = rs.getString("goodsType");
            String useWat = rs.getString("useWay");
            int stock = rs.getInt("stock");
            float price = rs.getFloat("price");
            String pic = rs.getString("pic");
            Goods goods = new Goods(goodsId, goodsName, goodsType, useWat, price, pic);
            HashMap<String, Object> map = new HashMap<>(2);
            map.put("goods", goods);
            map.put("stock", stock);
            goodsList.add(map);
        }
        Dao.closeAll(rs, st, conn);
        return goodsList;
    }
}
