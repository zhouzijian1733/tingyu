<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <base href="<%=basePath %>"/>
    <title>Title</title>
    <%--引入easyUI的资源--%>
    <link rel="stylesheet" type="text/css" href="static/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="static/themes/icon.css">
    <script type="text/javascript" src="static/js/jquery.min.js"></script>
    <script type="text/javascript" src="static/js/jquery.easyui.min.js"></script>
    <%--声明css样式--%>
    <style type="text/css">
        /*声明菜单栏效果*/
        ul{position: relative;bottom: 40px;left: 150px;}
        ul li{float: left;list-style: none;margin-right: 40px;font-size: 20px;line-height: 36px; color: #fff;text-align: center;padding: 0 20px;
            height: 36px;    margin: 0 20px;    width: 140px ;   box-sizing: border-box;    border-radius: 10px;
        }
        .active{
            border-radius: 10px;
            color: #fff;
            border: 2px solid #fff;
            line-height: 31px;}
        ul li a{text-decoration: none;cursor: pointer;color: #fff;}
    </style>
</head>
<body class="easyui-layout">
<div data-options="region:'north',split:false" style="height:150px;background-image: url('static/images/top_bg.png')">
    <%--创建头部工具栏--%>
    <div style="width: 1008px;height: 120px;margin: auto;">
        <%--设置网站欢迎语--%>
        <p style="color: #666666;float: left;line-height: 44px;position: relative;bottom: 10px;font-size: 14px;">
            Ting域主持人欢迎您！ 客服：13601371065（卓越老师）
        </p>
        <span style="float: right;position: relative;top:10px;">
                        <span><a href="login.jsp" style="color: #666666;text-decoration: none;">登录</a></span> |
                        <span><a href="reg.jsp" style="color: #666666;text-decoration: none;">注册</a></span>
                </span>
        <br>
        <%--声明网站logo--%>
        <a href="" style="cursor: pointer;">
            <img src="static/images/protal_logo.png" alt="Ting域" style="height: 80px;position: relative;right: 370px;top:20px;">
        </a>
        <%--声明网站横向菜单栏--%>
        <ul>
            <li class="active"><a href="">首页</a></li>
            <li class="active"><a href="">主持人</a></li>
            <li class="active"><a href="">加入我们</a></li>
            <li class="active"> <a href="">关于我们</a></li>
        </ul>
    </div>
</div>
<div data-options="region:'center'" style="padding:5px;background:#eee;">
    <%--声明网站图片--%>
    <div>
        <img src="static/images/tingyu-1.jpg" width="100%" alt="">
    </div>
    <%--声明网站图片--%>
    <div>
        <img src="static/images/ting_2.png" width="100%" alt="">
    </div>
</div>

</body>
</html>
