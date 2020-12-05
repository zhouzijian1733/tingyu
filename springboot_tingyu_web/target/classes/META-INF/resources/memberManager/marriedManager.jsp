<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<html>
<head>
    <base href="<%=basePath %>"/>
    <title> 新人管理 </title>

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

<script>

    // 初始化datagird

    $(function () {

        $("#marriedPersonDataGrid").datagrid({

            url: 'marriedPerson/marriedPersonInfo.do',
            pagination: true, // 分页工具栏
            rownumbers: true,// 行号
            pageNumber: 1,
            fitColumns: true,
            pageSize: 3,
            pageList: [3, 6],
            columns: [[
                {field: 'pid', title: '新人编号', width: 100},
                {field: 'pname', title: '新人名称', width: 100},
                // {field: 'ppwd', title: '新人密码', width: 100},
                {field: 'phone', title: '新人电话', width: 100},
                {field: 'pmail', title: '新人邮箱', width: 100},
                {
                    field: 'marrydate', title: '结婚时间', width: 100, formatter: function (value, rowData, index) {
                        // 时间格式化格式化
                        return value.year + "-" + value.monthValue + "-" + value.dayOfMonth;
                    }
                },
                {
                    field: 'status', title: '账号状态', width: 100,
                    formatter: function (value, rowData, index) {
                        return value == "1" ? "正常" : "禁用";
                    }
                }
            ]]
        });
    });

    // 条件查询 新人

    $(function () {
        $("#search").click(function () {
            // 01 datagrid 发送查询到数据
            $("#marriedPersonDataGrid").datagrid('load',{
                pname:$("#pname").val(),
                phone:$("#phone").val()
            })
        });
    });

</script>

<div style="width:900px;text-align: center;margin-top: 10px">

    <form id="companyConditionForm" method="get">

        <input id="pname" class="easyui-textbox" name="pname" data-options="prompt:'新人姓名'" style="width:100px">
        <input id="phone" class="easyui-textbox" name="phone" data-options="prompt:'新人手机号'" style="width:100px">

        <a id="search" href="javascript:void(0)" class="easyui-linkbutton"
           data-options="iconCls:'icon-search'">查询</a>
    </form>
</div>
<%-- 新人的datagird 展示数据  --%>
<div class="easyui-panel" style="width:950px;height:400px"
     data-options="collapsible:false,minimizable:false,maximizable:false,closable:true">
    <table id="marriedPersonDataGrid" data-options="fit:true"></table>
</div>

<body>

</body>
</html>
