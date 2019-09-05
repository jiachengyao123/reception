<%--
  Created by IntelliJ IDEA.
  User: jia
  Date: 2019-08-28
  Time: 15:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>太平洋保险</title>
    <%-- layui --%>
    <link rel="stylesheet" href="<%= request.getContextPath()%>/static/layui-v2.5.4/layui/css/layui.css"/>
    <script src="<%= request.getContextPath()%>/static/js/jquery-3.2.1.min.js"></script>
</head>
<style>
    *{
        margin: 0px;
    }
</style>
<script>
    $(function () {
       window.setInterval(math,3000)
        function math() {
            var r=Math.round((Math.random()+1)*100);
            var a=Math.round((Math.random()+1)*100);
            var b=Math.round((Math.random()+1)*100);
            $("#body").css("background-color","rgba("+b+","+a+","+r+",0.96)")
        }
    })



</script>
<body id="body" style="background-color: #0C0C0C">
<div style="margin-left:570px;margin-top: 100px ">
<form class="layui-form layui-form-pane"  action="">
    <div class="layui-form-item">
        <label class="layui-form-label"><i class="layui-icon layui-icon-username"></i></label>
        <div class="layui-input-inline">
            <input type="text" name="userCode" required   lay-verify="required" placeholder="请输入账户" autocomplete="off" value="${userCode}" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label"><i class="layui-icon layui-icon-password"></i></label>
        <div class="layui-input-inline">
            <input type="password" name="password" required lay-verify="required" placeholder="请输入密码" autocomplete="off" value="${password}" class="layui-input">
        </div>

    </div>


    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 120px">是否记住密码:</label>
        <div class="layui-input-block">
            <input type="checkbox" name="jpwd" lay-skin="switch">
        </div>
        <div class="layui-form-mid" style="color: red" id="tis"></div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
            <button type="reset" class="layui-btn layui-btn-primary" >重置</button>
        </div>
    </div>
</form>
</div>
</body>
<script src="<%= request.getContextPath()%>/static/layui-v2.5.4/layui/layui.js" charset="utf-8" ></script>
<script type="text/javascript">
    //判断记住密码默认选中
     $("input[name='password']").val()!=""?
         $("input[name='jpwd']").prop("checked",true):$("input[name='jpwd']").prop("checked",false)

    layui.use(["form","jquery"],function () {
        var form=layui.form;
        //监听提交
        form.on('submit(formDemo)', function(data){
            //
            // layer.msg(JSON.stringify(data.field));

            $.post({
                url:"${pageContext.request.contextPath}/secUser/getUser",
                data:data.field,
                success:function (data) {
                   if(data.login){
                    location.href="${pageContext.request.contextPath}/jsps/show.jsp";
                   }else{
                       $("#tis").text(data.msg)
                   }
                }
            })
            return false;
        });
    })
</script>
</html>
