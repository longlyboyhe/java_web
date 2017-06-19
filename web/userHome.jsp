<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="bean.User" %>
<html>
<head>
    <title>UserHome</title>
    <script type="application/javascript" src="js/jquery-3.2.1.js"></script>
    <script type="application/javascript">
        function addToShopCart(userId, stock, goodsId) {
            var str_addNumber = window.prompt("输入添加到购物车的数目:", 1);
            var addNumber = parseInt(str_addNumber);
            if (addNumber > stock) {
                alert("添加数目大于库存!");
                return;
            }
            var actionInfo = document.getElementById("action_info");
            $.ajax({
                type: "get",
                url: "shopcart.do",
                dataType: "text",
                async: "true",
                data: {
                    "action": "add",
                    "userId": userId,
                    "goodsId": goodsId,
                    "number": addNumber
                },
                success: function (msg) {
                    console.log(msg);
                    if (msg == "add_success") {
                        actionInfo.innerHTML = "添加成功";
                        loadUserShop(userId);
                    }
                },
                error: function (result, status, xhr) {
                    actionInfo.innerHTML = "请求出错";
                }
            });
        }

        function loadUserShop(userId) {
            $.ajax({
                type: "get",
                url: "shopcart.do",
                dataType: "json",
                async: "true",
                data: {
                    "action": "load",
                    "userId": userId,
                },
                success: function (msg) {
                    var cart = document.getElementById("shop_cart");
                    console.log(msg);
                    data = "<h1>购物车列表</h1><table><th>商品编号</th><th>数量</th>";
                    for (var i = 0; i < msg.length; i++) {
                        num = msg[i].number;
                        gId = msg[i].goodsId;
                        data += "<tr><td>" + num + "</td>" + "<td>" + gId + "</td></tr>";
                    }
                    cart.innerHTML = data;
                },
                error: function (result, status, xhr) {
                    alert(result + status + xhr);
                }
            });
        }
    </script>
</head>
<body onload="loadUserShop(${u.id})">
<div class="main_box" style="margin:0 auto; text-align: center;">
    <h2>Welcome ${u.getNickName()}</h2>
    <p>选择你喜欢的商品</p>
    <p id="action_info" style="font-size: 20px;"></p>
    <table border="1px" style="width: 100%;">
        <tr>
            <th>编号</th>
            <th>名称</th>
            <th>类型</th>
            <th>用途</th>
            <th>库存</th>
            <th>价格</th>
            <th>图片</th>
            <th>操作</th>
        </tr>
        <c:forEach var="map" items="${goods_list}">
            <tr>
                <td>${map.goods.id}</td>
                <td>${map.goods.name}</td>
                <td>${map.goods.type}</td>
                <td>${map.goods.useWay}</td>
                <td>${map.stock}</td>
                <td>${map.goods.price}</td>
                <td>${map.goods.pic}</td>
                <td>
                    <a href="javascript:addToShopCart(${u.id},${map.stock},${map.goods.id});">添加购物车</a>
                    <br>
                    <a href="">购买</a>
                </td>
            </tr>
        </c:forEach>
    </table>
    <div id="shop_cart"></div>
</div>
</body>
</html>
