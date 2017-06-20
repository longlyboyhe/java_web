<%@ page import="bean.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>购物车</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <link href="bootstrap-3/css/bootstrap.css" rel="stylesheet" type="text/css">
    <link href="css/main.css" rel="stylesheet" type="text/css">
    <script src="js/jquery-3.2.1.js" type="application/javascript"></script>
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
                    s = '<table class="table"><tbody><tr><th>图片</th><th>商品名</th><th>数量</th><th>单价</th><th>总计</th><th></th><th></th></tr>';
                    for (var i = 0; i < msg.length; i++) {
                        goods = msg[i]['goods'];
                        number = msg[i]['number'];
                        itemSum = goods.price * number;
                        s += '<tr><td><img src="' + goods.pic + '" style="height: 100px;"></td><td>' + goods.name + '</td><td>' + number + '</td><td>' + goods.price + '</td><td>' + itemSum + '</td><td><button type="button" class="btn btn-danger" onclick="update(' + goods.id + ',1)">+</button> <button type="button" class="btn btn-default" onclick="update(' + goods.id + ',-1)">-</button><br><br><button type="button" class="btn btn-default" onclick="remove(' + goods.id + ')">删除</button></td></tr>';
                        sum += itemSum;
                    }
                    s += '<tr><td></td><td></td><td></td><td>总计</td><td>' + sum + '元</td><td><a class="btn btn-danger">下单</a></td></tr>';
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
    </script>
</head>
<body onload="getAllShop()">
<nav class="navbar navbar-default" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <a href="index.jsp" class="navbar-brand">某宝网</a>
        </div>
    </div>
    <div>
        <ul class="nav navbar-nav">
            <li id="user_center"></li>
            <li id="login"><a><span class="glyphicon glyphicon-user"></span>
                <%
                    User user = (User) session.getAttribute("user");
                    if (user == null) {
                        out.print("未登录");
                    } else {
                        out.print(user.getNickName());
                    }
                %>
            </a></li>
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
