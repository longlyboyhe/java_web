<%@ page import="bean.Goods" %>
<%@ page import="bean.User" %><%--
  Created by IntelliJ IDEA.
  User: jiyang
  Date: 17-6-16
  Time: 下午3:30
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>商品编辑</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <link href="bootstrap-3/css/bootstrap.css" rel="stylesheet" type="text/css">
    <link href="bootstrap-3/css/bootstrap-theme.css" rel="stylesheet" type="text/css">
    <link href="css/main.css" rel="stylesheet" type="text/css">
    <script src="js/main.js"></script>
</head>
<body>
<%User user = (User) session.getAttribute("admin");%>
<nav class="navbar navbar-default" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <a href="index.jsp" class="navbar-brand">某宝网</a>
        </div>
    </div>
    <div>
        <ul class="nav navbar-nav">
            <%
                if (user == null) {
                    out.println("<li><a href=\"register.jsp\"><span class=\"glyphicon glyphicon-user\"></span>注册</a></li>" +
                            "<li ><a href=\"/log.jsp\"><span class=\"glyphicon glyphicon-user\"></span>登录</a></li>");
                } else {
                    out.println("<li><a><span class=\"glyphicon glyphicon-user\"></span>" + user.getNickName() + "</a></li>" +
                            "<li><a href=\"javascript:logOut()\"><span class=\"glyphicon glyphicon-log-in\"></span>注销</a></li>");
                }
            %>
        </ul>
    </div>
</nav>
<div class="container text-center">
    <%
        if (user == null) {
            out.println("<h1>请登录!</h1>");
            return;
        }
    %>
    <%
        String info = (String) request.getAttribute("info");
        if (info != null) {
            out.println("<p class=\"label label-info\">" + info + "</p>");
        }
    %>

    <%
        Goods goods = (Goods) request.getAttribute("goods");
        String s = "<h1>%s</h1>" +
                "    <form action=\"goods.do?action=%s\" method=\"post\" role=\"form\">" +
                "        <input class=\"form-control\" type=\"number\" name=\"no\" placeholder=\"%s\" disabled=\"%s\"><br>" +
                "        <input class=\"form-control\" type=\"text\" name=\"name\" placeholder=\"%s\"><br>" +
                "        <input class=\"form-control\" type=\"text\" name=\"useWay\" placeholder=\"%s\"><br>" +
                "        <input class=\"form-control\" type=\"text\" name=\"type\" placeholder=\"%s\"><br>" +
                "        <input class=\"form-control\" type=\"number\" name=\"stock\" placeholder=\"%s\"><br>" +
                "        <input class=\"form-control\" type=\"number\" name=\"price\" placeholder=\"%s\"><br>" +
                "        <div class=\"btn-group btn-group-xs\">" +
                "            <input class=\"btn btn-default\" type=\"submit\" value=\"确 定 \">" +
                "            <input class=\"btn btn-default\" type=\"button\" onclick=\"history.back()\" value=\"取 消\">" +
                "        </div>" +
                "    </form>";
        if (goods != null) {
            s = String.format(s, "修改商品:[" + goods.getName() + "]", "update", "true", goods.getId(), goods.getName(), goods.getUseWay(), goods.getType(), goods.getStock(), goods.getPrice());
            s += "<img src=\"" + goods.getPic() + "\">";
        } else {
            s = String.format(s, "增加商品", "add", "false", "商品编号", "商品名称", "用途", "商品类型", "库存", "价格");
        }
        out.println(s);
    %>
    <form action="goods.do?action=upload_image" method="post" role="form" enctype="multipart/form-data">
        <input type="file">
        <input class="btn btn-success" type="submit" value="上传">
    </form>
</div>
</body>
</html>
