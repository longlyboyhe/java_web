package servlet;

import bean.Goods;
import service.GoodsService;
import sun.misc.BASE64Decoder;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;


public class GoodsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        GoodsService goodsService = new GoodsService();
        PrintWriter writer = response.getWriter();
        boolean re;
        switch (action) {
            case "add":
                Goods addGoods = getGoods(request);
                re = false;
                try {
                    re = goodsService.insertGoods(addGoods);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                if (re) {
                    writer.print("ok");
                } else {
                    writer.print("failed");
                }
                break;
            case "update":
                int goodsId = Integer.parseInt(request.getParameter("goodsNo"));
                Goods newGoods = getGoods(request);
                newGoods.setId(goodsId);
                re = false;
                try {
                    re = goodsService.updateGoods(newGoods);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                if (re) {
                    writer.print("ok");
                } else {
                    writer.print("failed");
                }
                break;
            case "edit":
                int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
                try {
                    Goods goods = goodsService.getGoodsById(goodsNo);
                    request.setAttribute("goods", goods);
                    request.getRequestDispatcher("edit_goods.jsp").forward(request, response);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                break;
        }
    }

    private Goods getGoods(HttpServletRequest request) throws IOException, ServletException {
        String name = request.getParameter("goodsName");
        String useWay = request.getParameter("goodsUseWay");
        String type = request.getParameter("goodsType");
        int stock = Integer.parseInt(request.getParameter("goodsStock"));
        float price = Float.parseFloat(request.getParameter("goodsPrice"));
        String pic = saveImage(request);
        if (pic == null) {
            pic = request.getParameter("pic");
        }
        return new Goods(name, type, useWay, price, pic, stock);
    }

    private String saveImage(HttpServletRequest request) throws IOException {
        String image = request.getParameter("image");
        if (image == null) {
            return null;
        }
        String header = "data:image/jpeg;base64,";
        if (image.indexOf(header) != 0) {
            return null;
        }
        image = image.substring(header.length());
        BASE64Decoder dec = new BASE64Decoder();
        byte[] decodedBytes = dec.decodeBuffer(image);
        ServletContext context = getServletContext();
        String fileName = "/upload/" + System.currentTimeMillis() + ".jpeg";
        String filePath = context.getRealPath(fileName);
        File file = new File(filePath);
        FileOutputStream out = new FileOutputStream(file);
        out.write(decodedBytes);
        out.close();
        return fileName;
    }

}
