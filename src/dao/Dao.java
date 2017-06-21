package dao;


import java.sql.*;

public class Dao {
    static String DB_HOST = "jdbc:mysql://localhost:3306/db_ji_yang?useUnicode=true&characterEncoding=UTF-8";
    static String DB_USER = "root";
    static String DB_PWD = "jiyang147852";

    //加载JDBC驱动
    static {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println("数据库驱动加载失败:" + e.getMessage());
        }
    }

    /**
     * 获得数据库连接
     *
     * @return conn
     */
    public static Connection getConnection() {
        Connection conn = null;
        try {
            conn = DriverManager.getConnection(DB_HOST, DB_USER, DB_PWD);
        } catch (SQLException e) {
            System.out.println("数据库连接出错:" + e.getMessage());
        }
        return conn;
    }

    /**
     * 关闭资源
     *
     * @param rs   记录集
     * @param stmt 声明
     * @param conn 连接
     */
    public static void closeAll(ResultSet rs, Statement stmt, Connection conn) {
        //关闭记录集
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        //关闭声明
        if (stmt != null) {
            try {
                stmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        //关闭连接对象
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
