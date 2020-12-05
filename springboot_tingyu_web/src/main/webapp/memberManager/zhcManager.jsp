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

    // datagrid的初始化
    $(function () {

        $("#hostDataGrid").datagrid({

            url: "host/hostInfo.do",     //远程服务器的地址
            // title:"主持人查询结果",
            fitColumns: true,
            pagination: true,            // 分页工具栏
            rownumbers: true,            // 行号
            pageNumber: 1,               // 首页初始化
            pageSize: 2,                 // 页面大小
            pageList: [2, 4, 6],            // 页面大小 下拉框
            toolbar: "#tb",
            checkOnSelect: false,  // 选中checkbox 才会选中一行
            columns: [[
                {field: 'xxx', checkbox: true},
                {
                    field: 'strong', title: '权重', width: 100,
                    formatter: function (value, rowData, index) {
                        //  当前的input标签对象
                        // value  之前的strong的值
                        //  rowData.hid  host的id
                        return "<input type='text' value='" + value + "'style='width: 60px' onblur='changeStrong(this, " + value + "," + rowData.hid + ")'/>"
                    }
                },
                {field: 'hname', title: '姓名', width: 100},
                {field: 'hphone', title: '手机号', width: 100},
                {
                    field: 'starttime', title: '开通时间', width: 200,
                    formatter: function (value, rowData, index) {
                        // value 是 时间对象
                        // 获取时间 进行 拼接格式化 返回字符串
                        return value.year + "-" + value.monthValue + "-" + value.dayOfMonth + " " +
                            value.hour + ":" + value.minute + ":" + value.second;
                    }
                },
                {
                    field: 'hpprice', title: '价格', width: 100,
                    //  单元格的格式化函数，需要三个参数：
                    // value：字段的值。
                    // rowData：行的记录数据。
                    // rowIndex：行的索引。
                    formatter: function (value, rowData, index) {

                        // 判断是否有 hostpower
                        if (rowData.hostPower) {
                            return rowData.hostPower.hpprice;
                        } else {
                            return "";
                        }
                    }
                },
                {field: 'ordernumber', title: '订单数量', width: 100},
                {
                    field: 'discount', title: '折扣', width: 100,
                    formatter: function (value, rowData, index) {
                        if (rowData.hostPower) {
                            return rowData.hostPower.hpdiscount;
                        } else {
                            return "";
                        }
                    }
                },
                {
                    field: 'star', title: '星推荐', width: 100,
                    formatter: function (value, rowData, index) {
                        if (rowData.hostPower) {
                            return rowData.hostPower.hpstar == '1' ? "推荐" : "不推荐";
                        } else {
                            return "";
                        }
                    }
                },
                {
                    field: 'status', title: '账号状态', width: 100,
                    formatter: function (value, rowData, index) {
                        return value == "1" ? "正常" : "禁用";
                    }
                }
            ]]
        })
    })

    /**
     *  修改 strong的 方法
     *   01 拿到 输输入的值
     *   02 ajax 发送数据到服务器
     *   03 dataGrid 重写加载数据
     *
     *    修改strong需要的数据:
     *       strong的值
     *       host的id
     *
     */
    function changeStrong(obj, value, hid) {
        console.log("obj = " + obj);
        console.log("value = " + value);
        console.log("hid = " + hid);
        // 01 如果 之前的strong 如果和编辑后的值不一样, 才发送ajax
        // 之前的 strong 值 是 value
        // 编辑后的值 strong 值 obj.value
        var newStrong = obj.value;
        if (newStrong != value) { // 发送ajax
            $.post("host/strongUp.do",
                {
                    strong: newStrong,
                    hid: hid
                },
                function (data) {
                    console.log(data);
                    // 修改成功 信息提示
                    // dataGrid 数据重新加载
                    if (data.success) {
                        $.messager.alert("提示", data.msg, "info");
                        $("#hostDataGrid").datagrid("reload");
                    } else {
                        $.messager.alert("提示", data.msg, "error");
                    }
                },
                "json"
            );
        }
    }

    /**
     * 条件查询
     */
    $(function () {

        $("#search").click(function () {
            // 发送 条件查询的 数据 查询分页

            // load   查询当前页面的数据
            // {} 可以给参数
            $("#hostDataGrid").datagrid('load',
                {
                    hname: $("#hname").val(),
                    status: $("#status").val(),
                    strong: $("#strong").val(),
                    hpstar: $("#hpstar").val(),
                    hpdiscount: $("#hpdiscount").val()
                }
            )
        });

    })

    // 添加
    $(function () {

        $("#addBtn").click(function () {
            // 01 点击 单出对话框
            $("#addHostDialog").dialog("open");

            // 02 编辑 添加对话框
        });

        // 表单提交数据
        $("#addHostSubmit").click(function () {
            // 03 提交数据
            $("#addHostForm").form("submit", {
                url: "host/addHost.do",
                success: function (data) {
                    // 04 页面的数据更新
                    var d = JSON.parse(data);

                    if (d.success) {

                        // 成功
                        // 01 信息提示
                        $.messager.alert("提示", d.msg, "info");
                        // 03 dialog 关闭
                        $("#addHostDialog").dialog("close");
                        // 02 datagird 重写加载
                        $("#hostDataGrid").datagrid("reload");
                        // 04  form 提交数据清理
                        $("#addHostForm").form("clear");
                    } else {
                        $.messager.alert("提示", d.msg, "info");
                    }
                }
            })
        })
    });

    // 账号禁用
    $(function () {

        // 01 给 账号禁用添加点击事件
        $("#disableBtn").click(function () {

            // 02 拿到 datagrid的选中的host的数据
            var trs = $("#hostDataGrid").datagrid('getChecked');

            if (trs.length > 0) {
                // 03 把多个host的数据hid和status 拼接成字符串
                var hids = "";
                var statuss = "";

                for (var i = 0; i < trs.length; i++) {
                    // 拿到每一行的数据
                    hids += trs[i].hid + ",";
                    statuss += trs[i].status + ",";
                }
                // 04 ajax发送数据到 服务器
                $.post("host/hostAccountUp.do", {
                        hids: hids,
                        statuss: statuss,
                    },
                    function (data) {
                        // 进行判断
                        // 01 信息提示
                        $.messager.alert("提示", data.msg, "info")
                        // 02 datagrid 重写加载数据
                        $("#hostDataGrid").datagrid('reload');
                    }, "json"
                )

            } else {
                $.messager.alert("提示", "敢不敢选中一个进行禁用", "error");
            }

        });

    });

    // 权限 的设置

    $(function () {

        // 给权限 的 dialog 添加 onClose 事件
        $("#hostPowerDialog").dialog({
            onClose:function () {
                $("#hostPowerForm").form('clear');
            }
        });


        $("#editBtnPower").click(function () {

            // 01  拿到选中的 host
            var hosts = $("#hostDataGrid").datagrid('getChecked');


            if (hosts.length == 1) {
                console.log(hosts[0]);
                // 选中了 trs 的数据, 设置 hid
                $("#hostid").val(hosts[0].hid);
                // 02 判断 host 是否 有 power
                var hostPower = hosts[0].hostPower;
                if (hostPower) {
                    // 03 如果有 回显数据
                    console.log(hostPower);

                    // 更新的时候, 如果 hostpower 存在  更新操作
                    // 更新的时候, 如果 hostpower 不存在  添加hostpower
                    $("#hpid").val(hostPower.hpid);

                    // 权限的 数据设置 显示
                    // 是否推荐
                    hostPower.hpstar == '1' ? $("#hpstart_yes").radiobutton({checked: true}) : $("#hpstart_no").radiobutton({checked: true})

                    // 星推荐日期
                    // 开始
                    $("#hpstar_begindate").datebox('setValue', jsonToDate(hostPower.hpstartBegindate));
                    // 结束
                    $("#hpstar_enddate").datebox('setValue', jsonToDate(hostPower.hpstarEnddate));

                    // 星推荐时间回显
                    $("#hpstar_begintime").timespinner('setValue',jsonToTime(hostPower.hpstarBegintime))
                    $("#hpstar_endtime").timespinner('setValue',jsonToTime(hostPower.hpstarEndtime))

                    // 自填订单
                    hostPower.hpOrderPower == "1" ? $("#hpOrderPower_yes").radiobutton({checked: true}) :
                        $("#hpOrderPower_no").radiobutton({checked: true});

                    // 折扣
                    $("#hp_discount").textbox('setValue', hostPower.hpdiscount);

                    // 折扣日期
                    $("#hp_dis_starttime").datebox('setValue',jsonToDate(hostPower.hpDisStarttime));
                    $("#hp_dis_endtime").datebox('setValue',jsonToDate(hostPower.hpDisEndtime));

                    //价格
                    $("#hpprice").textbox('setValue', hostPower.hpprice);
                    //管理费
                    $("#hpcosts").textbox('setValue', hostPower.hpcosts);

                }
                // 展示Powerdialog
                $("#hostPowerDialog").dialog('open');

                // 03 如果没有 编辑数据
            } else if (hosts.length > 1) {
                $.messager.alert("提示", "权限编辑只能单个修改", "error");
            } else {
                $.messager.alert("提示", "权限编辑必须选中一个host", "error");
            }
        });

        $("#hostPowerFromSubmit").click(
            function () {

            // 04 提交数据
                $("#hostPowerForm").form('submit',{
                    url:"hostPower/update.do",
                    success:function (data) {
                        // 05 回写数据判断 页面的数据更新
                        var d = JSON.parse(data);
                        if (d.success){
                            // 01 信息提示
                            $.messager.alert("提示",d.msg,"info");
                            // 02 dialog 关闭
                            $("#hostPowerDialog").dialog('close');
                            // 03  datagird 重新加载数据
                            $("#hostDataGrid").datagrid('reload');
                            // 04  form表单的数据的清理
                            $("#hostPowerForm").form('clear');
                        }
                    }
                })
        });
    })

    // 批量权限的处理

    $(function () {

        $("#batchBtn").click(function () {

            // 01 拿到 选中的 host 进行权限添加
            var trs = $("#hostDataGrid").datagrid('getChecked');

            if (trs.length > 0 ){

                // 弹出出 编辑权限的对话框
                // 02 弹出出编辑权限的对话框

                // 把 选中的host的id设置到表单中
                var hids = "";
                for(var i = 0 ; i< trs.length; i++){
                    hids +=trs[i].hid + ",";
                }
                // 把 hids 设置到表单 中
                $("#hids").val(hids);

                $("#hostPowerBatchDialog").dialog('open');
                // 03 编辑对话框


            }else{
                $.messager.alert("提示", "必须选中一个host进行权限设置", "error");
            }

        });

        // 表单提交数据
        $("#hostPoweBatchrFromSubmit").click(function () {

            // 04 提交数据 (权限的数据 + (选中的host的hid))
            $("#hostPowerBatchForm").form('submit',{
                url:'hostPower/batch.do',
                success:function (data) {

                    // 05 更新成功 页面刷新
                    var  d = JSON.parse(data);
                    // 01 信息提示
                    $.messager.alert("提示", d.msg, "error");
                    // 02 dialog 关闭
                    $("#hostPowerBatchDialog").dialog('close');
                    // 03  datagrid reload
                    $("#hostDataGrid").datagrid('reload');
                    // 04  form 的数据清理
                    $("#hostPowerBatchForm").form('clear');
                }
            })
        })
    });


</script>
<script>
    /************声明函数将json类型的时间转换为日期*********/
    //日期转换
    function jsonToDate(obj) {
        return obj.year + "-" + obj.monthValue + "-" + obj.dayOfMonth;
    }

    //时间转换
    function jsonToTime(obj) {
        //return "17:45:00"
        var h = obj.hour < 10 ? ("0" + obj.hour) : obj.hour;
        var m = obj.minute < 10 ? "0" + obj.minute : obj.minute;
        var s = obj.second < 0 ? "0" + obj.second : obj.second;
        return h + ":" + m + ":" + s;
    }
</script>

<%--设置日期框的格式--%>
<script type="text/javascript">
    // datebox组件格式化日期
    //设置日期的格式
    function myformatter(date) {
        var y = date.getFullYear();
        var m = date.getMonth() + 1;
        var d = date.getDate();
        return y + '-' + (m < 10 ? ('0' + m) : m) + '-' + (d < 10 ? ('0' + d) : d);
    }

    // 格式化后的时间 进行 转换才可以修改
    function myparser(s) {
        if (!s) return new Date();
        var ss = (s.split('-'));
        var y = parseInt(ss[0], 10);
        var m = parseInt(ss[1], 10);
        var d = parseInt(ss[2], 10);
        if (!isNaN(y) && !isNaN(m) && !isNaN(d)) {
            return new Date(y, m - 1, d);
        } else {
            return new Date();
        }
    }
</script>

<%-- 批量处理 权限的添加 --%>
<div id="hostPowerBatchDialog" class="easyui-dialog" title="权限设置" style="width:600px;height:530px;"
     data-options="iconCls:'icon-save',resizable:false,modal:true,closed:true,left:300,top:10">
    <%--创建主持人增加的表单--%>
    <form id="hostPowerBatchForm" method="post">
        <%--创建隐藏标签存储要进行数据权限更新的主持人的ID--%>
        <input type="hidden" name="hids" id="hids" value="">
        <%--创建表格--%>
        <table cellpadding="10px" style="margin: auto;margin-top: 20px;">
            <tr>
                <td>是否星推荐:</td>
                <td>
                    <input class="easyui-radiobutton"  name="hpstar" value="1" label="是"
                           labelPosition="after">
                    <input class="easyui-radiobutton" name="hpstar" value="0" label="否"
                           labelPosition="after">
                </td>
            </tr>
            <tr>
                <td>星推荐日期:</td>
                <td>
                    <input  data-options="formatter:myformatter,parser:myparser"
                           data-options="showSeconds:true" name="hpstartBegindate" type="text" class="easyui-datebox">
                    -
                    <input  data-options="formatter:myformatter,parser:myparser" name="hpstarEnddate"
                           type="text" class="easyui-datebox">
                </td>
            </tr>
            <tr>
                <td>星推荐时间:</td>
                <td>
                    <input  name="hpstarBegintime" type="text" data-options="showSeconds:true"
                           class="easyui-timespinner">
                    -
                    <input name="hpstarEndtime" type="text" data-options="showSeconds:true"
                           class="easyui-timespinner">
                </td>
            </tr>
            <tr>
                <td>自填订单:</td>
                <td>
                    <input class="easyui-radiobutton"  name="hpOrderPower" value="1" label="是"
                           labelPosition="after">
                    <input class="easyui-radiobutton"  name="hpOrderPower" value="0" label="否"
                           labelPosition="after">
                </td>
            </tr>
            <tr>
                <td>折扣:</td>
                <td>
                    <input class="easyui-textbox" name="hpdiscount" prompt="请输入折扣" iconWidth="28"
                           style="width:300px;height:34px;padding:10px;">
                </td>
            </tr>
            <tr>
                <td>折扣日期:</td>
                <td>
                    <input  data-options="formatter:myformatter,parser:myparser"
                           name="hpDisStarttime" type="text" class="easyui-datebox">
                    -
                    <input  data-options="formatter:myformatter,parser:myparser" name="hpDisEndtime"
                           type="text" class="easyui-datebox">
                </td>
            </tr>
            <tr>
                <td>价格:</td>
                <td>
                    <input class="easyui-textbox" name="hpprice" prompt="请输入价格" iconWidth="28"
                           style="width:300px;height:34px;padding:10px;">
                </td>
            </tr>
            <tr>
                <td>管理费:</td>
                <td>
                    <input class="easyui-textbox" name="hpcosts" prompt="请输入管理费" iconWidth="28"
                           style="width:300px;height:34px;padding:10px;">
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <a href="javascript:void(0)" id="hostPoweBatchrFromSubmit" class="easyui-linkbutton c3"
                       style="width:120px">点击完成</a>
                </td>
            </tr>
        </table>
    </form>
</div>



<%--创建主持人权限设置的对话框--%>
<div id="hostPowerDialog" class="easyui-dialog" title="权限设置" style="width:600px;height:530px;"
     data-options="iconCls:'icon-save',resizable:false,modal:true,closed:true,left:300,top:10">
    <%--创建主持人增加的表单--%>
    <form id="hostPowerForm" method="post">
        <%--创建隐藏标签存储要进行数据权限更新的ID--%>
        <input type="hidden" name="hpid" id="hpid" value="">
        <%--创建隐藏标签存储要进行数据权限更新的主持人的ID--%>
        <input type="hidden" name="hostid" id="hostid" value="">
        <%--创建表格--%>
        <table cellpadding="10px" style="margin: auto;margin-top: 20px;">
            <tr>
                <td>是否星推荐:</td>
                <td>
                    <input class="easyui-radiobutton" id="hpstart_yes" name="hpstar" value="1" label="是"
                           labelPosition="after">
                    <input class="easyui-radiobutton" id="hpstart_no" name="hpstar" value="0" label="否"
                           labelPosition="after">
                </td>
            </tr>
            <tr>
                <td>星推荐日期:</td>
                <td>
                    <input id="hpstar_begindate" data-options="formatter:myformatter,parser:myparser"
                           data-options="showSeconds:true" name="hpstartBegindate" type="text" class="easyui-datebox">
                    -
                    <input id="hpstar_enddate" data-options="formatter:myformatter,parser:myparser" name="hpstarEnddate"
                           type="text" class="easyui-datebox">
                </td>
            </tr>
            <tr>
                <td>星推荐时间:</td>
                <td>
                    <input id="hpstar_begintime" name="hpstarBegintime" type="text" data-options="showSeconds:true"
                           class="easyui-timespinner">
                    -
                    <input id="hpstar_endtime" name="hpstarEndtime" type="text" data-options="showSeconds:true"
                           class="easyui-timespinner">
                </td>
            </tr>
            <tr>
                <td>自填订单:</td>
                <td>
                    <input class="easyui-radiobutton" id="hpOrderPower_yes" name="hpOrderPower" value="1" label="是"
                           labelPosition="after">
                    <input class="easyui-radiobutton" id="hpOrderPower_no" name="hpOrderPower" value="0" label="否"
                           labelPosition="after">
                </td>
            </tr>
            <tr>
                <td>折扣:</td>
                <td>
                    <input class="easyui-textbox" id="hp_discount" name="hpdiscount" prompt="请输入折扣" iconWidth="28"
                           style="width:300px;height:34px;padding:10px;">
                </td>
            </tr>
            <tr>
                <td>折扣日期:</td>
                <td>
                    <input id="hp_dis_starttime" data-options="formatter:myformatter,parser:myparser"
                           name="hpDisStarttime" type="text" class="easyui-datebox">
                    -
                    <input id="hp_dis_endtime" data-options="formatter:myformatter,parser:myparser" name="hpDisEndtime"
                           type="text" class="easyui-datebox">
                </td>
            </tr>
            <tr>
                <td>价格:</td>
                <td>
                    <input class="easyui-textbox" id="hpprice" name="hpprice" prompt="请输入价格" iconWidth="28"
                           style="width:300px;height:34px;padding:10px;">
                </td>
            </tr>
            <tr>
                <td>管理费:</td>
                <td>
                    <input class="easyui-textbox" id="hpcosts" name="hpcosts" prompt="请输入管理费" iconWidth="28"
                           style="width:300px;height:34px;padding:10px;">
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <a href="javascript:void(0)" id="hostPowerFromSubmit" class="easyui-linkbutton c3"
                       style="width:120px">点击完成</a>
                </td>
            </tr>
        </table>
    </form>
</div>

<%--添加的 dialog --%>
<div id="addHostDialog" class="easyui-dialog" title="添加主持人" style="width:440px;height:300px;"
     data-options="iconCls:'icon-save',resizable:false,modal:true,closed:true">

    <form id="addHostForm" method="post">
        <div style="text-align: center;margin-top: 28px">
            <input name="hname" class="easyui-textbox" data-options="prompt:'输入主持人姓名'" style="width:200px">
        </div>

        <div style="text-align: center;margin-top: 28px">
            <input name="hpwd" class="easyui-passwordbox" data-options="prompt:'输入主持人密码'" style="width:200px">
        </div>

        <div style="text-align: center;margin-top: 28px">
            <input name="hphone" class="easyui-textbox" data-options="prompt:'输入主持人电话'" style="width:200px">
        </div>

        <div style="text-align: center;margin-top: 28px">
            <a id="addHostSubmit" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">添加主持人</a>
        </div>
    </form>

</div>

<%-- 条件查询 组件  --%>
<div style="width: 100%;height:30px; margin: 10px auto;text-align: center">

    <form id="hostConditionForm" method="post" class="easyui-form">

        <%--        姓名的条件 --%>
        <input id="hname" name="hname" class="easyui-textbox" data-options="prompt:'姓名',width:100"/>

        <%--    状态的条件  --%>
        <select id="status" name="status" class="easyui-combobox"
                data-options="panelHeight:'auto',editable:false,value:'状态'" style="width:100px;">
            <option value="1">正常</option>
            <option value="0">禁用</option>
        </select>

        <%--    权重的条件
           asc 升序
           desc 升序
         --%>
        <select id="strong" name="strong" class="easyui-combobox"
                data-options="panelHeight:'auto',editable:false,value:'权重排序'" style="width:100px;">
            <option value="asc">权重升序</option>
            <option value="desc">权重降序</option>
        </select>

        <%--            星推荐 条件 --%>
        <select id="hpstar" name="hpstar" class="easyui-combobox"
                data-options="panelHeight:'auto',editable:false,value:'星推荐'" style="width:100px;">
            <option value="1">推荐</option>
            <option value="0">不推荐</option>
        </select>

        <%--            折扣条件 --%>
        <select id="hpdiscount" name="hpdiscount" class="easyui-combobox"
                data-options="panelHeight:'auto',editable:false,value:'折扣'" style="width:100px;">
            <option value="6">6</option>
            <option value="7">7</option>
            <option value="8">8</option>
            <option value="9">9</option>
        </select>

        <a id="search" href="javascript:void(0)" class="easyui-linkbutton"
           data-options="iconCls:'icon-search',width:100">查询</a>
        <%--            <a id="poi" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok',width:100">导出</a>--%>
    </form>

</div>
<%--
    展示 主持信息的datagird
      导入 easyui 的资源
--%>
<table id="hostDataGrid" data-options="width:900,height:350">
</table>
<div id="tb">
    <a id="addBtn" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加主持人</a>
    <a id="editBtnPower" href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-edit'">权限设置</a>
    <a id="disableBtn" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cut'">账号禁用</a>
    <a id="batchBtn" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">批量操作</a>
</div>

</body>
</html>
