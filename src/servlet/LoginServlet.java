package servlet;


import bean.User;
import org.omg.PortableInterceptor.SYSTEM_EXCEPTION;
import service.GoodsService;
import service.PublicService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PublicService ps = new PublicService();
        String name = req.getParameter("name");
        String pwd = req.getParameter("pwd");
        User user = new User(name, null, pwd, null, 0);
        User logUser = ps.userLogin(user);
        if (logUser != null) {
            GoodsService goodsService = new GoodsService();
            try {
                ArrayList<HashMap<String, Object>> goods_list = goodsService.getAllGoodsList();
                req.setAttribute("goods_list", goods_list);
                req.setAttribute("u", logUser);
                req.getRequestDispatcher("/userHome.jsp").forward(req, resp);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } else {
            req.setAttribute("login_info", "登录失败");
            req.getRequestDispatcher("/index.jsp").forward(req, resp);
        }
    }

}
