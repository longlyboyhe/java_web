function checkLoginInput() {
    var username = document.getElementById("username");
    var pwd = document.getElementById("pwd");
    if (username.value === '' || pwd.value === '') {
        alert("输入不能有空");
        return false;
    }
    return true;
}

function checkRegisterInput() {
    var username = document.getElementById("username");
    var pwd = document.getElementById("pwd");
    var nick_name = document.getElementById("nick_name");
    var phone_num = document.getElementById("phone_num");
    if (username.value === '' || pwd.value === '' || nick_name.value === '' || phone_num.value === '') {
        alert("输入不能有空");
        return false;
    }
    return true;
}