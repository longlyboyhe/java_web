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
        resp.setContentType("text/html;charset=UTF-8");
        PublicService ps = new PublicService();
        String action = req.getParameter("action");
        if (action != null && action.equals("log_out")) {
            req.getSession().setAttribute("user", null);
            resp.getWriter().write("log_out");
            return;
        }
        String name = req.getParameter("name");
        String pwd = req.getParameter("pwd");
        User user = new User(name, null, pwd, null, 0);
        User logUser = ps.userLogin(user);
        if (logUser != null) {
            req.getSession().setAttribute("user", logUser);
            resp.sendRedirect("/index.jsp");
        } else {
            req.setAttribute("login_info", "登录失败");
            req.getRequestDispatcher("/log.jsp").forward(req, resp);
        }
    }


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}
