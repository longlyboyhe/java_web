package servlet;

import service.ShopCartService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

public class ShopCartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ShopCartService shopCartService = new ShopCartService();
        String action = req.getParameter("action");
        switch (action) {
            case "add":
                addShopCart(req, resp, shopCartService);
                break;
            case "load":
                loadShopCart(req, resp, shopCartService);
                break;
        }

    }

    private void loadShopCart(HttpServletRequest req, HttpServletResponse resp, ShopCartService shopCartService) throws IOException {
        int userId = Integer.parseInt(req.getParameter("userId"));
        ArrayList<HashMap<String, Object>> result = shopCartService.getUserShopCart(userId);
        if (result == null) {
            return;
        }
        //to json
        StringBuilder sb = new StringBuilder();
        sb.append("[");
        for (int i = 0; i < result.size(); i++) {
            HashMap<String, Object> map = result.get(i);
            String number = (String) map.get("number");
            String goodsId = (String) map.get("goodsId");
            sb.append("{").append("\"number\"").append(":").append("\"").append(number).append("\",");
            if (i == result.size() - 1) {
                sb.append("\"goodsId\"").append(":").append("\"").append(goodsId).append("\"}");
            } else {
                sb.append("\"goodsId\"").append(":").append("\"").append(goodsId).append("\"},");
            }
        }
        sb.append("]");
        resp.setContentType("json");
        resp.getWriter().write(sb.toString());
    }

    private void addShopCart(HttpServletRequest req, HttpServletResponse resp, ShopCartService shopCartService) throws IOException {
        int userId = Integer.parseInt(req.getParameter("userId"));
        int goodsId = Integer.parseInt(req.getParameter("goodsId"));
        int number = Integer.parseInt(req.getParameter("number"));
        PrintWriter printWriter = resp.getWriter();
        int num = shopCartService.addToShopCart(userId, goodsId, number);
        if (num > 0) {
            printWriter.println("add_success");
        } else {
            printWriter.println("add_error");
        }
    }
}
