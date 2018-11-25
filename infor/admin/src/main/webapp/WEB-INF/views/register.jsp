<%--
  Created by IntelliJ IDEA.
  User: 29571
  Date: 2018/11/19
  Time: 15:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册账号</title>
    <link href="/css/register.css" rel="stylesheet" type="text/css"/>
    <script src="/js/jquery.min.js"></script>
    <script type="text/javascript">
        function register() {
            if($('#name').val().length==0){
                $('#namecheck').html("用户名不能为空！");
                return;
            }
            if($('#password').val().length==0){
                $('#passwordcheck').html("密码不能为空！");
                return;
            }
            if($('#_password').val().length==0){
                $('#_passwordcheck').html("请验证密码！");
                return;
            }
            if($('#phone').val().length==0){
                $('#phonecheck').html("电话号码不能为空！");
                return;
            }
            if($('#email').val().length==0){
                $('#emailcheck').html("邮箱不能为空！");
                return;
            }
            if($('#namecheck').html().trim()!=0 ||
                $('#passwordcheck').html().trim()!=0 ||
                $('#_passwordcheck').html().trim()!=0 ||
                $('#phonecheck').html().trim()!=0 ||
                $('#emailcheck').html().trim()!=0){
                //表单为验证失败
                alert("验证失败")
                return;
            }
            $.ajax({
                type: "POST",//方法类型
                dataType: "json",//预期服务器返回的数据类型
                url: "/register" ,//url
                data: $('#registerForm').serialize(),
                success: function (result) {
                    if (result.resultCode == 200) {
                        alert("注册成功！请登录");
                        window.location.href="/page/login";
                    }else{
                        alert("注册失败！")
                    }
                    ;
                },
                error : function() {
                    alert("异常！");
                }
            });
        }

        function checkName() {
            var name = $('#name').val();
            if(name.length<4 || name.length>16){
                $('#namecheck').html("用户名长度在4到16个字符之间！");
                return;
            }
            $('#namecheck').html("");
            $.ajax({
                type: "POST",//方法类型
                dataType: "json",//预期服务器返回的数据类型
                url: "/checkname" ,//url
                data:{"name":name},//请求传送数据
                success: function (result) {
                    console.log(result);//打印服务端返回的数据(调试用)
                    if (result.resultCode == 200) {
                        $('#namecheck').html("");
                    }else{
                        $('#namecheck').html(result.resultMessage);
                    }
                    ;
                },
                error : function() {
                    alert("异常！");
                }
            });
        }

        function checkPassword() {
            var password = $('#password').val();
            if (password.length<4 || password.length>16) {
                $('#passwordcheck').html("密码长度在4到16个字符之间！");
                return;
            }
            $('#passwordcheck').html("");
        }

        function check_Password() {
            var _password = $('#_password').val();
            var password = $('#password').val();
            if (password != _password) {
                $('#_passwordcheck').html("两次输入密码不同！请再次输入！");
                return;
            }
            $('#_passwordcheck').html("");
        }

        function checkPhone() {
            var phone = $('#phone').val();
            var pattern = /^1(3|4|5|7|8)\d{9}$/;
            if(pattern.test(phone)==false){
                $('#phonecheck').html("请输入正确的手机号！");
                return;
            }
            $('#phonecheck').html("");
            $.ajax({
                type: "POST",//方法类型
                dataType: "json",//预期服务器返回的数据类型
                url: "/checkphone" ,//url
                data:{"phone":phone},//请求传送数据
                success: function (result) {
                    console.log(result);//打印服务端返回的数据(调试用)
                    if (result.resultCode == 200) {
                        $('#phonecheck').html("");
                    }else{
                        $('#phonecheck').html(result.resultMessage);
                    }
                    ;
                },
                error : function() {
                    alert("异常！");
                }
            });
        }

        function checkEmail() {//
            var email = $('#email').val();
            var pattern = /^[A-Za-z\d]+([-_.][A-Za-z\d]+)*@([A-Za-z\d]+[-.])+[A-Za-z\d]{2,4}$/;
            if(pattern.test(email)==false){
                $('#emailcheck').html("请输入正确的邮箱！");
                return;
            }
            $('#emailcheck').html("");
            $.ajax({
                type: "POST",//方法类型
                dataType: "json",//预期服务器返回的数据类型
                url: "/checkemail" ,//url
                data:{"email":email},//请求传送数据
                success: function (result) {
                    console.log(result);//打印服务端返回的数据(调试用)
                    if (result.resultCode == 200) {
                        $('#emailcheck').html("");
                    }else{
                        $('#emailcheck').html(result.resultMessage);
                    }
                    ;
                },
                error : function() {
                    alert("异常！");
                }
            });
        }
    </script>
</head>

<body>
    <div>

        <div></div>

        <div>
            <div class="registerdiv">
                <form id="registerForm">
                    <table>
                        <tr>
                            <th>用户名:</th>
                            <th>
                                <input name="name" id="name" type="text" onblur="checkName()">
                                <label id="namecheck"></label>
                            </th>
                        </tr>
                        <tr>
                            <th>密码:</th>
                            <th>
                                <input name="password" id="password" type="password"  onkeyup="checkPassword()">
                                <label id="passwordcheck"></label>
                            </th>
                        </tr>
                        <tr>
                            <th>验证密码:</th>
                            <th>
                                <input id="_password" type="password"  onkeyup="check_Password()">
                                <label id="_passwordcheck"></label>
                            </th>
                        </tr>
                        <tr>
                            <th>手机号:</th>
                            <th>
                                <input name="phone" id="phone" type="tel" onblur="checkPhone()">
                                <label id="phonecheck"></label>
                            </th>
                        </tr>
                        <tr>
                            <th>邮箱:</th>
                            <th>
                                <input name="email" id="email" type="email" onblur="checkEmail()">
                                <label id="emailcheck"></label>
                            </th>
                        </tr>
                        <tr>
                            <th><div><a id="register" onclick="register()">注册</a></div></th>
                            <th><div class="register_a"><a href="/page/login">立即登录</a></div></th>
                        </tr>
                    </table>
                </form>
            </div>
        </div>

        <div></div>

    </div>
</body>
</html>
