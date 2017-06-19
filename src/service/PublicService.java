package service;

import bean.User;
import dao.DaoUserImp;

import java.sql.SQLException;

public class PublicService {
    /**
     * 登录判断
     *
     * @param user user
     * @return 用户数据
     */
    public User userLogin(User user) {
        User u = null;
        try {
            u = DaoUserImp.selectUserByNameAndPass(user.getName(), user.getPwd());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return u;
    }

    /**
     * 注册
     *
     * @param user 新用户
     * @return 注册是否成功
     */
    public String userRegister(User user) {
        String re = "";
        try {
            re = DaoUserImp.registerUser(user);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return re;
    }
}
