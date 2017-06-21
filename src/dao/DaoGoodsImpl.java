package dao;


import bean.Goods;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

public class DaoGoodsImpl {
    public static ArrayList<Goods> selectAllGoods() throws SQLException {
        Connection conn = Dao.getConnection();
        Statement st = conn.createStatement();
        String sql = "SELECT * FROM t_goods";
        ResultSet rs = st.executeQuery(sql);
        ArrayList<Goods> goodsList = new ArrayList<>();
        while (rs.next()) {
            int goodsId = rs.getInt("goodsNo");
            String goodsName = rs.getString("goodsName");
            String goodsType = rs.getString("goodsType");
            String useWat = rs.getString("useWay");
            int stock = rs.getInt("stock");
            float price = rs.getFloat("price");
            String pic = rs.getString("pic");
            Goods goods = new Goods(goodsId, goodsName, goodsType, useWat, price, pic, stock);
            goodsList.add(goods);
        }
        Dao.closeAll(rs, st, conn);
        return goodsList;
    }

    public static Goods getGoodsById(int goodsNo) throws SQLException {
        Connection conn = Dao.getConnection();
        Statement st = conn.createStatement();
        String sql = "SELECT * FROM t_goods WHERE goodsNo =" + goodsNo;
        ResultSet rs = st.executeQuery(sql);
        Goods goods = null;
        if (rs.next()) {
            int goodsId = rs.getInt("goodsNo");
            String goodsName = rs.getString("goodsName");
            String goodsType = rs.getString("goodsType");
            String useWat = rs.getString("useWay");
            int stock = rs.getInt("stock");
            float price = rs.getFloat("price");
            String pic = rs.getString("pic");
            goods = new Goods(goodsId, goodsName, goodsType, useWat, price, pic, stock);
        }
        return goods;
    }
}
