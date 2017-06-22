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
    <script src="js/jquery-3.2.1.js"></script>
    <link href="css/main.css" rel="stylesheet" type="text/css">
    <script>
        function selectImage(file) {
            if (!file.files || !file.files[0]) {
                return;
            }
            var reader = new FileReader();
            reader.onload = function (evt) {
                document.getElementById("image").src = evt.target.result;
                image = evt.target.result;
            };
            reader.readAsDataURL(file.files[0]);
        }
        function updateGoods(pic) {
            var loading = document.getElementById("loading");
            var well = document.getElementById("content");
            loading.style.display = "block";
            well.style.display = "none";
            var goodsNo = document.getElementById("goodsNo").value;
            var goodsName = document.getElementById("goodsName").value;
            var goodsType = document.getElementById("goodsType").value;
            var goodsUseWay = document.getElementById("goodsUseWay").value;
            var goodsStock = document.getElementById("goodsStock").value;
            var goodsPrice = document.getElementById("goodsPrice").value;
            $.ajax({
                type: "post", dataType: "text", url: "goods.do", async: "true",
                data: {
                    "action": "update",
                    "goodsNo": goodsNo,
                    "goodsName": goodsName,
                    "goodsType": goodsType,
                    "goodsUseWay": goodsUseWay,
                    "goodsStock": goodsStock,
                    "goodsPrice": goodsPrice,
                    "image": image,
                    "pic": pic
                }, success: function (m) {
                    loading.style.display = "none";
                    well.style.display = "block";
                    successShow(m, well);
                }, error: function (m) {
                    alert("错误:" + m);
                    loading.style.display = "none";
                    well.style.display = "block";
                }
            });
        }
        function successShow(m, well) {
            if (m === 'ok') {
                well.innerHTML = "<a href='admin.jsp' class='btn btn-primary'>上传成功，返回商品列表</a>" +
                    "<br><br><button onclick='location.reload()' class='btn btn-primary'>继续操作</button>";
            }
        }
        function addGoods() {
            var loading = document.getElementById("loading");
            var well = document.getElementById("content");
            loading.style.display = "block";
            well.style.display = "none";
            var goodsNo = document.getElementById("goodsNo").value;
            var goodsName = document.getElementById("goodsName").value;
            var goodsType = document.getElementById("goodsType").value;
            var goodsUseWay = document.getElementById("goodsUseWay").value;
            var goodsStock = document.getElementById("goodsStock").value;
            var goodsPrice = document.getElementById("goodsPrice").value;
            $.ajax({
                type: "post", dataType: "text", url: "goods.do", async: "true",
                data: {
                    "action": "add",
                    "goodsNo": goodsNo,
                    "goodsName": goodsName,
                    "goodsType": goodsType,
                    "goodsUseWay": goodsUseWay,
                    "goodsStock": goodsStock,
                    "goodsPrice": goodsPrice,
                    "image": image
                }, success: function (m) {
                    loading.style.display = "none";
                    well.style.display = "block";
                    successShow(m, well);
                }, error: function (m) {
                    alert("错误:" + m);
                    loading.style.display = "none";
                    well.style.display = "block";
                }
            });
        }
    </script>

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
    <img src="imgs/loading.gif" style="width: 50%;display: none;" id="loading"/>
    <div class="well" id="content">
        <%
            Goods goods = (Goods) request.getAttribute("goods");
            if (goods != null) {
                String s = "<h1>%s</h1>" +
                        "        <input id=\"goodsNo\" class=\"form-control\" type=\"number\" name=\"no\" value=\"%s\" disable=\"true\"><br>" +
                        "        <input id=\"goodsName\" class=\"form-control\" type=\"text\" name=\"name\" value=\"%s\"><br>" +
                        "        <input id=\"goodsUseWay\" class=\"form-control\" type=\"text\" name=\"useWay\" value=\"%s\"><br>" +
                        "        <input id=\"goodsType\" class=\"form-control\" type=\"text\" name=\"type\" value=\"%s\"><br>" +
                        "        <input id=\"goodsStock\" class=\"form-control\" type=\"number\" name=\"stock\" value=\"%s\"><br>" +
                        "        <input id=\"goodsPrice\" class=\"form-control\" type=\"number\" name=\"price\" value=\"%s\"><br>" +
                        "        <input type=\"file\" onchange=\"selectImage(this)\">" +
                        "        <div class=\"btn-group btn-group-xs\">" +
                        "            <input class=\"btn btn-default\" type=\"button\" onclick=\"updateGoods('%s')\" value=\"确 定 \">" +
                        "            <input class=\"btn btn-default\" type=\"button\" onclick=\"history.back()\" value=\"取 消\">" +
                        "        </div><br>";
                s = String.format(s, "修改商品:[" + goods.getName() + "]", goods.getId(), goods.getName(), goods.getUseWay(), goods.getType(), goods.getStock(), goods.getPrice(), goods.getPic());
                s += "<img src=\"" + goods.getPic() + "\">";
                out.print(s);
            } else {
                String s = "<h1>%s</h1>" +
                        "        <input id=\"goodsName\" class=\"form-control\" type=\"text\" name=\"name\" placeholder=\"%s\"><br>" +
                        "        <input id=\"goodsUseWay\" class=\"form-control\" type=\"text\" name=\"useWay\" placeholder=\"%s\"><br>" +
                        "        <input id=\"goodsType\" class=\"form-control\" type=\"text\" name=\"type\" placeholder=\"%s\"><br>" +
                        "        <input id=\"goodsStock\" class=\"form-control\" type=\"number\" name=\"stock\" placeholder=\"%s\"><br>" +
                        "        <input id=\"goodsPrice\" class=\"form-control\" type=\"number\" name=\"price\" placeholder=\"%s\"><br>" +
                        "        <input type=\"file\" onchange=\"selectImage(this)\">" +
                        "        <div class=\"btn-group btn-group-xs\">" +
                        "            <input class=\"btn btn-default\" type=\"button\" onclick=\"addGoods()\" value=\"确 定 \">" +
                        "            <input class=\"btn btn-default\" type=\"button\" onclick=\"history.back()\" value=\"取 消\">" +
                        "        </div><br>";
                s = String.format(s, "增加商品", "商品名称", "用途", "商品类型", "库存", "价格");
                out.print(s);
            }
        %>
        <br><br>
        <img src="" id="image"/>
    </div>
</div>
</body>
</html>
