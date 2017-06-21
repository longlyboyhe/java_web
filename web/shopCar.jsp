<%@ page import="bean.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>购物车</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <script src="js/jquery-3.2.1.js"></script>
    <link href="bootstrap-3/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="css/main.css" rel="stylesheet" type="text/css">
    <script>
        function getAllShop() {
            $.ajax({
                type: "post",
                url: "/shopcart.do",
                dataType: "json",
                async: "true",
                data: {
                    "action": "load"
                }, success: function (msg) {
                    document.getElementById("loading").style.display = 'none';
                    var list = document.getElementById("list");
                    var sum = 0;
                    s = '<table class="table"><tbody><tr><th>图片</th><th>商品名</th><th>库存</th><th>数量</th><th>单价</th><th>总计</th><th></th><th></th></tr>';
                    for (var i = 0; i < msg.length; i++) {
                        goods = msg[i]['goods'];
                        number = msg[i]['number'];
                        itemSum = goods.price * number;
                        if (number < 1) {
                            s += '<tr><td><img src="' + goods.pic + '" style="height: 100px;"></td><td>' + goods.name + '</td><td>' + goods.stock + '</td><td>' + number + '</td><td>' + goods.price + '</td><td>' + itemSum + '</td><td><button type="button" class="btn btn-danger" onclick="update(' + goods.id + ',1)">+</button> <button type="button" class="btn btn-warning">-</button><br><br><button type="button" class="btn btn-default" onclick="remove(' + goods.id + ')">删除</button></td></tr>';
                        } else if (number >= 0 && number < goods.stock) {
                            s += '<tr><td><img src="' + goods.pic + '" style="height: 100px;"></td><td>' + goods.name + '</td><td>' + goods.stock + '</td><td>' + number + '</td><td>' + goods.price + '</td><td>' + itemSum + '</td><td><button type="button" class="btn btn-danger" onclick="update(' + goods.id + ',1)">+</button> <button type="button" class="btn btn-default" onclick="update(' + goods.id + ',-1)">-</button><br><br><button type="button" class="btn btn-default" onclick="remove(' + goods.id + ')">删除</button></td></tr>';
                        } else {
                            s += '<tr><td><img src="' + goods.pic + '" style="height: 100px;"></td><td>' + goods.name + '</td><td>' + goods.stock + '</td><td>' + number + '</td><td>' + goods.price + '</td><td>' + itemSum + '</td><td><button type="button" class="btn btn-warning">+</button> <button type="button" class="btn btn-default" onclick="update(' + goods.id + ',-1)">-</button><br><br><button type="button" class="btn btn-default" onclick="remove(' + goods.id + ')">删除</button></td></tr>';
                        }
                        sum += itemSum;
                    }
                    if (sum < 1) {
                        s += '<tr><td></td><td></td><td></td><td>总计</td><td><span id="sum">' + sum + '</span>元</td><td></td></tr>';
                    }
                    else {
                        s += "<tr><td></td><td></td><td></td><td>总计</td><td><span id='sum'>" + sum + "</span>元</td><td id='make_order_btn'><button type='button' class='btn btn-danger' onclick='makeOrder()'>下单</button></td></tr>";
                    }
                    s += '</tbody></table>';
                    list.innerHTML = s;
                }, error: function (msg) {

                }
            });
        }
        function update(goodsNo, number) {
            $.ajax(
                {
                    type: "post",
                    url: "/shopcart.do",
                    dataType: "text",
                    async: "true",
                    data: {
                        "action": "update",
                        "goodsNo": goodsNo,
                        "addNumber": number
                    }, success: function (msg) {
                    getAllShop();
                }, error: function (msg) {

                }
                }
            );
        }
        function remove(goodsNo) {
            var sure = confirm("确定删除?");
            if (sure) {
                $.ajax(
                    {
                        type: "post",
                        url: "/shopcart.do",
                        dataType: "text",
                        async: "true",
                        data: {
                            "action": "delete",
                            "goodsNo": goodsNo
                        }, success: function (msg) {
                        getAllShop();
                    }, error: function (msg) {

                    }
                    }
                );
            }
            else {
                return false;
            }
        }
        function makeOrder() {
            location.href = "/order.do?action=make";
        }
    </script>
</head>
<body onload="getAllShop()">
<nav class="navbar navbar-default" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <a href="index.jsp" class="navbar-brand">某宝网|购物车</a>
        </div>
    </div>
    <div>
        <ul class="nav navbar-nav">
            <li id="login"><a><span class="glyphicon glyphicon-user"></span>
                <%
                    User user = (User) session.getAttribute("user");
                    if (user == null) {
                        out.print("未登录");
                    } else {
                        out.print(user.getNickName());
                    }
                %>
            </a>
            </li>
            <li><a href="index.jsp"><span class="glyphicon glyphicon-user"></span>商品列表</a></li>
            <%
                if (user != null) {
                    out.println("<li><a href=\"/order.jsp\"><span class=\"glyphicon glyphicon-certificate\"></span>我的订单</a></li>");
                }
            %>
        </ul>
    </div>
</nav>
<div class="container text-center">
    <img id="loading" src="imgs/loading.gif" style="width: 50%">
    <div id="list">
    </div>
</div>
</body>
</html>
