<%--
  Created by IntelliJ IDEA.
  User: 29571
  Date: 2018/11/19
  Time: 14:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>请登录！</title>
    <link href="/css/login.css" rel="stylesheet" type="text/css"/>
    <script src="/js/jquery.min.js"></script>
    <script type="text/javascript">
        function checkName() {
            var name = $('#name').val();
            if(name.length==0){
                $('#namecheck').html("用户名不能为空!");
                return;
            }
            $('#namecheck').html("");
            $.ajax({
                type: "POST",//方法类型
                dataType: "json",//预期服务器返回的数据类型
                url: "/checkname" ,//url
                data: {"name":name},
                success: function (result) {
                    if (result.resultCode == 0) {
                        $('#namecheck').html("");
                    }else{
                        $('#namecheck').html("该用户名未注册！");
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
            if(password.length==0){
                $('#passwordcheck').html("密码不能为空!");
                return;
            }
            $('#passwordcheck').html("");
        }

        function login() {
            var name = $('#name').val();
            var password = $('#password').val();
            if(name.length==0){
                $('#namecheck').html("用户名不能为空！");
                return;
            }
            if(password.length==0){
                $('#passwordcheck').html("密码不能为空!");
                return;
            }

            if($('#namecheck').html().trim()!=0 ||
                $('#passwordcheck').html().trim()!=0){
                //表单为验证失败
                return;
            }

            $.ajax({
                type: "POST",//方法类型
                dataType: "json",//预期服务器返回的数据类型
                url: "/login" ,//url
                data: {"name":name,"password":password},
                success: function (result) {
                    console.log(result);//打印服务端返回的数据(调试用)
                    if (result.resultCode == 200) {
                        alert("登录成功");
                        sessionStorage.setItem("name", result.data.name);
                        window.location.href="/page/index";
                    }else{
                        alert("密码错误！");
                        $('#password').html("密码错误！");
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
            <form name="loginForm" method="post">
                <table>
                    <tr>
                        <th>账号:</th>
                        <th>
                            <input name="name" id="name" type="text" onblur="checkName()">
                            <label id="namecheck"></label>
                        </th>
                    </tr>
                    <tr>
                        <th>密码:</th>
                        <th>
                            <input name="password" id="password" type="password" onblur="checkPassword()">
                            <label id="passwordcheck"></label>
                        </th>
                    </tr>
                    <tr>
                        <th><div><a onclick="login()">登录</a></div></th>
                        <th><div class="login_a"><a href="/page/register">立即注册</a></div></th>
                    </tr>
                </table>
            </form>
        </div>
        <div></div>
    </div>
</body>
</html>
