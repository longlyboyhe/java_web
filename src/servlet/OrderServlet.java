package servlet;

import bean.Goods;
import bean.Order;
import bean.User;
import com.google.gson.Gson;
import com.sun.org.apache.xpath.internal.operations.Or;
import service.GoodsService;
import service.OrderService;
import service.ShopCartService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

public class OrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        String action = req.getParameter("action");
        switch (action) {
            case "make":
                makeOrder(req, resp);
                break;
            case "insert":
                insertOrder(req, resp);
                break;
            case "get":
                getOrder(req, resp);
                break;
        }
    }

    private void getOrder(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        User user = (User) (req.getSession().getAttribute("user"));
        ArrayList<Order> orders = new OrderService().getAllOrders(user.getId());
        GoodsService gs = new GoodsService();
        for (Order order : orders) {
            for (HashMap<String, Object> map : order.getGoodsMap()) {
                int goodsId = (int) map.get("goods");
                try {
                    Goods goods = gs.getGoodsById(goodsId);
                    map.put("goods", goods);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        Gson gson = new Gson();
        String data = gson.toJson(orders);
        resp.getWriter().write(data);
    }

    private void insertOrder(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        User user = (User) req.getSession().getAttribute("user");
        String address = req.getParameter("address");
        String phone = req.getParameter("phoneNumber");
        if (phone == null || phone.equals("")) {
            phone = user.getPhoneNum();
        }
        ArrayList<HashMap<String, Object>> arrayList = getShopCart(req);
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String date = simpleDateFormat.format(new Date());
        int serialNumber = new Long(System.currentTimeMillis()).intValue();
        Order order = new Order(serialNumber, user.getId(), address, phone, date, arrayList);
        OrderService service = new OrderService();
        boolean re = service.insertOrder(order);
        PrintWriter printWriter = resp.getWriter();
        ShopCartService shopCartService = new ShopCartService();
        if (re) {
            for (HashMap<String, Object> map : arrayList) {
                Goods goods = (Goods) map.get("goods");
                shopCartService.deleteShopCart(goods.getId(), user.getId());
            }
            printWriter.write("ok");
        } else {
            printWriter.write("failed");
        }
    }

    private void makeOrder(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        ArrayList<HashMap<String, Object>> arrayList = getShopCart(req);
        req.setAttribute("array", arrayList);
        req.getRequestDispatcher("/makeOrder.jsp").forward(req, resp);
    }

    private ArrayList<HashMap<String, Object>> getShopCart(HttpServletRequest req) {
        User user = (User) req.getSession().getAttribute("user");
        ShopCartService shopCartService = new ShopCartService();
        return shopCartService.getUserShopCart(user.getId());
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}
