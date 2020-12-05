<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<html>
<head>
    <base href="<%=basePath %>"/>
    <title>菜单页面 </title>

    <%--    导入easy资源--%>
    <%--    样式 --%>
    <link rel="stylesheet" type="text/css" href="static/themes/default/easyui.css">
    <%--    图片 --%>
    <link rel="stylesheet" type="text/css" href="static/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="static/themes/color.css">
    <%--    jq --%>
    <script type="text/javascript" src="static/js/jquery.min.js"></script>
    <%--    js文件--%>
    <script type="text/javascript" src="static/js/jquery.easyui.min.js"></script>

</head>
</head>
<body>

<script>

    // 添加菜单
    $(function () {

        // 添加菜单
        $("#addMenuBtn").click(function () {

            // 01 判断 添加菜单的时候是否选中了 tree
            var node = $("#menuTree").tree('getSelected');
            console.log(node);
            // 02 如果选中了tree 需要设置pid  没有选中pid 默认0
            if (node != null){
                $("#pid").val(node.id);
            }
            // 03 展示添加菜单的dialog
            $("#addMenuDialog").dialog("open");
        });

        $("#addMenuSubmit").click(function () {

            // 04 发送数据
            $("#addMenuForm").form("submit",{
                url:"menu/addMenu.do",
                success:function (data) {
                     // 05 判断添加是否成功 / tree 数据加载
                    // easyui的组件 form 提交数据 默认返回的是 字符串
                    // ajax提交数据   如果设置了dataType:"json" 返回的是json
                   var d = JSON.parse(data);
                    //   01 信息提示
                    if (d.success){
                        $.messager.alert("提示", d.msg, "info");
                        //   02 dialog 关闭
                        $("#addMenuDialog").dialog("close");
                        //   03 tree 的数据更新
                        $("#menuTree").tree('reload');
                        //   04 form 表单数据清理
                        $("#addMenuForm").form("clear");
                    }
                },
            })
        })

    });


    // 修改 菜单
    $(function () {

        $("#editMenuBtn").click(function () {

            // 01 选中菜单
             var node = $("#menuTree").tree('getSelected');
             if (node != null){

                 // 02 数据回显
                 // 如果node 的属性 字段  和表单 的 属性name的字段一致  可以进行数据填充

                 // 如果node 的属性 字段  和表单 的 属性name的字段不一致   自己手动填充进行映射
                 $("#editMenuForm").form('load',{
                     mid:node.id,
                     mname:node.text,
                     url:node.attributes.url,
                     mdesc:node.attributes.mdesc
                 });

                 $("#editMenuDialog").dialog('open');
                 // 03 编辑 数据
             }else{
                 $.messager.alert("提示", "需要选中菜单进行编辑", "info");
             }
        });

        $("#editMenuSubmit").click(function () {

                // 04 提交数据
            $("#editMenuForm").form("submit",{
                url:"menu/menuUp.do",
                success:function (data) {
                    // 05 更新tree 数据
                    var d = JSON.parse(data);
                    if(d.success){
                        // 01 信息提示
                        $.messager.alert("提示", "需要选中菜单进行编辑", "info");
                        // 02 dialog 关闭
                        $("#editMenuDialog").dialog("close");
                        // 03  tree 更新
                        $("#menuTree").tree('reload');
                        // 04  表单数据清理
                        $("#editMenuForm").form("clear");
                    }
                }
            })
        });
    })

    // 删除菜单
    $(function () {

        $("#delMenuBtn").click(function () {

            // 01 拿到选中额菜单
            var node = $("#menuTree").tree('getSelected');
            if (node != null){

                $.messager.confirm("提示","你确认要删除这个菜单吗?",function (r) {
                    // 点击 确认 r 为true
                    if (r){

                        $.post("menu/menuDel.do",{
                            pid:node.attributes.pid,
                            mid:node.id
                        },function (data) {
                            if(data.success){
                                // 01 信息提示
                                $.messager.alert("提示", data.msg, "info");
                                // 02  tree 更新
                                $("#menuTree").tree('reload');
                            }
                        },"json")
                    }else{
                        $.messager.alert("提示", "删除失败", "info");
                    }
                })
                // 02 ajax 发送mid 和pid 到服务器
                // 03  页面的更新
            }else{
                $.messager.alert("提示", "必须选中一个菜单才可以删除", "info");
            }
        });
    })

</script>


<%-- 修改菜单的 dialog--%>
<div id="editMenuDialog" class="easyui-dialog" title="修改菜单" style="width:500px;height:300px;"
     data-options="iconCls:'icon-save',resizable:false,modal:false,closed:true">

    <form id="editMenuForm" method="post">

<%--        修改的 mid --%>
        <input type="hidden" name="mid">
        <div style="text-align: center;margin-top: 28px">
            <input type="text" class="easyui-textbox" name="mname" data-options="prompt:'输入菜单的名称',width:200">
        </div>

        <div style="text-align: center;margin-top: 28px">
            <input type="text" class="easyui-textbox" name="url" data-options="prompt:'输入菜单的url',width:200">
        </div>

        <div style="text-align: center;margin-top: 28px">
            <input type="text" class="easyui-textbox" name="mdesc" data-options="prompt:'输入菜单的描述',width:200">
        </div>

        <div style="text-align: center;margin-top: 28px">
            <a id="editMenuSubmit" href="javascript:void(0)" class="easyui-linkbutton"
               data-options="iconCls:'icon-ok'">修改菜单</a>
        </div>

    </form>

</div>



<%-- 添加菜单的 dialog--%>
<div id="addMenuDialog" class="easyui-dialog" title="添加菜单" style="width:500px;height:300px;"
     data-options="iconCls:'icon-save',resizable:false,modal:false,closed:true">

    <form id="addMenuForm" method="post">

<%--        添加菜单的时候 把 菜单的pid 给发送过去--%>
        <input type="hidden" id="pid" name="pid">

        <div style="text-align: center;margin-top: 28px">
            <input type="text" class="easyui-textbox" name="mname" data-options="prompt:'输入菜单的名称',width:200">
        </div>

        <div style="text-align: center;margin-top: 28px">
            <input type="text" class="easyui-textbox" name="url" data-options="prompt:'输入菜单的url',width:200">
        </div>

        <div style="text-align: center;margin-top: 28px">
            <input type="text" class="easyui-textbox" name="mdesc" data-options="prompt:'输入菜单的描述',width:200">
        </div>

        <div style="text-align: center;margin-top: 28px">
            <a id="addMenuSubmit" href="javascript:void(0)" class="easyui-linkbutton"
               data-options="iconCls:'icon-ok'">添加菜单</a>
        </div>

    </form>

</div>

<div id="cc" class="easyui-layout" style="width:900px;height:500px;">
    <div data-options="region:'west',title:'操作',split:false,collapsible:false,minimizable:false,maximizable:false"
         style="width:260px;">

        <div style="margin:20px auto;text-align:center">
            <a id="addMenuBtn" href="javascript:void(0)" class="easyui-linkbutton c1" style="width:120px;margin-left: 15px;margin-top: 28px">添加菜单</a>
            <a id="editMenuBtn" href="javascript:void(0)" href="#" class="easyui-linkbutton c2" style="width:120px;margin-left: 15px;margin-top: 28px">修改菜单</a>
            <a id="delMenuBtn" href="javascript:void(0)" href="#" class="easyui-linkbutton c3" style="width:120px;margin-left: 15px;margin-top: 28px">删除菜单</a>
        </div>

    </div>
    <div data-options="region:'center',title:'系统菜单',split:false,collapsible:false,minimizable:false,maximizable:false"
         style="padding:5px;background:#eee;">
        <ul id="menuTree" class="easyui-tree" data-options="url:'menu/menuAllInfo.do'"></ul>
    </div>

</div>
</body>
</html>
