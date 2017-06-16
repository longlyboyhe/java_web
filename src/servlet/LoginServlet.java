package servlet;


import bean.User;
import service.PublicService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PublicService ps = new PublicService();
        String name = req.getParameter("name");
        String pwd = req.getParameter("pwd");
        User user = new User(name, null, pwd, null, 0);
        boolean logSuccess = ps.userLogin(user);
        if (logSuccess) {
            req.setAttribute("user", user);
            req.getRequestDispatcher("/userHome.jsp").forward(req, resp);
        } else {
            req.setAttribute("login_info", "登录失败");
            req.getRequestDispatcher("/index.jsp").forward(req, resp);
        }
    }

}
