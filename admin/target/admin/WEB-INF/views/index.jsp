<%--
  Created by IntelliJ IDEA.
  User: 29571
  Date: 2018/11/20
  Time: 9:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>欢迎登录!</title>
    <link href="/css/index.css" rel="stylesheet" type="text/css"/>
    <script src="/js/jquery.min.js"></script>
    <script type="text/javascript">
        var pagenum = 0;
        var pageInfo;
        var appData;
        $(document).ready(function(){
            load();
        })

        function load() {
            $.ajax({
                type: "POST",//方法类型
                dataType: "json",//预期服务器返回的数据类型
                url: "/setpageinfo" ,//url
                success: function (result) {
                    if (result.resultMessage == "success") {
                        pageInfo = result.data;
                        appData = pageInfo.data;
                        pageinfo(pageInfo);
                        appinfo(appData);
                    }else{
                        alert(result.resultMessage);
                    }
                    ;
                },
                error : function() {
                    alert("异常！");
                }
            });
        }

        function pageinfo(pageInfo) {
            var str = "";
            if(pageInfo.pageTotal<=6){
                if(pageInfo.pageNum==1){
                    str += "<span class=\"page-prev\">&lt;</span>";
                }else{
                    str += "<a href=javascript:void(0);\" class=\"page-next\">&lt;</a>";
                }
                for(i=1; i<=pageInfo.pageTotal; i++){
                    if(i==pageInfo.pageNum){
                        str += "<span class=\"page-current\">" +
                            i +
                            "</span>";
                    }else{
                        str += "<a href=\"javascript:void(0);\">" +
                            i +
                            "</a>";
                    }
                }
                if(pageInfo.pageNum==pageInfo.pageTotal){
                    str += "<span class=\"page-prev\">&gt;</span>";
                }else{
                    str += "<a href=\"javascript:void(0);\" class=\"page-next\">&gt;</a>";
                }


            }else if(pageInfo.pageNum>4 && pageInfo.pageTotal-pageInfo.pageNum>3){
                str += "<a href=\javascript:void(0);\" class=\"page-next\">&lt;</a>" +
                    "<a href=\"javascript:void(0);\">" +
                    1 +
                    "</a>" +
                    "...";
                for (i=pageInfo.pageNum-2;i<=pageInfo.pageNum+2;i++){
                    if(i==pageInfo.pageNum){
                        str += "<span class=\"page-current\">" +
                            i +
                            "</span>";
                    }else{
                        str += "<a href=\"javascript:void(0);\">" +
                            i +
                            "</a>";
                    }
                }
                str += "..." +
                    "<a href=\"javascript:void(0);\">"+
                    pageInfo.pageTotal+
                    "</a>" +
                    "<a href=\"javascript:void(0);\" class=\"page-next\">&gt;</a>";
            }else if(pageInfo.pageNum<=4){
                if(pageInfo.pageNum==1){
                    str += "<span class=\"page-prev\">&lt;</span>";
                }else{
                    str += "<a href=\"javascript:void(0);\" class=\"page-next\">&lt;</a>";
                }
                for(i=1; i<=6; i++){
                    if(i==pageInfo.pageNum){
                        str += "<span class=\"page-current\">" +
                            i +
                            "</span>";
                    }else{
                        str += "<a href=\"javascript:void(0);\">" +
                            i +
                            "</a>";
                    }
                }
                str += "..." +
                    "<a href=\"javascript:void(0);\">" +
                    pageInfo.pageTotal +
                    "</a>" +
                    "<a href=\"javascript:void(0);\" class=\"page-next\">&gt;</a>";

            }else if(pageInfo.pageTotal-pageInfo.pageNum<=3){
                str += "<a href=\"javascript:void(0);\" class=\"page-next\">&lt;</a>" +
                    "<a href=\"javascript:void(0);\">1</a>" +
                    "...";
                for(i=pageInfo.pageTotal-5;i<=pageInfo.pageTotal;i++){
                    if(i==pageInfo.pageNum){
                        str += "<span class=\"page-current\">" +
                            i +
                            "</span>";
                    }else{
                        str += "<a href=\"javascript:void(0);\">" +
                            i +
                            "</a>";
                    }
                }
                if(pageInfo.pageNum==pageInfo.pageTotal){
                    str += "<span class=\"page-prev\">&gt;</span>";
                }else{
                    str += "<a href=\"javascript:void(0);\" class=\"page-next\">&gt;</a>";
                }
            }
            $('#page').html("");
            $('#page').html(str);

            $('.page-normal').children('a').click(function () {
                if($(this).text()=="<"){
                    pagenum = pageInfo.pageNum - 1;
                }else if($(this).text()==">"){
                    pagenum = pageInfo.pageNum + 1;
                }else{
                    pagenum = parseInt($(this).text());
                }
                $.ajax({
                    type: "POST",//方法类型
                    dataType: "json",//预期服务器返回的数据类型
                    url: "/getappinfo" ,//url
                    data: {"pagenum":pagenum},
                    success: function (result) {
                        if (result.resultMessage == "success") {
                            pageInfo = result.data;
                            appData = pageInfo.data;
                            pageinfo(pageInfo);
                            appinfo(appData);
                        }else{
                            alert(result.resultMessage);
                        }
                        ;
                    },
                    error : function() {
                        alert("异常！");
                    }
                });
            })
        }
        function appinfo(appData){
            var str = "";
            $.each(appData,function(name,value) {
                str += "<div class=\"appItem\">\n" +
                    "                    <div class=\"appImage\">"+ value.image+"</div>\n" +
                    "                    <div class=\"appDescBar\">\n" +
                    "                        <div class=\"appName\">"+ value.appname +"</div>\n" +
                    "                        <div class=\"appType\">类型："+ value.apptype +"</div>\n" +
                    "                        <div class=\"appDeveloper\">开发商："+ value.developer +"</div>\n" +
                    "                        <div class=\"appDesc\">描述："+ value.appdes +"</div>\n" +
                    "                    </div>\n" +
                    "                </div>";
            });
            $('#itemInfor').html("");
            $('#itemInfor').html(str);
        }

        function userInfo(){
            var username = sessionStorage.getItem('name');
            $.ajax({
                type: "POST",//方法类型
                dataType: "json",//预期服务器返回的数据类型
                url: "/getuserinfo" ,//url
                data:{"username": username},
                success: function (result) {
                    if (result.resultMessage == "success") {
                        $('.right').html(showUserInfo(result.data));
                    }else{
                        alert(result.resultMessage);
                    }
                    ;
                },
                error : function() {
                    alert("异常！");
                }
            });
        }

        function showUserInfo(userinfo) {
            var str = "";
            str += "<div class=\"modifyUserFormDiv\">\n" +
                "\t\t\t\t\t<form id = \"modifyUserForm\">\n" +
                "\t\t\t\t\t\t<table class = \"userInforTable\">\n" +
                "\t\t\t\t\t\t\t<tr>\n" +
                "\t\t\t\t\t\t\t\t<th>用户名:</th>\n" +
                "\t\t\t\t\t\t\t\t<th><label>"+ userinfo.name +"</label></th>\n" +
                "\t\t\t\t\t\t\t\t<th><input name=\"name\" type=\"hidden\" value=\""+ userinfo.name +"\"/></th>\n" +
                "\t\t\t\t\t\t\t</tr>\n" +
                "\t\t\t\t\t\t\t<tr>\n" +
                "\t\t\t\t\t\t\t\t<th>邮箱:</th>\n" +
                "\t\t\t\t\t\t\t\t<th><label>"+ userinfo.email +"</label></th>\n" +
                "\t\t\t\t\t\t\t\t<th id = \"modifyEmail\" class=\"hiddenTh\"><input name=\"email\" type=\"text\" value='"+ userinfo.email +"'/></th>\n" +
                "\t\t\t\t\t\t\t\t<th id = \"modifyEmailButton\" class = \"#\"><a name = \"modifyEmail\" href=\"javascript:void(0);\" onclick=\"modifyClick(this)\">修改</a></th>\n" +
                "\t\t\t\t\t\t\t</tr>\n" +
                "\t\t\t\t\t\t\t<tr>\n" +
                "\t\t\t\t\t\t\t\t<th>手机号:</th>\n" +
                "\t\t\t\t\t\t\t\t<th><label>"+ userinfo.phone +"</label></th>\n" +
                "\t\t\t\t\t\t\t\t<th id = \"modifyPhone\" class=\"hiddenTh\"><input name=\"phone\" type=\"text\" value='"+ userinfo.phone +"'/></th>\n" +
                "\t\t\t\t\t\t\t\t<th id = \"modifyPhoneButton\" class=\"#\"><a name = \"modifyPhone\" href=\"javascript:void(0);\" onclick=\"modifyClick(this)\">修改</a></th>\n" +
                "\t\t\t\t\t\t\t</tr>\n" +
                "\t\t\t\t\t\t\t<tr>\n" +
                "\t\t\t\t\t\t\t\t<th><a href=\"javascript:void(0);\" onclick='submitModifyUserForm()'>提交</a></th>\n" +
                "\t\t\t\t\t\t\t</tr>\n" +
                "\t\t\t\t\t\t</table>\n" +
                "\t\t\t\t\t</form>\n" +
                "\t\t\t\t</div>";
            return str;
        }

        function submitModifyUserForm() {
            $.ajax({
                type: "POST",//方法类型
                dataType: "json",//预期服务器返回的数据类型
                url: "/modifyuser" ,//url
                data: $('#modifyUserForm').serialize(),
                success: function (result) {
                    if (result.resultCode == 200) {
                        alert("修改信息成功");
                        $('.right').html(showUserInfo(result.data));
                    }else{
                        alert(result.resultMessage)
                    }
                    ;
                },
                error : function() {
                    alert("异常！");
                }
            });
        }


        function modifyClick(e){
            var id = "#"+e.name;
            $(id).removeClass("hiddenTh");
            $(id).addClass = "#";
            id = id + "Button";
            $(id).addClass("hiddenTh");
        }
    </script>
</head>
<body>
<div>

    <div id="header" class="header">
        header
    </div>

    <div class="body">
        <!-- 菜单开始 -->
        <div class="left">
            <!-- 用户信息 -->
            <div class="userInfor">
                <div class="userInfor_image">
                    用户头像
                </div>
                <div class="userInfor_name">
                    用户名
                </div>
            </div>

            <!-- 菜单 -->
            <div class="menu">
                <div class="menuItem"><a href="javascript:void(0);" onclick="userInfo()">个人资料</a></div>
                <div class="menuItem"><a href="javascript:void(0);">我的上传</a></div>
                <div class="menuItem"><a href="javascript:void(0);">下载app</a></div>
                <div class="menuItem"><a href="javascript:void(0);">上传app</a></div>
            </div>
        </div>
        <!-- 菜单结束 -->

        <!-- 显示框开始 -->
        <div id = "right" class="right">
            <div id="appInfor" class="appInfor">
                <div id="itemInfor" class="itemInfor">

                </div>

                <!-- 分页 -->
                <div id="page" class="page-normal">

                </div>
            </div>


        </div>
        <!-- 显示框结束 -->

    </div>

    <div class="footer">
        footer
    </div>

</div>

</body>
</html>
