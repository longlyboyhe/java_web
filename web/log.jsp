<%--
  Created by IntelliJ IDEA.
  User: jiyang
  Date: 17-6-16
  Time: 下午3:30
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录</title>
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <link href="bootstrap-3/css/bootstrap.css" rel="stylesheet" type="text/css">
    <link href="bootstrap-3/css/bootstrap-theme.css" rel="stylesheet" type="text/css">
    <link href="css/main.css" rel="stylesheet" type="text/css">
    <script src="js/main.js"></script>
</head>
<body>
<div class="container text-center">
    <h1>登录</h1>
    <form action="login.do" method="post" onsubmit="return checkLoginInput()" role="form">
        <input class="form-control" id="username" type="text" name="name" placeholder="帐号"><br>
        <input class="form-control" id="pwd" type="password" name="pwd" placeholder="密码"><br>
        <div class="btn-group">
            <input id="login_btn" class="btn btn-default" type="submit" value="登 录">
            <input class="btn btn-default" type="button" value="注 册" onclick="location.href='register.jsp'">
            <input class="btn btn-default" type="reset" value="清 空"><br>
        </div>
    </form>
    <p class="info">${login_info}</p>
</div>
</body>
</html>
