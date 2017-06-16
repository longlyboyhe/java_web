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
    <link href="css/from.css" rel="stylesheet" type="text/css">
    <script src="js/main.js"></script>
</head>
<body>
<div class="main_box">
    <h1>注册</h1>
    <%request.setAttribute("action", "register");%>
    <form action="register.do" method="post" onsubmit="return checkRegisterInput()">
        <input id="username" type="text" name="name" placeholder="帐号" class="input_txt"><br>
        <input id="pwd" type="password" name="pwd" placeholder="密码" class="input_txt"><br>
        <input id="nick_name" type="text" name="nick_name" placeholder="昵称" class="input_txt"><br>
        <input id="phone_num" type="tel" name="phone_num" placeholder="手机号" class="input_txt"><br>
        <input type="radio" name="identity" value="normal" checked="checked">普通用户
        <input type="radio" name="identity" value="admin">管理员<br>
        <input class="input_btn" type="submit" value="注 册">
        <input class="input_btn" type="reset" value="清 空"><br>
    </form>
    <p class="info">${register_info}</p>
</div>
</body>
</html>
