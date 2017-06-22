package dao;


import bean.Goods;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

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

    public static Goods getGoodsById(Object goodsNo) throws SQLException {
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

    public static boolean updateGoodsNum(int goodsNo, int addNum) throws SQLException {
        Connection conn = Dao.getConnection();
        Statement st = conn.createStatement();
        String sql = "UPDATE t_goods SET stock=stock+'" + addNum + "' WHERE goodsNo='" + goodsNo + "';";
        return st.executeUpdate(sql) > 0;
    }

    public static boolean insertGoods(Goods goods) throws SQLException {
        Connection conn = Dao.getConnection();
        Statement st = conn.createStatement();
        String sql = "INSERT INTO t_goods (goodsNo,goodsName,goodsType,useWay,stock,price,pic) VALUES ('%s','%s','%s','%s','%s','%s','%s');";
        sql = String.format(sql, goods.getId(), goods.getName(), goods.getType(), goods.getUseWay(), goods.getStock(), goods.getPrice(), goods.getPic());
        return st.execute(sql);
    }

    public static boolean updateGoods(Goods goods) throws SQLException {
        Connection conn = Dao.getConnection();
        Statement st = conn.createStatement();
        String sql = "UPDATE t_goods SET goodsName='%s',goodsType='%s',useWay='%s',stock='%s',price='%s',pic='%s' WHERE goodsNo='%s';";
        sql = String.format(goods.getName(), goods.getType(), goods.getUseWay(), goods.getStock(), goods.getPrice(), goods.getPic(), goods.getId());
        return st.executeUpdate(sql) > 0;
    }
}
