<%--
  Created by IntelliJ IDEA.
  User: jia
  Date: 2019-08-29
  Time: 15:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>机构管理</title>
    <link rel="stylesheet" href="<%= request.getContextPath()%>/static/layui-v2.5.4/layui/css/layui.css"/>
    <link rel="stylesheet" href="<%= request.getContextPath()%>/static/zTree_v3/css/zTreeStyle/zTreeStyle.css"/>
    <script src="<%= request.getContextPath()%>/static/js/jquery-3.2.1.min.js"></script>
    <script src="<%= request.getContextPath()%>/static/zTree_v3/js/jquery.ztree.all.min.js" charset="utf-8"></script>
</head>
<body>
<input id="userlevel" value="${user.userLevel}" type="hidden">
<div class="layui-row">
   <div class="layui-col-md5">
    <ul id="ztree" class="ztree"></ul>
   </div>
    <div class="layui-col-md7">

    </div>
</div>

<!--模仿bootstrap的模态框-->
<div id="motaikunag" style="display: none;">
    <div class="layui-row">
        <form class="layui-form layui-form-pane"  action="" style="margin-left: 60px">
            <div class="layui-form-item">

            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">父节点:</label>
                <div class="layui-input-inline">
                    <input type="text" value="" autocomplete="off" id="fuZtree" readonly="readonly" class="layui-input">
                </div>
            </div>
        <div class="layui-form-item">
            <label class="layui-form-label">子节点名称:</label>
            <div class="layui-input-inline">
                <input type="text" name="name" required   lay-verify="required" placeholder="请输入名称" autocomplete="off" class="layui-input">
            </div>
        </div>
            <input name="pid" type="hidden">
            <input name="level" type="hidden">
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
            addHoverDom: addHoverDom, //自定义鼠标放上
             removeHoverDom: removeHoverDom, //自定义移除
             selectedMulti: false ,//禁止多选
            showLine:false
        },
        edit: {
            enable: true,//开启可编辑
            editNameSelectAll: true,//点击修改默认选中
            removeTitle: "删除节点",
            renameTitle: "编辑节点名称",
            showRemoveBtn: setRemoveBtn
        },
        callback: {
            onClick:ztreeOnClick,
            beforeRemove: zTreeBeforeRemove,//删除之前的回调判断
            beforeRename: zTreeBeforeRename,//改名之前的回调判断
            // onRemove: zTreeOnRemove,//删除之后,操作后台
            // onRename: zTreeOnRename,//改名之后,操作后台
            beforeDrag: zTreeOnDrag//禁止拖拽
        }

    }

        /*初始化ztree*/
        zTreeObj = $.fn.zTree.init($("#ztree"), setting);
    function ztreeOnClick(event,treeId,treeNode){

    };

    /*自定义添加节点信息*/
    function addHoverDom(treeId, treeNode) {
        if(treeNode.level==2){
            return
        }
        var aObj = $("#" + treeNode.tId + "_a");
        if ($("#diyBtn_"+treeNode.id).length>0) return;
        var editStr ="<span type='button' class='button add' id='diyBtn_" + treeNode.id
            + "' title='添加节点' onfocus='this.blur();'></span>";
        aObj.append(editStr);
        var btn = $("#diyBtn_"+treeNode.id);
        if (btn) btn.bind("click", function(){
            /* ztree的添加方法  */
            addNodes(treeId,treeNode);

        });

    };
    //添加zTreeName名
    function addNodes(treeId,treeNode){
        if($("#userlevel").val()!="" && $("#userlevel").val()==2){
            if(treeNode.level==0){
                alert("权限不够:无法操作")
                return
            }
        }
        $("#fuZtree").val(treeNode.name)
        $("input[name='pid']").val(treeNode.id)
        $("input[name='level']").val(treeNode.level+2)
        layui.use(["layer","form"],function () {
            var layer=layui.layer;
            var form=layui.form;
           // var index=layer.open();
            //自定页
            layer.open({
                title:"添加节点信息",
                type: 1,
                skin: 'layui-layer-rim', //加上边框
                area: ['420px', '240px'], //宽高
                content: $("#motaikunag")
            });

            form.on("submit(formDemo)",function (data) {

                $.post({
                    url:"${pageContext.request.contextPath}/secAddress/getAddsecAddress",
                    data:data.field,
                    dataType:"json",
                    success:function (data) {
                        layer.closeAll();
                        data?layer.msg("添加节点成功"):layer.msg("添加节点失败");
                        zTreeObj.reAsyncChildNodes(null,"refresh")
                    },error:function () {
                        alert("error")
                    }
                })
                return false;
            })
        })
    };
    /* 鼠标移除节点方法 */
    function removeHoverDom(treeId, treeNode) {
        $("#diyBtn_"+treeNode.id).unbind().remove();
    };


    //设置所有的父节点不显示删除按钮
    function setRemoveBtn(treeId, treeNode) {
        return !treeNode.isParent;
    }
    /*删除之前的回调函数*/
    function zTreeBeforeRemove(treeId, treeNode) {
        if(window.confirm("是否删除这个节点?")){
            if( treeNode.isParent){
                alert("当前节点为父节点不能删除");
                return false;
            }else {
                $.ajax({
                    url:"${pageContext.request.contextPath}/secAddress/getDelzTree",
                    data:{id:treeNode.id},
                    type:"post",
                    dataType:"json",
                    success:function (data) {
                        if(data){
                            alert("删除成功");
                            // ztreeObj.reAsyncChildNodes(null, "refresh");//刷新ztree
                            return true;
                        }else{
                            alert("error");
                            return false;
                        }

                    }

                })
            }
        }else{
            return false;
        }

    }

    /*编辑节点之前的回调函数*/
    function zTreeBeforeRename(treeId, treeNode, newName, isCancel) {
        if($("#userlevel").val()!="" && $("#userlevel").val()==2){
            if(treeNode.level==0 || treeNode.level==1){
                alert("权限不够:无法操作")
                return
            }
        }
        if(newName.length >=2){
            var fals= confirm("你确定改为："+treeNode.tId + ", " + newName);
            if(fals){
                // //name名截取[]
                // var b=newName.indexOf("[");
                // var name =newName.substring(b);
                $.ajax({
                    url:'${pageContext.request.contextPath}/secAddress/getUpdatazTreeName',
                    type:"post",
                    data:{id:treeNode.id,name:newName},
                    dataType:"json",
                    success:function (data) {
                        if(data){
                            alert("修改成功");
                            // ztreeObj.reAsyncChildNodes(null, "refresh");//刷新ztree
                            return true;
                        }else{
                            alert("error")
                            return false;
                        }
                    }

                })
            }
        }else{
            alert("至少5个字符");
            return false;
        }


    }

    /*禁止拖拽*/
    function zTreeOnDrag(){
        return false;
    }

</script>
</html>
