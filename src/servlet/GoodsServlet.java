package servlet;

import bean.Goods;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import service.GoodsService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;


public class GoodsServlet extends HttpServlet {

    //上传文件存储目录
    private static final String UPLOAD_DIRECTORY = "upload";
    // 上传配置
    private static final int MEMORY_THRESHOLD = 1024 * 1024 * 3;  // 3MB
    private static final int MAX_FILE_SIZE = 1024 * 1024 * 40; // 40MB
    private static final int MAX_REQUEST_SIZE = 1024 * 1024 * 50; // 50MB

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        GoodsService goodsService = new GoodsService();
        switch (action) {
            case "add":
                Goods addGoods = getGoods(request, response);
                boolean re = false;
                try {
                    re = goodsService.insertGoods(addGoods);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                if (re) {
                    response.sendRedirect("admin.jsp");
                } else {
                    request.setAttribute("info", "编辑失败，请重试");
                    request.getRequestDispatcher("edit_goods.jsp").forward(request, response);
                }
                break;
            case "update":

                break;
            case "edit":
                int goodsNo = Integer.parseInt(request.getParameter("goodNo"));
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

    private Goods getGoods(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int goodsNo = Integer.parseInt(request.getParameter("no"));
        String name = request.getParameter("name");
        String useWay = request.getParameter("useWay");
        String type = request.getParameter("type");
        int stock = Integer.parseInt(request.getParameter("stock"));
        float price = Float.parseFloat(request.getParameter("price"));
        String pic = saveImage(request, response);
        return new Goods(goodsNo, name, type, useWay, price, pic, stock);
    }

    private String saveImage(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // 检测是否为多媒体上传
        if (!ServletFileUpload.isMultipartContent(request)) {
            // 如果不是则停止
            PrintWriter writer = response.getWriter();
            writer.println("Error: 表单必须包含 enctype=multipart/form-data");
            writer.flush();
            return null;
        }
        // 配置上传参数
        DiskFileItemFactory factory = new DiskFileItemFactory();
        // 设置内存临界值 - 超过后将产生临时文件并存储于临时目录中
        factory.setSizeThreshold(MEMORY_THRESHOLD);
        // 设置临时存储目录
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
        ServletFileUpload upload = new ServletFileUpload(factory);
        // 设置最大文件上传值
        upload.setFileSizeMax(MAX_FILE_SIZE);
        // 设置最大请求值 (包含文件和表单数据)
        upload.setSizeMax(MAX_REQUEST_SIZE);
        // 中文处理
        upload.setHeaderEncoding("UTF-8");
        // 构造临时路径来存储上传的文件
        // 这个路径相对当前应用的目录
        String uploadPath = getServletContext().getRealPath("./") + File.separator + UPLOAD_DIRECTORY;

        // 如果目录不存在则创建
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }
        String filePath = "";
        try {
            // 解析请求的内容提取文件数据
            @SuppressWarnings("unchecked")
            List<FileItem> formItems = upload.parseRequest(request);
            if (formItems != null && formItems.size() > 0) {
                // 迭代表单数据
                for (FileItem item : formItems) {
                    // 处理不在表单中的字段
                    if (!item.isFormField()) {
                        String fileName = new File(item.getName()).getName();
                        filePath = uploadPath + File.separator + fileName;
                        File storeFile = new File(filePath);
                        // 在控制台输出文件的上传路径
                        System.out.println(filePath);
                        // 保存文件到硬盘
                        item.write(storeFile);
                    }
                }
            }
        } catch (Exception ex) {
            request.setAttribute("message",
                    "错误信息: " + ex.getMessage());
        }
        return filePath;
    }

}
