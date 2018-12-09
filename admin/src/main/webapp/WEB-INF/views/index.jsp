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
        })

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
    </script>
</head>
<body>
<div>

    <div class="header">
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
                <div class="menuItem">个人资料</div>
                <div class="menuItem">我的上传</div>
                <div class="menuItem">下载app</div>
                <div class="menuItem">上传app</div>
            </div>
        </div>
        <!-- 菜单结束 -->

        <!-- 显示框开始 -->
        <div class="right">
            <div id="appInfor" class="appInfor">
                <div id="itemInfor" class="itemInfor">

                </div>
                <%--<div class="appItem">--%>
                    <%--<div class="appImage"></div>--%>
                    <%--<div class="appDescBar">--%>
                        <%--<div class="appName">app名app名app名app名app名app名app名app名app名app名app名app名app名app名app名app名app名app名app名app名</div>--%>
                        <%--<div class="appType">app类型app类型app类型app类型app类型app类型app类型app类型app类型</div>--%>
                        <%--<div class="appDeveloper">app发行商app发行商app发行商app发行商app发行商app发行商app发行商app发行商app发行商app发行商app发行商app发行商app发行商app发行商app发行商</div>--%>
                        <%--<div class="appDesc">app描述信息app描述信息app描述信息app描述信息app描述信息app描述信息app描述信息app描述信息app描述信息app描述信息app描述信息app描述信息app描述信息app描述信息app描述信息app描述信息</div>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="appItem"></div>--%>
                <%--<div class="appItem"></div>--%>

                <!-- 分页 -->
                <div id="page" class="page-normal">
                    <%--<c:choose>--%>
                        <%--<!-- 当页码趋于中部 -->--%>
                        <%--<c:when test="${appdata.pageNum>4 && appdata.size-appdata.pageNum>3}">--%>
                            <%--<a href="javascript:void(0);" class="page-next">&lt;</a>--%>
                            <%--<a href="javascript:void(0);">1</a>--%>
                            <%--...--%>
                            <%--<c:forEach var="num" begin="${appdata.pageNum-2}" end="${appdata.pageNum+2}">--%>
                                <%--<c:choose>--%>
                                    <%--<c:when test="${num==appdata.pageNum}">--%>
                                        <%--<span class="page-current">--%>
                                            <%--<c:out value="${num}"/>--%>
                                        <%--</span>--%>
                                    <%--</c:when>--%>
                                    <%--<c:otherwise>--%>
                                        <%--<a href="javascript:void(0);">--%>
                                            <%--<c:out value="${num}"/>--%>
                                        <%--</a>--%>
                                    <%--</c:otherwise>--%>
                                <%--</c:choose>--%>
                            <%--</c:forEach>--%>
                            <%--...--%>
                            <%--<a href="javascript:void(0);">${appdata.size}</a>--%>
                            <%--<a href="javascript:void(0);" class="page-next">&gt;</a>--%>
                        <%--</c:when>--%>

                        <%--<!-- 当页码趋于头部 -->--%>
                        <%--<c:when test="${appdata.pageNum<4}">--%>
                            <%--<c:choose>--%>
                                <%--<c:when test="${appdata.num==1}">--%>
                                    <%--<span class="page-prev">&lt;</span>--%>
                                <%--</c:when>--%>
                                <%--<c:otherwise>--%>
                                    <%--<a href="javascript:void(0);" class="page-next">&lt;</a>--%>
                                <%--</c:otherwise>--%>
                            <%--</c:choose>--%>
                            <%--<c:forEach var="num" begin="1" end="4">--%>
                                <%--<c:choose>--%>
                                    <%--<c:when test="${num==appdata.pageNum}">--%>
                                        <%--<span class="page-current">--%>
                                            <%--<c:out value="${num}"/>--%>
                                        <%--</span>--%>
                                    <%--</c:when>--%>
                                    <%--<c:otherwise>--%>
                                        <%--<a href="javascript:void(0);">--%>
                                            <%--<c:out value="${num}"/>--%>
                                        <%--</a>--%>
                                    <%--</c:otherwise>--%>
                                <%--</c:choose>--%>
                            <%--</c:forEach>--%>
                            <%--...--%>
                            <%--<a href="javascript:void(0);">${pagedata.size}</a>--%>
                        <%--</c:when>--%>

                        <%--<!-- 当页码趋于尾部 -->--%>
                        <%--<c:when test="${appdata.size-appdata.pageNum<=3}">--%>
                            <%--<a href="javascript:void(0);" class="page-next">&lt;</a>--%>
                            <%--<a href="javascript:void(0);">1</a>--%>
                            <%--...--%>
                            <%--<c:forEach var="num" begin="${appdata.size-3}" end="${appdata.size}">--%>
                                <%--<c:choose>--%>
                                    <%--<c:when test="${num==appdata.pageNum}">--%>
                                        <%--<span class="page-current">--%>
                                            <%--<c:out value="${num}"/>--%>
                                        <%--</span>--%>
                                    <%--</c:when>--%>
                                    <%--<c:otherwise>--%>
                                        <%--<a href="javascript:void(0);">--%>
                                            <%--<c:out value="${num}"/>--%>
                                        <%--</a>--%>
                                    <%--</c:otherwise>--%>
                                <%--</c:choose>--%>
                            <%--</c:forEach>--%>
                            <%--<c:choose>--%>
                                <%--<c:when test="${appdata.size==appdata.pageNum}">--%>
                                    <%--<span class="page-prev">&gt;</span>--%>
                                <%--</c:when>--%>
                                <%--<c:otherwise>--%>
                                    <%--<a href="javascript:void(0);" class="page-next">&gt;</a>--%>
                                <%--</c:otherwise>--%>
                            <%--</c:choose>--%>
                        <%--</c:when>--%>
                    <%--</c:choose>--%>

                    <%--<span class="page-prev">&lt;</span>--%>
                    <%--<span class="page-current">1</span>--%>
                    <%--<a href="javascript:void(0);">2</a>--%>
                    <%--<a href="javascript:void(0);">3</a>--%>
                    <%--<a href="javascript:void(0);">4</a>--%>
                    <%--<a href="javascript:void(0);">5</a>--%>
                    <%--<a href="javascript:void(0);">6</a>--%>
                    <%--<a href="javascript:void(0);">7</a>--%>
                    <%--...--%>
                    <%--<a href="javascript:void(0);">199</a>--%>
                    <%--<a href="javascript:void(0);">200</a>--%>
                    <%--<a href="javascript:void(0);" class="page-next">&gt;</a>--%>
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
