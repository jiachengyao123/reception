<%--
  Created by IntelliJ IDEA.
  User: jia
  Date: 2019-08-30
  Time: 09:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户管理</title>
    <link rel="stylesheet" href="<%= request.getContextPath()%>/static/layui-v2.5.4/layui/css/layui.css"/>
    <link rel="stylesheet" href="<%= request.getContextPath()%>/static/zTree_v3/css/zTreeStyle/zTreeStyle.css"/>
    <script src="<%= request.getContextPath()%>/static/js/jquery-3.2.1.min.js"></script>
    <script src="<%= request.getContextPath()%>/static/zTree_v3/js/jquery.ztree.all.min.js" charset="utf-8"></script>
</head>
<body>
<div class="layui-row">
    <div class="layui-col-md4">
        <ul id="ztree" class="ztree"></ul>
    </div>
    <div class="layui-col-md8">
        <div class="layui-collapse lay-accordion" style="height: 90%">
            <div class="layui-colla-item">
                <h2 class="layui-colla-title" id="h2">用户列表信息</h2>
                <div class="layui-colla-content layui-show" style="height: 100%">
                    <table id="dataTable" lay-filter="test"></table>
                </div>
            </div>
        </div>
        <button class="layui-btn layui-bg-green" onclick="addBtn()"><i class="layui-icon layui-icon-add-circle" style="font-size:18px ">&nbsp;&nbsp;Add</i></button>
    </div>
</div>
<!--模仿bootstrap的模态框-->
<div id="motaikunag" style="display: none;">
    <div class="layui-row">
        <form class="layui-form layui-form-pane"  action="" style="margin-left: 60px">
            <div class="layui-form-item">
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">用户归属地:</label>
                <div class="layui-input-inline">
                    <input type="text"  autocomplete="off"  id="treeName"  readonly="readonly" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">用户名称:</label>
                <div class="layui-input-inline">
                    <input type="text"  autocomplete="off"   name="userName" required   lay-verify="required" placeholder="请输入用户名称" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">用户账户:</label>
                <div class="layui-input-inline">
                    <input type="text" name="userCode" required   lay-verify="required" placeholder="请输入账户" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">密码:</label>
                <div class="layui-input-inline">
                    <input type="password" name="password" required   lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">
                </div>
            </div>
            <input name="ressid" type="hidden">
            <input name="Level" type="hidden">
            <input name="userLevel" type="hidden" value="${user.userLevel}">
            <div class="layui-form-item " style="text-align: center">
                <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
            </div>
        </form>
    </div>
</div>
</body>
<script src="<%= request.getContextPath()%>/static/layui-v2.5.4/layui/layui.js" charset="utf-8" ></script>
<script type="text/javascript">
    var setting = {
        data: {
            simpleData: {
                enable: true,//开启简单数据格式
                idKey: "id",
                pIdKey: "pid",
                rootPId: 0
            }
        },
        async:{
            enable:true,
            url:"${pageContext.request.contextPath}/secAddress/getsecAddress",
        },
        view: {
            selectedMulti: false ,//禁止多选
            showLine:false
        },
        callback: {
            onClick:ztreeOnClick,
        }
    }
    /*初始化ztree*/
    zTreeObj = $.fn.zTree.init($("#ztree"), setting);
    //点击事件
    function ztreeOnClick(event,treeId,treeNode){
       $("input[name='ressid']").val(treeNode.id);
        $("input[name='Level']").val(treeNode.level+1);
        $("#treeName").val(treeNode.name);
        //table
        layui.use('table', function(){
            var table = layui.table;
            //第一个实例
            table.render({
                elem: '#dataTable'
                ,method:"post"
                ,height: 312
                ,where:{ressid:treeNode.id}
                ,cellMinWidth: 100 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
                ,url: '${pageContext.request.contextPath}/secUser/getUserTable' //数据接口
                ,page: true //开启分页
                ,cols: [[ //表头
                    {field: 'id', title: 'ID', width:120, sort: true, fixed: 'left'}
                    ,{field: 'userName', title: '用户名称', width:100}
                    ,{field: 'userCode', title: '用户账户', width:100, sort: true}
                    ,{field: 'userLevel', title: '用户级别', width:100, sort: true}
                    ,{ title: '操作', width:200,fixed: 'right',toolbar:"#barDemo"
                    }
                ]]
            });
        });
    };

    function addBtn() {
        layui.use(["form","layer"],function () {
            var form=layui.form;
            var layer=layui.layer;
            if($("input[name='ressid']").val()==""){
                layer.msg("请先选择用户归宿地")
                return
            }
            if($("input[name='userLevel']").val()==2 && $("input[name='userLevel']").val() >=$("input[name='Level']").val()){
                layer.msg("权限不够，无法添加")
                return
            }
            //自定页
            layer.open({
                title:"添加用户信息",
                type: 1,
                offset:'t',
                skin: 'layui-layer-rim', //加上边框
                area: ['420px', '330px'], //宽高
                content: $("#motaikunag")
            });

            form.on("submit(formDemo)",function (data) {
                $.post({
                    url:"${pageContext.request.contextPath}/secUser/getAddsecUser",
                    data:data.field,
                    dataType:"json",
                    success:function (data) {
                        layer.closeAll();
                        data?layer.msg("添加成功"):layer.msg("添加失败");
                    }
                })
                return false;
            })
        })

    }
</script>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
</html>
