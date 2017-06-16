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
    <link href="css/from.css" rel="stylesheet" type="text/css">
    <script src="js/main.js"></script>
</head>
<body>
<div class="main_box">
    <h1>登录</h1>
    <form action="login.do" method="post" onsubmit="return checkLoginInput()">
        <input class="input_txt" id="username" type="text" name="name" placeholder="帐号"><br>
        <input class="input_txt" id="pwd" type="password" name="pwd" placeholder="密码"><br>
        <div>
            <input id="login_btn" class="input_btn" type="submit" value="登 录">
            <input class="input_btn" type="button" value="注 册" onclick="location.href='register.jsp'">
        </div>
        <input class="input_btn" type="reset" value="清 空"><br>
    </form>
    <p class="info">${login_info}</p>
</div>
</body>
</html>
