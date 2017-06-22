<%@ page import="bean.User" %><%--
  Created by IntelliJ IDEA.
  User: jiyang
  Date: 17-6-22
  Time: 上午8:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <script type="application/javascript" src="js/jquery-3.2.1.js"></script>
    <link href="bootstrap-3/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <title>某宝网|管理</title>
    <script>
        function switchWell(num) {
            document.getElementById("li_1").className = "";
            document.getElementById("li_2").className = "";
            document.getElementById("li_3").className = "";
            document.getElementById("li_" + num).className = "active";
            document.getElementById("well_1").style.display = "none";
            document.getElementById("well_2").style.display = "none";
            document.getElementById("well_3").style.display = "none";
            document.getElementById("well_" + num).style.display = "block";
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
                        location.href = "index.jsp";
                    }, error: function (msg) {
                        console.log('error:' + msg);
                    }
                }
            );
        }
        function getData() {
            getOrder();
            getGoods();
            getUser();
        }
        function getOrder() {
            $.ajax({
                type: "post", url: "order.do", dataType: "json", async: "true",
                data: {
                    "action": "get_all_order"
                }, success: function (msg) {
                    console.log(msg);
                    document.getElementById("loading").style.display = "none";
                    setOrder(msg);
                }, error: function (error) {
                    console.log(error);
                    document.getElementById("loading").style.display = "none";
                }
            });
        }
        function setOrder(jsonData) {
            var well_1 = document.getElementById("well_1");
            var d = '';
            if (jsonData.length < 1) {
                well_1.innerHTML = "<h1>无订单</h1>";
                return;
            }
            for (var i = 0; i < jsonData.length; i++) {
                var content = '<div class="panel panel-heading"><table class="table"> <thead> <tr> <th>订单编号</th> <th>下单时间</th> <th>送货地址</th><th>购买用户</th> <th>手机号码</th><th></th> </tr> </thead> <tbody><tr>';
                var order = jsonData[i];
                var orderId = order['orderId'];
                var orderSerial = order['serialNumber'];
                var address = order['address'];
                var date = order['orderDate'];
                var goodsMap = order['goodsMap'];
                var phone = order['phoneNumber'];
                var userId = order['orderUserId'];
                var over = order['hasOver'];
                content += '<td>' + orderId + '</td>';
                content += '<td>' + date + '</td>';
                content += '<td>' + address + '</td>';
                content += '<td>' + userId + '</td>';
                content += '<td>' + phone + '</td>';
                if (over) {
                    content += '<td><a class="btn btn-success">已接单</a></td>';
                } else {
                    content += "<td id='" + orderId + "'><button class='btn btn-primary' onclick='updateOrder(" + orderId + "," + JSON.stringify(goodsMap) + ")'>接单</button></td>";
                }
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
            well_1.innerHTML = d;
        }
        function updateOrder(orderId, msg) {
            document.getElementById(orderId).innerHTML = "<a class='btn btn-success'>更新中...</a>";
            $.ajax({
                type: "post", url: "order.do", dataType: "text", async: "true",
                data: {
                    "action": "update",
                    "orderId": orderId,
                    "msg": JSON.stringify(msg)
                },
                success: function (m) {
                    if (m === 'ok') {
                        document.getElementById(orderId).innerHTML = "<a class='btn btn-success'>已接单</a>";
                    } else {
                        document.getElementById(orderId).innerHTML = "<button class='btn btn-danger' onclick='updateOrder(" + orderId + "," + JSON.stringify(msg) + ")'>请重试</button>";
                    }
                }, error: function (error) {
                    document.getElementById(orderId).innerHTML = error + "<br><button class='btn btn-danger' onclick='updateOrder(" + orderId + "," + JSON.stringify(msg) + ")'>请重试</button>";
                }
            });
        }
        function getGoods() {
            $.ajax({
                type: "post",
                url: "shopcart.do",
                dataType: "json",
                async: "true",
                data: {
                    "action": "get_all_goods"
                }, success: function (m) {
                    setGoods(m);
                }, error: function (error) {

                }
            });
        }
        function setGoods(m) {
            var well_2 = document.getElementById("well_2_2");
            var content = "<table class='table'><thead><tr><th>图片</th><th>编号</th><th>名称</th><th>用途</th><th>类型</th><th>库存</th><th>价格</th><th></th></tr></thead><tbody>";
            for (var i = 0; i < m.length; i++) {
                goods = m[i];
                content += "<tr><td><img src='%1' style='height: 100px'></td><td>%2</td><td>%3</td><td>%4</td><td>%5</td><td>%6</td><td>%7</td><td><button class='btn btn-warning' onclick='editGoods(" + JSON.stringify(goods) + ")'>修改</button></td></tr>";
                content = String.format(content, goods['pic'], goods['id'], goods['name'], goods['useWay'], goods['type'], goods['stock'], goods['price']);
            }
            content += "</tbody></table>";
            well_2.innerHTML = content;
        }
        function getUser(m) {

        }
        function setUser(m) {

        }

        function editGoods(goods) {
            console.log(goods);
            location.href = "goods.do?action=edit&goodsNo=" + goods['id'];
        }

        String.format = function (str) {
            var args = arguments, re = new RegExp("%([1-" + args.length + "])", "g");
            return String(str).replace(
                re,
                function ($1, $2) {
                    return args[$2];
                }
            );
        };
    </script>
</head>
<body onload="getData()">
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
    <ul class="nav nav-tabs nav-justified">
        <li id="li_1" role="presentation" class="active"><a href="javascript:switchWell(1)">订单管理</a></li>
        <li id="li_2" role="presentation"><a href="javascript:switchWell(2)">商品管理</a></li>
        <li id="li_3" role="presentation"><a href="javascript:switchWell(3)">用户管理</a></li>
    </ul>
    <div>
        <img src="imgs/loading.gif" style="width: 50%;" id="loading">
        <div class="well" id="well_1">
            <h1>订单管理</h1>
        </div>
        <div class="well" id="well_2" style="display: none">
            <a href="edit_goods.jsp" class="btn btn-success"><span class="glyphicon glyphicon-plus"></span>添加</a>
            <h1>商品管理</h1>
            <div class="well" id="well_2_2">

            </div>
        </div>
        <div class="well" id="well_3" style="display: none">
            <h1>用户管理</h1>
        </div>
    </div>
</div>
</body>
</html>
