<%@ page import="bean.User" %><%--
  Created by IntelliJ IDEA.
  User: jiyang
  Date: 17-6-21
  Time: 上午8:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <title>我的订单</title>
    <link href="bootstrap-3/css/bootstrap.min.css" type="text/css" rel="stylesheet">
    <script src="js/jquery-3.2.1.js"></script>
    <script>
        function setData(jsonData) {
            console.log(jsonData);
            var tableContent = document.getElementById("content");
            var d = '';
            for (var i = 0; i < jsonData.length; i++) {
                var content = '<div class="well well-sm"><table class="table"> <thead> <tr> <th>订单编号</th> <th>下单时间</th> <th>送货地址</th> <th>手机号码</th> </tr> </thead> <tbody><tr>';
                var order = jsonData[i];
                var orderId = order['orderId'];
                var orderSerial = order['serialNumber'];
                var address = order['address'];
                var date = order['orderDate'];
                var goodsMap = order['goodsMap'];
                var phone = order['phoneNumber'];
                content += '<td>' + orderId + '</td>';
                content += '<td>' + date + '</td>';
                content += '<td>' + address + '</td>';
                content += '<td>' + phone + '</td>';
                content += '</tr></tbody></table>';
                content += '<table class="table"><thead><thead><th>商品名称</th><th>类型</th><th>用途</th><th>价格</th><th>购买数量</th><th>图片</th></thead><tbody>';
                for (var j = 0; j < goodsMap.length; j++) {
                    var goods = goodsMap[j]['goods'];
                    var number = goodsMap[j]['number'];
                    var goodsId = goods['id'];
                    var goodsName = goods['name'];
                    var useWay = goods['useWay'];
                    var type = goods['type'];
                    var price = goods['price'];
                    var pic = goods['pic'];
                    content += '<tr>';
                    content += '<td>' + goodsName + '</td>';
                    content += '<td>' + useWay + '</td>';
                    content += '<td>' + type + '</td>';
                    content += '<td>' + price + '</td>';
                    content += '<td>' + number + '</td>';
                    content += '<td><img src="' + pic + '" style="height:100px ;;"></td>';
                    content += '</tr>';
                }
                content += '</tbody></table></div>';
                d += content;
            }
            tableContent.innerHTML = d;
        }
        function getOrder() {
            $.ajax({
                type: "post", dataType: "json", async: "true", url: "/order.do",
                data: {
                    "action": "get"
                }, success: function (msg) {
                    document.getElementById("loading").style.display = "none";
                    setData(msg);
                }, error: function (error) {
                    console.log("error:" + error);
                }
            });
        }
    </script>
</head>
<body onload="getOrder()">
<%User user = (User) session.getAttribute("user");%>
<nav class="navbar navbar-default" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <a href="index.jsp" class="navbar-brand">某宝网|我的订单</a>
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
                            "<li><a href=\"javascript:logOut()\"><span class=\"glyphicon glyphicon-log-in\"></span>注销</a></li>" +
                            "<li><a href=\"/shopCar.jsp\"><span class=\"glyphicon glyphicon-shopping-cart\"></span>查看购物车</a></li>" +
                            "<li><a href=\"/order.jsp\"><span class=\"glyphicon glyphicon-certificate\"></span>我的订单</a></li>"
                    );
                }
            %>
        </ul>
    </div>
</nav>
<div class="container text-center">
    <img src="imgs/loading.gif" style="width: 50%" id="loading">
    <div id="content">

    </div>
</div>
</body>
</html>
