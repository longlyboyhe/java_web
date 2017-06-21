<%@ page import="bean.Goods" %>
<%@ page import="bean.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%--
  Created by IntelliJ IDEA.
  User: jiyang
  Date: 17-6-21
  Time: 上午10:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>下单</title>
    <meta http-equiv="content-type" content="text/html;charset=utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <script type="application/javascript" src="js/jquery-3.2.1.js"></script>
    <link href="bootstrap-3/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <script>
        function makeOrder() {
            var a = document.getElementById("address");
            var p = document.getElementById("phoneNumber");
            if (a.value === '') {
                alert("地址不能为空");
                return false;
            }
            var address = a.value;
            var phone = p.value;
            document.getElementById("input_order").style.display = 'none';
            document.getElementById("loading").style.display = 'block';
            $.ajax({
                type: "post",
                dataType: "text",
                url: "/order.do",
                async: "true",
                data: {
                    "action": "insert",
                    "address": address,
                    "phoneNumber": phone
                },
                success: function (msg) {
                    if (msg === "ok") {
                        var i = 5;
                        setInterval(function () {
                            document.getElementById("info").innerHTML = i + "秒跳转商品列表";
                            if (i <= 0) {
                                location.href = "/index.jsp";
                            }
                            i--;
                        }, 1000);
                        document.getElementById("loading").style.display = 'none';
                        document.getElementById("input_order").style.display = 'block';
                        document.getElementById("input_order").innerHTML = '<h1>下单成功</h1><a href="/order.jsp" class="btn btn-primary"><span class="glyphicon glyphicon-certificate"></span>查看您的订单</a>';
                    } else {
                        document.getElementById("loading").style.display = 'none';
                        document.getElementById("input_order").style.display = 'block';
                    }

                }, error: function (msg) {
                    alert("错误" + msg);
                    document.getElementById("loading").style.display = 'none';
                    document.getElementById("input_order").style.display = 'block';
                }
            });
        }

    </script>
</head>
<body>
<%
    User user = (User) session.getAttribute("user");
    ArrayList<HashMap<String, Object>> array = (ArrayList<HashMap<String, Object>>) request.getAttribute("array");
%>
<nav class="navbar navbar-default" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <a href="/index.jsp" class="navbar-brand">某宝网|确定订单</a>
        </div>
    </div>
    <div>
        <ul class="nav navbar-nav">
            <%
                out.println("<li><a><span class=\"glyphicon glyphicon-user\"></span>" + user.getNickName() + "</a></li>" +
                        "<li><a href=\"javascript:logOut()\"><span class=\"glyphicon glyphicon-log-in\"></span>注销</a></li>" +
                        "<li><a href=\"/shopCar.jsp\"><span class=\"glyphicon glyphicon-shopping-cart\"></span>查看购物车</a></li>" +
                        "<li><a href=\"/order.jsp\"><span class=\"glyphicon glyphicon-certificate\"></span>我的订单</a></li>"
                );
            %>
        </ul>
    </div>
</nav>
<div class="container text-center">
    <p id="info" style="font-weight: bold;font-size: 20px;"></p>
    <img src="imgs/loading.gif" style="width: 50%; display: none;" id="loading">
    <div id="input_order">
        <h1>填写订单信息</h1>
        <form role="form">
            <input id="address" type="text" class="form-control" name="address" placeholder="地址"><br>
            <input id="phoneNumber" type="tel" class="form-control" name="phoneNumber"
                   placeholder="<%=user.getPhoneNum()%>"><br>
            <button type="button" class="btn btn-danger" onclick="makeOrder()">确定</button>
        </form>
        <hr>
        <h1>订单信息</h1>
        <table class="table">
            <thead>
            <tr>
                <th>商品详情</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <%
                    out.print("<td><tr><th>名称</th><th>单价</th><th>数量</th><th></th></tr>");
                    int sum = 0;
                    for (HashMap<String, Object> hashMap : array) {
                        Goods goods = (Goods) hashMap.get("goods");
                        int number = (int) hashMap.get("number");
                        String s = "<tr><td>%s</td><td>%s</td><td class=\"badge\">%s</td><td><img src=\"%s\" style=\"height:100px;\"></td></tr>";
                        s = String.format(s, goods.getName(), goods.getPrice(), number, goods.getPic());
                        out.println(s);
                        sum += goods.getPrice() * number;
                    }
                    out.print("</td>");
                    String s = "<td>总计:</td><td>%s元</td>";
                    s = String.format(s, sum);
                    out.println(s);
                %>
            </tr>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
