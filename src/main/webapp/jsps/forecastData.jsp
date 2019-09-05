<%--
  Created by IntelliJ IDEA.
  User: jia
  Date: 2019-08-30
  Time: 15:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>预报数据</title>
    <link rel="stylesheet" href="<%= request.getContextPath()%>/static/layui-v2.5.4/layui/css/layui.css"/>
    <script src="<%= request.getContextPath()%>/static/js/jquery-3.2.1.min.js"></script>
</head>
<body>
<div class="layui-row" >
<form class="layui-form layui-form-pane"  id="AddFrom" action="" >
    <div class="layui-form-item">
        <input type="hidden" name="userId" value="${user.id}">
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">计划名称:</label>
        <div class="layui-input-inline">
            <input type="text"  autocomplete="off"  name="planName" placeholder="请输入计划名称" required   lay-verify="required" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 120px">计划召开桌数:</label>
        <div class="layui-input-inline">
            <input type="number"  autocomplete="off"  name="planNumberTables" required   lay-verify="required" placeholder="请输入用户名称" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">开始时间:</label>
        <div class="layui-input-inline">
            <input type="text" name="startTime" required  id="startDate"  lay-verify="required"  lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">结束时间:</label>
        <div class="layui-input-inline">
            <input type="text" name="endTime" required  id="endDate"  lay-verify="required"  lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item " style="margin-left: 180px">
        <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
    </div>
</form>
</div>
</body>
<script src="<%= request.getContextPath()%>/static/layui-v2.5.4/layui/layui.js" charset="utf-8" ></script>

<script type="text/javascript">
    layui.use(["form","laydate","jquery"],function () {
        var form=layui.form;
        var laydate=layui.laydate;
        var $=layui.jquery;
        laydate.render({
            elem:"#startDate",
            trigger: 'click'
        })
        laydate.render({
            elem:"#endDate",
            trigger: 'click'
        })
        form.on("submit(formDemo)",function (data) {
            $.post({
                url:"${pageContext.request.contextPath}/secForecastData/getAddsecForecastData",
                data:data.field,
                success:function (data) {
                    data?layer.msg("添加成功"):layer.msg("添加失败");
                    $("#AddFrom")[0].reset()
                    form.render()
                }

            })
            return false;
        })
    })
</script>
</html>
