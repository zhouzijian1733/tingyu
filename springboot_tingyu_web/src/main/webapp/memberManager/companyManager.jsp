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

    // datagird的初始化
    $(function () {

        $("#companyDataGrid").datagrid({
            url: "company/companyInfo.do",
            pagination: true, // 分页工具栏
            rownumbers: true,// 行号
            pageNumber: 1,
            pageSize: 3,
            // pageList 必须要有   pageSize的数据 必须是pageList 中的数据
            pageList: [3, 6],
            toolbar: "#companyToolBar",
            columns: [[
                {field: 'aaa', checkbox: true},
                {field: 'cid', title: '编号', width: 100},
                {field: 'cname', title: '公司的名称', width: 100},
                {field: 'ceo', title: '公司法人', width: 100},
                {field: 'cphone', title: '公司的电话', width: 100},
                {field: 'cmail', title: '邮箱', width: 100},
                {
                    field: 'starttime', title: '注册时间', width: 100, formatter: function (value, rowData, index) {
                        // 时间格式化格式化
                        return value.year + "-" + value.monthValue + "-" + value.dayOfMonth;
                    }
                },
                {field: 'ordernumber', title: '订单数', width: 100},
                {
                    field: 'status', title: '账号状态', width: 100,
                    formatter: function (value, rowData, index) {
                        return value == "1" ? "正常" : "禁用";
                    }
                }
            ]]
        })
    })

    // 条件查询的功能

    $(function () {

        $("#search").click(function () {
            // datagrid 提交数据
            // load param 加载并显示第一页的行 {可以给参数 }
            $("#companyDataGrid").datagrid('load', {
                cname: $("#cname").val(),
                status: $("#status").val(),
                ordernumber: $("#ordernumber").val()
            })
        });
    })

    // 添加公司
    $(function () {

        // dialog 关闭的时候 数据清理

        $("#addCompanyDialog").dialog({
            onClose: function () {
                $("#addCompanyForm").form('clear');
            }
        });

        $("#addCompany").click(function () {

            // 01 显示dialog
            $("#addCompanyDialog").dialog('open');
            // 02  编辑dialog
        });

        // 表单提交数据
        $("#addCompanySubmit").click(function () {
            // 03 提交数据
            $("#addCompanyForm").form(
                'submit', {
                    url: "company/addCompany.do",
                    success: function (data) {
                        // 04 数据更新
                        var d = JSON.parse(data);
                        if (d.success) {
                            // 01 信息提示
                            $.messager.alert("提示", d.msg, "info");
                            // 02 dialog 关闭
                            $("#addCompanyDialog").dialog('close');
                            // 03  datagird 重新加载数据
                            $("#companyDataGrid").datagrid('reload');
                            // 04  form表单的数据的清理
                            $("#addCompanyForm").form('clear');
                        }
                    }
                }
            )
        });
    })

    // 编辑公司的功能

    $(function () {

        $("#editCompany").click(function () {

            // 01 拿到选中的公司 的数据
            var trs = $("#companyDataGrid").datagrid('getChecked');
            // 02  表单回显数据
            if (trs.length == 1) {
                // 设置数据回显 会给cid 赋值
                $("#editCompanyForm").form('load', trs[0]);
                // 03  弹出编辑对话框
                $("#editCompanyDialog").dialog('open');
            } else if (trs.length > 1) {
                $.messager.alert("提示", "每次只能编辑一个公司", "info");
            } else {
                $.messager.alert("提示", "编辑公司需要选中一个公司", "info");
            }
        })

        // 表单提交按钮 添加事件
        $("#editCompanySubmit").click(function () {

            // 04  编辑数据 提交数据
            $("#editCompanyForm").form('submit', {
                url: 'company/companyUp.do',
                success: function (data) {
                    // 05  判断是否提交成功/ 数据刷新
                    var d = JSON.parse(data);
                    if (d.success) {
                        // 01 信息提示
                        $.messager.alert("提示", d.msg, "info");
                        // 02 datagrid 更新
                        $("#companyDataGrid").datagrid('reload');
                        // 03 dialog 关闭
                        $("#editCompanyDialog").dialog('close');
                        // 04 表单的数据的清理
                        $("#editCompanyForm").form('clear');
                    }
                }
            })
        });
    })

    // plannerDataGrid 初始化
    $(function () {

        $("#plannerDataGrid").datagrid({
            url: 'planner/plannerInfo.do',
            pagination: true,
            pageNumber: 1,
            pageSize: 3,
            pageList: [3, 6],
            rownumbers: true,
            columns: [[
                {field: 'nname', title: '策划姓名', width: 100},
                {field: 'nphone', title: '电话', width: 100},
                {
                    field: 'addtime', title: '开始时间', width: 100,
                    formatter: function (value, rowData, valueIndex) {
                        return value.year + "-" + value.monthValue + "-" + value.dayOfMonth;
                    }
                },
                {field: 'ordernumber', title: '订单数', width: 100},
                {
                    field: 'status', title: '状态', width: 100, formatter: function (value, rowData, valueIndex) {
                        return value == "1" ? "正常" : "禁止";
                    }
                }
            ]]
        })

        // plannerList 给添加点击事件

        $("#plannerList").click(function () {

            // 01 选中 公司
            var trs = $("#companyDataGrid").datagrid('getChecked');
            // 02 发送 公司的cid 查询策划师
            if (trs.length == 1) {

                $("#plannerDataGrid").datagrid('load', {
                    cid: trs[0].cid
                })
                // 03  datagrid 数据展示
                $("#plannerCompanyDialog").dialog('open');
            } else if (trs.length > 1) {
                $.messager.alert("提示", "只能查询单个公司的策划师", "info");
            } else {
                $.messager.alert("提示", "必须选中一个公司查询策划师", "info");
            }
        });
    });

    // 账号状态的修改
    $(function () {

        $("#accountStatus").click(function () {

            // 01 拿到要修改的 公司的 数据
            var trs = $("#companyDataGrid").datagrid('getChecked');

            if (trs.length > 0) {
                // 02 把要修改的公司的 cid 和status 拼接 在一起
                var cids = "";
                var statuss = "";

                for (var i = 0; i < trs.length; i++) {
                    cids += trs[i].cid + ",";
                    statuss += trs[i].status + ",";
                }

                // 03 通过ajax 发送数据 到服务器  cid和status
                $.post("company/companyStatusUp.do", {
                    cids: cids,
                    statuss: statuss
                }, function (data) {
                    // 04 判断更新是否成功
                    if (data.success){
                        // 01 信息提示
                        $.messager.alert("提示",data.msg,"info");
                        // 02 datagrid数据刷新
                        $("#companyDataGrid").datagrid('reload');

                    }
                }, "json");

            } else {
                $.messager.alert("提示", "必须选中一个公司进行状态修改", "info");
            }


        });

    })

</script>

<%-- 查看公司的策划师的 dialog--%>
<div id="plannerCompanyDialog" class="easyui-dialog" title="公司策划师展示" style="width:580px;height:400px"
     data-options="closed:true,top:100">
    <table id="plannerDataGrid" data-options="fit:true"></table>
</div>

<%-- 编辑公司的dialog --%>
<div id="editCompanyDialog" class="easyui-dialog" title="编辑公司" style="width:420px;height:400px"
     data-options="closed:true"
>
    <form id="editCompanyForm" method="post">

        <%--        添加一个隐藏域   --%>
        <input name="cid" type="hidden">
        <div style="text-align: center;margin-top: 20px">
            <input class="easyui-textbox" name="cname" data-options="prompt:'输入公司的名称'" style="width:200px">
        </div>

        <div style="text-align: center;margin-top: 20px">
            <input class="easyui-textbox" name="cpwd" data-options="prompt:'输入公司的密码'" style="width:200px">
        </div>

        <div style="text-align: center;margin-top: 20px">
            <input class="easyui-textbox" name="cphone" data-options="prompt:'输入公司的手机'" style="width:200px">
        </div>

        <div style="text-align: center;margin-top: 20px">
            <input class="easyui-textbox" name="ceo" data-options="prompt:'输入公司的法人'" style="width:200px">
        </div>

        <div style="text-align: center;margin-top: 20px">
            <input class="easyui-textbox" name="cmail" data-options="prompt:'输入公司的名称邮箱'" style="width:200px">
        </div>

        <div style="text-align: center;margin-top: 20px">
            <a id="editCompanySubmit" href="javascript:void(0)" class="easyui-linkbutton"
               data-options="iconCls:'icon-ok'">修改公司信息</a>
        </div>

    </form>

</div>


<%--添加公司的 dialog --%>

<div id="addCompanyDialog" class="easyui-dialog" title="添加公司" style="width:420px;height:400px"
     data-options="closed:true"
>

    <form id="addCompanyForm" method="post">
        <div style="text-align: center;margin-top: 20px">
            <input class="easyui-textbox" name="cname" data-options="prompt:'输入公司的名称'" style="width:200px">
        </div>

        <div style="text-align: center;margin-top: 20px">
            <input class="easyui-textbox" name="cpwd" data-options="prompt:'输入公司的密码'" style="width:200px">
        </div>

        <div style="text-align: center;margin-top: 20px">
            <input class="easyui-textbox" name="cphone" data-options="prompt:'输入公司的手机'" style="width:200px">
        </div>

        <div style="text-align: center;margin-top: 20px">
            <input class="easyui-textbox" name="ceo" data-options="prompt:'输入公司的法人'" style="width:200px">
        </div>

        <div style="text-align: center;margin-top: 20px">
            <input class="easyui-textbox" name="cmail" data-options="prompt:'输入公司的名称邮箱'" style="width:200px">
        </div>

        <div style="text-align: center;margin-top: 20px">
            <a id="addCompanySubmit" href="javascript:void(0)" class="easyui-linkbutton"
               data-options="iconCls:'icon-ok'">添加公司</a>
        </div>

    </form>

</div>


<div>

    <div style="width:900px;text-align: center">

        <form id="companyConditionForm" method="get">

            <input id="cname" class="easyui-textbox" name="cname" data-options="prompt:'公司的名称'" style="width:100px">

            <select id="status" class="easyui-combobox" data-options="panelHeight:'auto',editable:true,value:'状态'"
                    name="status"
                    style="width:100px;">
                <option value="1">正常</option>
                <option value="0">禁用</option>
            </select>

            <select id="ordernumber" class="easyui-combobox"
                    data-options="panelHeight:'auto',editable:true,value:'订单排序'" name="ordernumber"
                    style="width:100px;">
                <option value="asc">订单升序</option>
                <option value="desc">订单降序</option>
            </select>
            <a id="search" href="javascript:void(0)" class="easyui-linkbutton"
               data-options="iconCls:'icon-search'">查询</a>
        </form>
    </div>
    <table id="companyDataGrid" data-options="width:900,height:400"></table>
</div>

<%--创建公司DataGrid的工具栏--%>
<div id="companyToolBar">
    <a id="addCompany" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">添加公司</a>
    <a id="editCompany" href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-edit',plain:true">编辑公司</a>
    <a id="plannerList" href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-remove',plain:true">策划师列表</a>
    <a id="accountStatus" href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-remove',plain:true">账号状态</a>
</div>

</body>
</html>
