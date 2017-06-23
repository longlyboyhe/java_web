<%@ page import="bean.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=utf-8" language="java" %>
<html>
<head>
    <title>某宝网|商品列表</title>
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <script type="application/javascript" src="js/jquery-3.2.1.js"></script>
    <script src="bootstrap-3/js/bootstrap.min.js" type="javascript"></script>
    <link href="bootstrap-3/css/bootstrap.css" rel="stylesheet" type="text/css">
    <script type="application/javascript">
        function showOrderFrom(stock, goodsId, position, action) {
            if ('null' === '<%=session.getAttribute("user")%>') {
                alert("请先登录");
                return;
            }
            if (action === 0) {
                document.getElementById(position).innerHTML = '<div id="edit_order' + position + '" class="panel panel-primary">' +
                    '<div class="panel-heading">' +
                    '<h3 class="panel-title">添加购物车</h3>' +
                    '</div>' +
                    '<div class="panel-body">' +
                    '<form role="form">' +
                    '<input type="number" id="order_num' + position + '" placeholder="输入添加件数" class="form-control">' +
                    '<br>' +
                    '<button id="submit_btn' + position + '" type="button" class="btn btn-success">添加</button>' +
                    '  <button id="cancel_btn' + position + '" type="button" class="btn btn-default">取消</button>' +
                    '</form>' +
                    '</div>' +
                    '</div>';

                document.getElementById("submit_btn" + position).addEventListener("click", function () {
                    addToShopCart(stock, goodsId, position);
                });

                document.getElementById("cancel_btn" + position).addEventListener("click", function () {
                    closeOrderForm(position);
                })
            } else {
                document.getElementById(position).innerHTML = '<div id="edit_order' + position + '" class="panel panel-primary">' +
                    '<div class="panel-heading">' +
                    '<h3 class="panel-title">确定购物信息</h3>' +
                    '</div>' +
                    '<div class="panel-body">' +
                    '<form role="form">' +
                    '<input type="number" id="order_num' + position + '" placeholder="输入添加件数" class="form-control">' +
                    '<input type="text" id="order_address' + position + '" placeholder="您的地址" class="form-control">' +
                    '<input type="tel" id="order_phone' + position + '" placeholder="您的手机" class="form-control">' +
                    '<br>' +
                    '<button id="submit_btn' + position + '" type="button" class="btn btn-success">添加</button>' +
                    '  <button id="cancel_btn' + position + '" type="button" class="btn btn-default">取消</button>' +
                    '</form>' +
                    '</div>' +
                    '</div>';

                document.getElementById("submit_btn" + position).addEventListener("click", function () {
                    makeOrder(stock, goodsId, position);
                });

                document.getElementById("cancel_btn" + position).addEventListener("click", function () {
                    closeOrderForm(position);
                })
            }

        }

        function makeOrder(stock, goodsNo, position) {
            var number = document.getElementById("order_num" + position).value;
            var address = document.getElementById("order_address" + position).value;
            var phone = document.getElementById("order_phone" + position).value;
            if (number > stock) {
                alert("购买数目大于库存!");
                return;
            }
            if (number < 1) {
                alert("数目必须大于0噢");
                return;
            }
            $.ajax({
                type: "post", url: "order.do", async: "true",
                data: {
                    "action": "insertItem",
                    "number": number,
                    "address": address,
                    "phone": phone,
                    "goodsNo": goodsNo
                }, success: function (m) {
                    console.log(m);
                    if (m === 'ok') {
                        location.href = "order.jsp";
                    } else {
                        alert("操作失败");
                    }
                }, error: function (m) {
                    console.log(m);
                }
            })
        }

        function closeOrderForm(postion) {
            document.getElementById("edit_order" + postion).style.display = "none";
        }

        function addToShopCart(stock, goodsId, position) {
            var number = document.getElementById("order_num" + position).value;
            if (number > stock) {
                alert("添加数目大于库存!");
                return;
            }
            if (number < 1) {
                alert("数目必须大于0噢");
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
                    "number": number
                },
                success: function (msg) {
                    if (msg === "add_success") {
                        closeOrderForm(position);
                        actionInfo.innerHTML = '<a href="/shopCar.jsp" class="btn btn-primary">添加成功，查看购物车</a>';
                    }
                },
                error: function (result, status, xhr) {
                    closeOrderForm(position);
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
                        function getOutStr(goods) {
                            s = "";
                            s += "<div class='col-xs-12 col-sm-12 col-md-" + 12 / column + " col-lg-" + 12 / column + "'><div class='thumbnail'>" +
                                "<img src='{0}' alt=''>" +
                                "<div class='caption'>" +
                                "<h3>{1}</h3>" +
                                "<p><span class='label label-default'>{2} {3} {4}</span></p>" +
                                "<p><span class='label label-info'>{5}</span></p>" +
                                "<p><button onclick='showOrderFrom({4},{6},{6},0)' class='btn btn-danger'><span class='glyphicon glyphicon-plus'></span>加入购物车</button>  " +
                                "<button onclick='showOrderFrom({4},{6},{6},1)' class='btn btn-primary'><span class='glyphicon glyphicon-ok'></span>购买</button>" +
                                "<div id='{6}'></div>" +
                                "</p></div></div></div>";

                            s = s.format(
                                goods['pic'],
                                goods['name'],
                                goods['type'],
                                goods['useWay'],
                                goods['stock'],
                                goods['price'],
                                goods['id']);
                            return s;
                        }

                        document.getElementById("loading_img").style.display = "none";
                        var list = document.getElementById("list");
                        s = "";
                        column = 3;
                        for (var i = 0; i < msg.length; i++) {
                            s += "<div class='row'>";
                            var goods = msg[i];
                            s += getOutStr(goods);
                            ++i;
                            if (i < msg.length) {
                                goods = msg[i];
                                s += getOutStr(goods);
                                ++i;
                                if (i < msg.length) {
                                    goods = msg[i];
                                    s += getOutStr(goods);
                                }
                            }
                            s += "</div>";
                        }
                        list.innerHTML = s;
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

        String.prototype.format = function (args) {
            var result = this;
            if (arguments.length > 0) {
                if (arguments.length == 1 && typeof (args) == "object") {
                    for (var key in args) {
                        if (args[key] != undefined) {
                            var reg = new RegExp("({" + key + "})", "g");
                            result = result.replace(reg, args[key]);
                        }
                    }
                }
                else {
                    for (var i = 0; i < arguments.length; i++) {
                        if (arguments[i] != undefined) {
                            var reg = new RegExp("({[" + i + "]})", "g");
                            result = result.replace(reg, arguments[i]);
                        }
                    }
                }
            }
            return result;
        };
    </script>
</head>

<body onload="getAllGoods()">
<%User user = (User) session.getAttribute("user");%>
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
                            "<li><a href=\"javascript:logOut()\"><span class=\"glyphicon glyphicon-log-in\"></span>注销</a></li>" +
                            "<li><a href=\"/shopCar.jsp\"><span class=\"glyphicon glyphicon-shopping-cart\"></span>查看购物车</a></li>" +
                            "<li><a href=\"/order.jsp\"><span class=\"glyphicon glyphicon-certificate\"></span>我的订单</a></li>"
                    );
                }
            %>
            <li><a href="admin_log.jsp"><span class="glyphicon glyphicon-edit"></span>管理</a></li>
        </ul>
    </div>
</nav>
<div class="container text-center">

    <img id="loading_img" src="imgs/loading.gif"/>

    <div id="list">

    </div>
</div>
</body>
</html>
