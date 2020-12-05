<%--
  Created by IntelliJ IDEA.
  User: 25499
  Date: 2020/2/24
  Time: 16:45
  To change this template use File | Settings | File Templates.
--%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" %>
<html>
<head>
    <base href="<%=basePath %>"/>
    <title>Title</title>
    <%--引入easyUI的资源--%>
    <link rel="stylesheet" type="text/css" href="static/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="static/themes/icon.css">
    <script type="text/javascript" src="static/js/jquery.min.js"></script>
    <script type="text/javascript" src="static/js/jquery.easyui.min.js"></script>
    <%--声明js代码域--%>
    <script type="text/javascript">
        var nums=30;
        var id;
        /*****************新人注册******************/
        $(function () {
            //给完成注册按钮增加单击事件
            $("#add").click(function () {
                //提交表单
                $("#addMarriedForm").form('submit',{
                    url:"marriedPerson/reg.do",
                    success:function (data) {
                        //转换
                        console.log(data)
                        var d = JSON.parse(data);
                        console.log(d);
                        if(d.success){
                            $.messager.alert("提示","新人注册成功","info",function () {
                                window.location.href="index.jsp";
                            });
                        }
                    }
                })

            })
        })
        /*****************获取手机验证码******************/
        $(function () {
            //给获取验证码按钮增加单击事件
            $("#code").click(function () {
                //校验手机号是否填写。
                var phone=$("#phone").val();
                if(phone==""){
                    $.messager.alert("提示","手机号不能为空","info");
                    return;
                }
                //发起ajax请求获取手机验证码
                $.ajax({
                    type:'post',
                    url:'marriedPerson/personCode.do',
                    data:"phonenumber="+phone,
                    success:function (data) {
                        if(data=="OK"){
                            $.messager.alert("提示","验证码已发送，注意查收","info");
                            $("#code").linkbutton({disabled:true});
                            //将时间赋值到span中
                            $("#codeSpan").html(nums+"s");
                            //验证码倒计时
                            var newCode = <%=session.getAttribute("newCode")%>;
                            console.log(newCode)
                            id=window.setInterval(function () {
                                nums=nums-1;
                                if(nums>0){
                                    $("#codeSpan").html(nums+"s");
                                }else{
                                    window.clearInterval(id);//关闭倒计时
                                    $("#code").linkbutton({disabled:false});
                                    $("#codeSpan").html("请点击重新获取验证码");
                                }
                            },1000)
                        }
                    }
                })
            })
        })
        /*****************公司注册******************/
        $(function () {
            //给完成注册按钮增加单击事件
            $("#add2").click(function () {
                //提交表单
                $("#addCompanyForm").form('submit',{
                    url:"company/addCompany.do",
                    success:function (data) {
                        if(data){
                            $.messager.alert("提示","公司注册成功","info",function () {
                                window.location.href="index.jsp";
                            });
                        }
                    }
                })
            })
        })

    </script>
</head>
<body>
    <%--创建注册头部--%>
    <div style="margin: auto;width:1240px; ">
        <div id="p1" class="easyui-panel" style="width:1240px;height:120px;padding:10px;"
             data-options="iconCls:'icon-save',closable:true, collapsible:true,minimizable:true,maximizable:true,border:false">
            <img src="static/images/reg.png" alt="">
        </div>
    </div>
    <%--创建注册面板--%>
    <div style="margin: auto;width:1161px;margin-top: 20px;">
        <div id="p2" class="easyui-panel" style="width:1161px;height:546px;padding:10px;"
             data-options="iconCls:'icon-save',closable:true, collapsible:true,minimizable:true,maximizable:true,border:false">
            <%--创建注册选项卡--%>
            <div id="tt" class="easyui-tabs" style="width:500px;height:250px;" data-options="fit:true,plain:true">
                <div title="新人注册" style="padding:20px;display:none;">
                    <%--声明表单完成主持人信息的增加--%>
                    <form  id="addMarriedForm" method="post">
                        <table  style="margin: auto;margin-top: 30px;border-collapse: separate;border-spacing: 5px 10px;">
                            <tr>
                                <td>手机号:</td>
                                <td>
                                    <input class="easyui-textbox" style="width: 400px;"  name="phone" id="phone" prompt="手机号">
                                </td>
                            </tr>
                            <tr>
                                <td>姓名:</td>
                                <td>
                                    <input class="easyui-textbox" style="width: 400px;" name="pname" prompt="姓名" >
                                </td>
                            </tr>
                            <tr>
                                <td>邮箱:</td>
                                <td>
                                    <input class="easyui-textbox" style="width: 400px;" name="pmail" prompt="邮箱" >
                                </td>
                            </tr>
                            <tr>
                                <td>密码:</td>
                                <td>
                                    <input class="easyui-passwordbox" style="width: 400px;" name="ppwd" prompt="密码" >
                                </td>
                            </tr>
                            <tr>
                                <td>确认密码:</td>
                                <td>
                                    <input class="easyui-passwordbox" style="width: 400px;"  prompt="确认密码" >
                                </td>
                            </tr>
                            <tr>
                                <td>验证码:</td>
                                <td>
                                    <input name="newCode" class="easyui-textbox" style="width: 400px;"  prompt="验证码" >
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <input class="easyui-checkbox" checked="checked">&nbsp;&nbsp;&nbsp;
                                    已阅读 <a href="">《Ting域用户注册协议》</a>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <a id="add" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">完成注册</a>
                                    <a id="code" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">获取验证码</a>
                                    <span id="codeSpan"></span>
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>
                <div title="公司注册"  style="overflow:auto;padding:20px;display:none;">
                    <form  id="addCompanyForm" method="post">
                        <table  style="margin: auto;margin-top: 30px;border-collapse: separate;border-spacing: 5px 10px;">
                            <tr>
                                <td>手机号:</td>
                                <td>
                                    <input class="easyui-textbox" style="width: 400px;"  name="cphone" prompt="手机号">
                                </td>
                            </tr>
                            <tr>
                                <td>公司名称:</td>
                                <td>
                                    <input class="easyui-textbox" style="width: 400px;" name="cname" prompt="公司名称" >
                                </td>
                            </tr>
                            <tr>
                                <td>法人:</td>
                                <td>
                                    <input class="easyui-textbox" style="width: 400px;" name="ceo" prompt="法人" >
                                </td>
                            </tr>
                            <tr>
                                <td>公司邮箱:</td>
                                <td>
                                    <input class="easyui-textbox" style="width: 400px;" name="cmail" prompt="公司邮箱" >
                                </td>
                            </tr>
                            <tr>
                                <td>密码:</td>
                                <td>
                                    <input class="easyui-passwordbox" style="width: 400px;" name="cpwd" prompt="密码" >
                                </td>
                            </tr>
                            <tr>
                                <td>确认密码:</td>
                                <td>
                                    <input class="easyui-passwordbox" style="width: 400px;"  prompt="确认密码" >
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <input class="easyui-checkbox" checked="checked">&nbsp;&nbsp;&nbsp;
                                    已阅读 <a href="">《Ting域用户注册协议》</a>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <a id="add2" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">完成注册</a>
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
