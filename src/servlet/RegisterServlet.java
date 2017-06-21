package servlet;

import bean.User;
import service.PublicService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        PublicService ps = new PublicService();
        String name = req.getParameter("name");
        String pwd = req.getParameter("pwd");
        String nickName = req.getParameter("nick_name");
        String phoneNum = req.getParameter("phone_num");
        String identity = req.getParameter("identity");
        System.out.println(name + pwd + nickName + phoneNum);
        int userType = identity.equals("admin") ? User.ADMIN_USER : User.NORMAL_USER;
        User user = new User(name, nickName, pwd, phoneNum, userType);
        String re = ps.userRegister(user);
        if (re.equals("success")) {
            resp.sendRedirect("/log.jsp");
        } else {
            req.setAttribute("register_info", "注册失败:" + re);
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
        }
    }
}
