<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<html>
<head>
    <base href="<%=basePath %>"/>
    <title>登陆页面</title>

    <%--    导入easy资源--%>
    <%--    样式 --%>
    <link rel="stylesheet" type="text/css" href="static/themes/default/easyui.css">
    <%--    图片 --%>
    <link rel="stylesheet" type="text/css" href="static/themes/icon.css">
    <%--    jq --%>
    <script type="text/javascript" src="static/js/jquery.min.js"></script>
    <%--    js文件--%>
    <script type="text/javascript" src="static/js/jquery.easyui.min.js"></script>

</head>
<body>

<script>

    $(function () {

        $("#btn").click(function () {
            $("#loginForm").submit();
        })

    })

</script>

<div style="margin: 150px auto;width:500px;height:300px;text-align: center">

    <c:if test="${sessionScope.msg == 'error'}">
        <p style="color: red;font-size: 20px">用户名或者密码错误<p>
    </c:if>

<%--        把 session的错误的标记移除  --%>
        <c:remove var="msg" scope="session"></c:remove>

    <div id="p" class="easyui-panel" title="tingyu后台登录"
         style="width:500px;height:300px;padding:10px;background:#fafafa;"
         data-options="closable:false,
    collapsible:false,minimizable:false,maximizable:false">
        <form id="loginForm" action="admin/login.do" method="post">
            <div style="text-align: center;margin-top: 28px">
                <input name="aname" class="easyui-textbox" data-options="prompt:'输入用户名'" style="width:200px" value="admin">
            </div>

            <div style="text-align: center;margin-top: 28px">
                <input  name="apwd" class="easyui-passwordbox" data-options="prompt:'输入密码'" style="width:200px" value="123">
            </div>

            <div style="text-align: center;margin-top: 28px">
                <a id="btn" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">点击登录</a>
            </div>
        </form>
    </div>
</div>

</body>
</html>
