package servlet;

import bean.Goods;
import bean.User;
import com.google.gson.Gson;
import service.GoodsService;
import service.ShopCartService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

public class ShopCartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        ShopCartService shopCartService = new ShopCartService();
        String action = req.getParameter("action");
        switch (action) {
            case "add":
                addShopCart(req, resp, shopCartService);
                break;
            case "load":
                loadShopCart(req, resp, shopCartService);
                break;
            case "get_all_goods":
                getAllGoods(req, resp, shopCartService);
                break;
            case "update":
                updateShop(req, resp, shopCartService);
                break;
            case "delete":
                deleteShop(req, resp, shopCartService);
                break;
        }
    }

    private void updateShop(HttpServletRequest req, HttpServletResponse resp, ShopCartService shopCartService) throws IOException {
        int goodsNo = Integer.parseInt(req.getParameter("goodsNo"));
        int userId = ((User) req.getSession().getAttribute("user")).getId();
        int number = Integer.parseInt(req.getParameter("addNumber"));
        boolean re = shopCartService.updateShopCart(goodsNo, userId, number);
        PrintWriter writer = resp.getWriter();
        if (re) {
            writer.write("success");
        } else {
            writer.write("failed");
        }
    }

    private void deleteShop(HttpServletRequest req, HttpServletResponse resp, ShopCartService shopCartService) throws IOException {
        int goodsNo = Integer.parseInt(req.getParameter("goodsNo"));
        int userId = ((User) req.getSession().getAttribute("user")).getId();
        boolean re = shopCartService.deleteShopCart(goodsNo, userId);
        PrintWriter writer = resp.getWriter();
        if (re) {
            writer.write("success");
        } else {
            writer.write("failed");
        }
    }

    private void getAllGoods(HttpServletRequest req, HttpServletResponse resp, ShopCartService shopCartService) throws IOException {
        GoodsService goodsService = new GoodsService();
        try {
            ArrayList<Goods> goods_list = goodsService.getAllGoodsList();
            Gson gson = new Gson();
            String s = gson.toJson(goods_list);
            resp.getWriter().write(s);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void loadShopCart(HttpServletRequest req, HttpServletResponse resp, ShopCartService shopCartService) throws IOException, ServletException {
        int userId = ((User) req.getSession().getAttribute("user")).getId();
        ArrayList<HashMap<String, Object>> result = shopCartService.getUserShopCart(userId);
        if (result == null) {
            resp.getWriter().write("error");
            return;
        }
        Gson gson = new Gson();
        String r = gson.toJson(result);
        resp.getWriter().write(r);
    }

    private void addShopCart(HttpServletRequest req, HttpServletResponse resp, ShopCartService shopCartService) throws IOException {
        int userId = ((User) req.getSession().getAttribute("user")).getId();
        int goodsId = Integer.parseInt(req.getParameter("goodsId"));
        int number = Integer.parseInt(req.getParameter("number"));
        PrintWriter printWriter = resp.getWriter();
        int num = shopCartService.addToShopCart(userId, goodsId, number);
        if (num > 0) {
            printWriter.write("add_success");
        } else {
            printWriter.write("add_error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
