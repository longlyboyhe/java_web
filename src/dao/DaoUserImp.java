package dao;


import bean.User;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DaoUserImp {
    public static User selectUserByNameAndPass(String name, String pwd) throws SQLException {
        Connection conn = Dao.getConnection();
        if (conn == null) {
            System.out.println("connect null");
            return null;
        }
        Statement st = conn.createStatement();
        String sql = "select * from t_user where name ='" + name + "' and pass = '" + pwd + "';";
        ResultSet rs = st.executeQuery(sql);
        User user = null;
        if (rs.next()) {
            int userId = rs.getInt("id");
            String _name = rs.getString("name");
            String _pwd = rs.getString("pass");
            String _nickName = rs.getString("nick_name");
            String _phone = rs.getString("phone_num");
            int _userType = rs.getInt("user_type");
            user = new User(_name, _nickName, _pwd, _phone, _userType);
            user.setId(userId);
        }
        return user;
    }

    /**
     * 注册用户，插入到数据库
     *
     * @param user 新用户
     * @return 是否成功
     */
    public static String registerUser(User user) throws SQLException {
        Connection conn = Dao.getConnection();
        if (conn == null) {
            System.out.println("connect null");
            return "error";
        }
        Statement st = conn.createStatement();
        String sql_check = "select * from t_user where name='" + user.getName() + "'";
        ResultSet rs = st.executeQuery(sql_check);
        if (rs.next()) {
            return "用户已存在";
        }
        String sql = "insert into t_user(name,pass,nick_name,phone_num,user_type) values (" +
                "'" + user.getName() + "'," +
                "'" + user.getPwd() + "'," +
                "'" + user.getNickName() + "'," +
                "'" + user.getPhoneNum() + "'," +
                "'" + user.getUserType() + "')";
        int re = st.executeUpdate(sql);
        if (re > 0)
            return "success";
        return "failed";

    }
}
