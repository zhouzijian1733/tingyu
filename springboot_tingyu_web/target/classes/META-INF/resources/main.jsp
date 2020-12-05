<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<html>
<head>
    <base href="<%=basePath %>"/>
    <title>主页</title>

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

    /**
     *  系统菜单 和 tab 选项卡进行联动
     */
    $(function () {

        $("#meunTree").tree({
            onClick: function (node) {
                // 01 点击 tree, 如果是 二级菜单 联动tab
                console.log(node)
                if (node.attributes.isparent == '1') { // 父节点
                    //    如果是一级菜单不联动
                    return;
                }

                // 02 判断 是否存在 tab
                var flag = $("#menuTab").tabs('exists',node.text);
                //    如果存在 选中
                if(flag){
                    $("#menuTab").tabs("select",node.text);
                }
                //    如果不存在 添加一个tab
                else{
                    $("#menuTab").tabs("add",{
                        title:node.text,
                        closable:true,
                        // 冲服务器总动态的获取url 嵌套 页面
                        content:"<iframe src='"+ node.attributes.url +"'width='99%' height='99%' style='border: none'></iframe>"
                    })
                }
            }
        })
    })

</script>

<div id="cc" class="easyui-layout" data-options="fit:true">
    <div data-options="region:'north',title:'North Title',collapsible:false,split:false,noheader:true"
         style="height:100px;">

        <%--使用layout的嵌套布局，将头部分为，西，中，东三部分--%>
        <div class="easyui-layout" data-options="fit:true">
            <div data-options="region:'west',border:false"
                 style="width:20%;text-align: center;background-image: url('static/images/bg.png');overflow: hidden">
                <%--显示网站的logo--%>
                <img src="static/images/logo.png"
                     style="margin-left: 10px;margin-top: 5px; display:block; width:90%; height:96%;padding: 12px 2px">
            </div>
            <div data-options="region:'center',border:false"
                 style="background-image: url('static/images/bg.png');text-align: center">
                <%--声明网站的标题--%>
                <span style="color: white;font-size: 25px;position: relative;top:17px;">
                        Ting&nbsp;&nbsp;&nbsp;域&nbsp;&nbsp;&nbsp;主&nbsp;&nbsp;&nbsp;持&nbsp;&nbsp;&nbsp;人&nbsp;&nbsp;&nbsp;
                        后&nbsp;&nbsp;&nbsp;台&nbsp;&nbsp;&nbsp;管&nbsp;&nbsp;&nbsp;理&nbsp;&nbsp;&nbsp;系&nbsp;&nbsp;&nbsp;统
                    </span>
            </div>
            <div data-options="region:'east',border:false"
                 style="width:20%;background-image: url('static/images/bg.png');">
                <%--设置网站登录信息--%>
                <span style="position: relative;top:40px;font-size:15px;">
                        <span style="color: white">您好，${sessionScope.admin.aname}</span>
                        &nbsp;&nbsp;&nbsp;
                        <span><a href="#" style="color: white">退出</a></span>
                    </span>
            </div>
        </div>

    </div>
<%--    <div data-options="region:'south',title:'South Title',collapsible:false,split:false" style="height:100px;"></div>--%>
    <div data-options="region:'west',title:'系统菜单',collapsible:false,split:false" style="width:240px;">
        <ul id="meunTree" class="easyui-tree" data-options="url:'menu/menuInfo.do'"></ul>
    </div>
    <div data-options="region:'center',title:'主页',collapsible:false,split:false" style="padding:5px;background:#eee;">
        <div id="menuTab" class="easyui-tabs" data-options="fit:true">
        </div>
    </div>
</div>
</body>
</html>
