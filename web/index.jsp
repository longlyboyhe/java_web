<%@ page import="bean.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=utf-8" language="java" %>
<html>
<head>
    <title>某宝网|商品列表</title>
    <meta http-equiv="content-type" content="text/html;charset=utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <script type="application/javascript" src="js/jquery-3.2.1.js"></script>
    <link href="bootstrap-3/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <script type="application/javascript">
        function addToShopCart(stock, goodsId) {
            if ('null' === '<%=session.getAttribute("user")%>') {
                alert("请先登录");
                return;
            }
            var str_addNumber = window.prompt("输入添加到购物车的数目:", 1);
            var addNumber = parseInt(str_addNumber);
            if (addNumber > stock) {
                alert("添加数目大于库存!");
                return;
            }
            var actionInfo = document.getElementById("action_info");
            $.ajax({
                type: "post",
                url: "shopcart.do",
                dataType: "text",
                async: "true",
                data: {
                    "action": "add",
                    "goodsId": goodsId,
                    "number": addNumber
                },
                success: function (msg) {
                    if (msg === "add_success") {
                        actionInfo.innerHTML = '<a href="/shopCar.jsp" class="btn btn-primary">添加成功，查看购物车</a>';
                    }
                },
                error: function (result, status, xhr) {
                    actionInfo.innerHTML = "请求出错" + result + status + xhr;
                }
            });
        }
        function getAllGoods() {
            $.ajax({
                    type: "post",
                    url: "shopcart.do",
                    dataType: "json",
                    async: "true",
                    data: {
                        "action": "get_all_goods"
                    }, success: function (msg) {
                        s = '<h1>全部商品</h1><br><div id="action_info"></div><br><table class="table"><tr>' +
                            '<th>图片</th>' +
                            '<th>编号</th>' +
                            '<th>名称</th>' +
                            '<th>类型</th>' +
                            '<th>用途</th>' +
                            '<th>价格</th>' +
                            '<th>库存</th>' +
                            '<th></th>' +
                            '</tr><tbody>';
                        console.log(msg);
                        var list = document.getElementById("list");
                        for (var i = 0; i < msg.length; i++) {
                            goods = msg[i];
                            s += '<tr><td><img src=\"' + goods.pic + '\" style="height: 100px;float: left;"></td>';
                            s += '<td>' + goods.id + '</td>';
                            s += '<td>' + goods.name + '</td>';
                            s += '<td>' + goods.type + '</td>';
                            s += '<td>' + goods.useWay + '</td>';
                            s += '<td>' + goods.price + '</td>';
                            s += '<td>' + goods.stock + '</td>';
                            s += '<td>' +
                                '<a href="javascript:addToShopCart(' + goods.stock + ',' + goods.id + ')" class="btn btn-danger">加入购物车</a>' +
                                ' <a href="#" class="btn btn-primary">购买</a>' +
                                '</td></tr>';
                        }
                        s += '</tbody></table>';
                        list.innerHTML = s;
                        document.getElementById("loading_img").style.display = "none";
                        document.body.style.background = "#fff";
                    }, error: function (msg) {
                        console.log(msg);
                        document.getElementById("loading_img").style.display = "none";
                    }
                }
            )
        }
        function logOut() {
            $.ajax({
                    type: "get",
                    url: "login.do",
                    async: "true",
                    dataType: "text",
                    data: {
                        "action": "log_out"
                    }, success: function (msg) {
                        location.reload(true);
                    }, error: function (msg) {
                        console.log('error:' + msg);
                    }
                }
            );
        }

    </script>
</head>

<body onload="getAllGoods()">
<%User user = (User) session.getAttribute("user");%>
<nav class="navbar navbar-default" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <a href="/index.jsp" class="navbar-brand">某宝网</a>
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
    <img id="loading_img" src="imgs/loading.gif"/>
    <div id="list" class="table-responsive">

    </div>
</div>
</body>
</html>
