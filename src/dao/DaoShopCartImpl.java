package dao;

import bean.Goods;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

public class DaoShopCartImpl {

    public static final String EXISTS = "exists";
    public static final String NOT_EXISTS = "not_exists";

    /**
     * 查询购物车中是否有指定商品
     *
     * @param goodsId 商品编号
     * @param userId  用户id
     * @return 是否存在
     * @throws SQLException 数据库异常
     */
    public static String selectByUserId(int goodsId, int userId) throws SQLException {
        Connection conn = Dao.getConnection();
        Statement st = conn.createStatement();
        String sql = "select * from t_shopcart where f_goodsNo ="
                + goodsId +
                " and f_userId = "
                + userId + ";";
        ResultSet set = st.executeQuery(sql);
        if (set.next()) {
            return EXISTS;
        }
        Dao.closeAll(set, st, conn);
        return NOT_EXISTS;
    }


    /**
     * 向购物车插入指定数目的商品
     *
     * @param goodsId 商品ID
     * @param userId  用户ID
     * @param number  插入数目
     * @return 返回插入数目
     * @throws SQLException 数据库异常
     */
    public static int insertNewGoodsToShopCart(int goodsId, int userId, int number) throws SQLException {
        Connection conn = Dao.getConnection();
        Statement st = conn.createStatement();
        String sql = "insert into t_shopcart (f_goodsNo,number,f_userId) values (\"" + goodsId + "\"," +
                "\"" + number + "\","
                + "\"" + userId + "\");";
        int num = st.executeUpdate(sql);
        Dao.closeAll(null, st, conn);
        return num;
    }


    /**
     * 更新购物车中相同商品的数量
     *
     * @param goodsId   商品ID
     * @param userId    用户ID
     * @param addNumber 新添加的数量
     * @return 更新的数量
     * @throws SQLException 数据库异常
     */
    public static int updateGoodsInShopCart(int goodsId, int userId, int addNumber) throws SQLException {
        Connection conn = Dao.getConnection();
        Statement st = conn.createStatement();
        String sql = "update t_shopcart set number = number +" + addNumber + " where f_userId = " + userId + " and f_goodsNo = " + goodsId + ";";
        int num = st.executeUpdate(sql);
        Dao.closeAll(null, st, conn);
        return num;
    }

    /**
     * 获取用户的购物车
     *
     * @param userId 用户id
     * @return 返回集合
     * @throws SQLException 数据库异常
     */
    public static ArrayList<HashMap<String, Object>> getUserShopCart(int userId) throws SQLException {
        ArrayList<HashMap<String, Object>> result = new ArrayList<>();
        Connection connection = Dao.getConnection();
        Statement st = connection.createStatement();
        String sql = "select tg.goodsNo,tg.goodsName,tg.goodsType,tg.stock,tg.useWay,tg.price,tg.pic,ts.number from t_shopcart As ts,t_goods As tg where ts.f_goodsNo = tg.goodsNo and ts.f_userId=" + userId + ";";
        ResultSet rs = st.executeQuery(sql);
        while (rs.next()) {
            int id = rs.getInt("goodsNo");
            String name = rs.getString("goodsName");
            String type = rs.getString("goodsType");
            String useWay = rs.getString("useWay");
            int stock = rs.getInt("stock");
            float price = rs.getFloat("price");
            int number = rs.getInt("number");
            String pic = rs.getString("pic");
            Goods goods = new Goods(id, name, type, useWay, price, pic, stock);
            HashMap<String, Object> hashMap = new HashMap<>(2);
            hashMap.put("goods", goods);
            hashMap.put("number", number);
            result.add(hashMap);
        }
        Dao.closeAll(rs, st, connection);
        return result;
    }

    public static boolean deleteShopCart(int goodsNo, int userId) throws SQLException {
        Connection conn = Dao.getConnection();
        Statement st = conn.createStatement();
        String sql = "DELETE FROM t_shopcart WHERE f_userId=" + userId + " AND f_goodsNo=" + goodsNo + ";";
        return st.execute(sql);
    }
}
