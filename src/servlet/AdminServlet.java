package servlet;

import bean.User;
import com.google.gson.Gson;
import service.PublicService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

public class AdminServlet extends HttpServlet {


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        String action = req.getParameter("action");
        switch (action) {
            case "get_all_user":
                ArrayList<User> users = new PublicService().getAllUsers();
                Gson gson = new Gson();
                String json = gson.toJson(users);
                resp.getWriter().print(json);
                break;
        }
    }
}
