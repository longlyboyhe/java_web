<%--
  Created by IntelliJ IDEA.
  User: jiyang
  Date: 17-6-16
  Time: 下午5:12
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册</title>
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <link href="bootstrap-3/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <script src="bootstrap-3/js/bootstrap.min.js"></script>
    <script src="js/main.js"></script>
</head>
<body>
<div class="container">
    <h1>注册</h1>
    <%request.setAttribute("action", "register");%>
    <form action="register.do" method="post" onsubmit="return checkRegisterInput()" role="form">
        <input id="username" type="text" name="name" placeholder="帐号" class="form-control">
        <input id="pwd" type="password" name="pwd" placeholder="密码" class="form-control">
        <input id="nick_name" type="text" name="nick_name" placeholder="昵称" class="form-control">
        <input id="phone_num" type="tel" name="phone_num" placeholder="手机号" class="form-control">
        <input class="radio-button" type="radio" name="identity" value="normal" checked="checked">普通用户
        <input class="radio-button" type="radio" name="identity" value="admin">管理员
        <div class="btn-group">
            <input class="btn btn-default" type="submit" value="注 册">
            <input class="btn btn-default" type="reset" value="清 空">
        </div>
    </form>
    <p class="error">${register_info}</p>
</div>
</body>
</html>
