<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: jia
  Date: 2019-08-30
  Time: 16:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>实际数据</title>
    <link rel="stylesheet" href="<%= request.getContextPath()%>/static/layui-v2.5.4/layui/css/layui.css"/>
    <script src="<%= request.getContextPath()%>/static/js/jquery-3.2.1.min.js"></script>
</head>
<body>
<div class="layui-row">
    <table id="dataTable" lay-filter="test"></table>
</div>
<!--模仿bootstrap的模态框-->
<div id="motaikunag" style="display: none;">
    <div class="layui-row">
        <form class="layui-form layui-form-pane" id="formData" action="" style="margin-left: 100px">
            <%--//隐藏参数--%>
            <input value="${user.id}" type="hidden" id="userid">
            <input type="hidden" name="forecastId" id="forecastId" >
            <div class="layui-form-item">
                <label class="layui-form-label">活动名称:</label>
                <div class="layui-input-inline">
                    <input type="text"  autocomplete="off"  id="treeName"  readonly="readonly" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">实际桌数:</label>
                <div class="layui-input-inline">
                    <input type="number"  autocomplete="off"  name="actualTableCount" placeholder="请输入实际桌数" required   lay-verify="required" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">新客户:</label>
                <div class="layui-input-inline">
                    <input type="number"  autocomplete="off"   name="newCustomers" required   lay-verify="required" placeholder="请输入新客户数量" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">旧客户:</label>
                <div class="layui-input-inline">
                    <input type="number"  autocomplete="off"   name="oldCustomers" required   lay-verify="required" placeholder="请输入旧客户数量" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">意向客户:</label>
                <div class="layui-input-inline">
                    <input type="number"  autocomplete="off"   name="intentionalCustomers" required   lay-verify="required" placeholder="请输入意向客户数量" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">保费:</label>
                <div class="layui-input-inline">
                    <input type="number"  autocomplete="off"   name="premium" required   lay-verify="required" placeholder="请输入保费(万)" class="layui-input">
                </div>
                <div class="layui-form-mid layui-word-aux">万</div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">活动时间:</label>
                <div class="layui-input-inline">
                    <input type="text" name="activityTime" id="startDate" required  lay-verify="required"  lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label for="multipleFile" type="button" class="layui-btn">
                    <i class="layui-icon">&#xe67c;</i>上传活动图片
                </label>
                <span class="layui-form-mid layui-word-aux">按shift键可多选图片-最多传3张</span>
                <input type="file"  hidden="hidden" autocomplete="off" multiple="multiple" id="multipleFile"  onchange="fileimg(this)" required   lay-verify="required">
            </div>
            <div class="layui-form-item" id="imgDiv">

            </div>
            <div class="layui-form-item " style="margin-left: 110px">
                <button class="layui-btn"  type="button" lay-submit lay-filter="formDemo">立即提交</button>
            </div>
        </form>
    </div>
</div>
</body>
<script src="<%= request.getContextPath()%>/static/layui-v2.5.4/layui/layui.js" charset="utf-8" ></script>
<script type="text/javascript">
    layui.use(["form","layer","laydate","table"],function () {
        var form=layui.form;
        var layer=layui.layer;
        var laydate=layui.laydate;
        var table = layui.table;
        //初始化时间
        laydate.render({
            elem:"#startDate",
            trigger: 'click'
        })
        //查询计划表
        if($("#userid").val()!=""){
            //第一个实例
            table.render({
                elem: '#dataTable'
                ,method:"post"
                ,height: 312
                ,where:{status:0,userId:$("#userid").val()}
                ,cellMinWidth: 100 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
                ,url: '${pageContext.request.contextPath}/secForecastData/getsecForecastDataTable' //数据接口
                ,page: true //开启分页
                ,cols: [[ //表头
                    {field: 'id', title: 'ID', width:120, sort: true, fixed: 'left'}
                    ,{field: 'planName', title: '计划名称', width:100,templet:function (e) {
                            return e.planName;
                        }}
                    ,{field: 'planNumberTables', title: '计划桌数', width:100, sort: true}
                    ,{field: 'startTime', title: '开始时间', width:120, sort: true}
                    ,{field: 'endTime', title: '结束时间', width:120, sort: true}
                    ,{ title: '操作', width:200,alert:"center",toolbar:"#barDemo"}
                ]]
            });
        }else {location.href="${pageContext.request.contextPath}/jsps/login.jsp"};
        //监听工具条
        table.on('tool(test)', function(obj){
            var data = obj.data;
            //上报实际数据
            if(obj.event==='edit'){
                $("#treeName").val(data.planName)
                $("#forecastId").val(data.id)
                //自定页
                layer.open({
                    title:"录入活动数据",
                    type: 1,
                    offset:'t',
                    skin: 'layui-layer-rim', //加上边框
                    area: ['500px', '680px'], //宽高
                    content: $("#motaikunag")
                });
            }else if(obj.event==='del'){
                //确定取消询问框
                layer.confirm('真的删除行么', function(index){
                    obj.del();
                    layer.close(index);
                });
            }

        });
    form.on("submit(formDemo)",function (data) {
        //获取图片
        var img=$("#imgDiv").children("span").children("img");
        var formData= new FormData($("#formData")[0]);
        $(img).each(function (i,val) {
            var imgData= processData($(val).attr("src"));
            formData.append("albumNameFile",imgData);
        })
        $.post({
            url:"${pageContext.request.contextPath}/secReportingData/getAddsecReportingData",
            data:formData,
            processData: false,
            contentType: false,
            success:function (data) {
                if(data){
                    layer.closeAll()
                    layer.msg("上报成功");
                    location.reload()
                }else {
                    layer.msg("上报失败");
                }
            }
        })
    })

    })
    function fileimg(file) {
        var files=file.files;
        var fileArr=Array.from(files);
        $(fileArr).each(function (i,val) {
            //获取文件后缀名
            var ext=val.name.substring(val.name.lastIndexOf(".")+1).toLowerCase()
            //判断图片格式
            if(ext!="png" && ext!="jpeg" && ext!="jpg" ){
                if(ext!=""){
                    alert("图片格式必须是png 或者 jpg 或者 jpeg格式")
                }
                return
            }
            var reader=new FileReader();
            reader.readAsDataURL(val)
            reader.onload=function () {
                $("#imgDiv").append("<span>\n" +
                    "<img  src="+this.result+"  style=\"width: 100px\"/>\n" +
                    "<button type=\"button\"  style=\"vertical-align: top;\" onclick=\"delImge(this)\"><i class=\"layui-icon layui-icon-close\"></i></button>\n" +
                    "</span>")
            }
        })
    }
    //删除图片
    function delImge(obj) {
        $(obj).parent().html("");
    }
    /* 使用二进制方式处理dataUrl */
    function processData(dataUrl) {
        var binaryString = window.atob(dataUrl.split(',')[1]);
        var arrayBuffer = new ArrayBuffer(binaryString.length);
        var intArray = new Uint8Array(arrayBuffer);
        for (var i = 0, j = binaryString.length; i < j; i++) {
            intArray[i] = binaryString.charCodeAt(i);
        }
        var data = [intArray],
            blob;
        try {
            blob = new Blob(data);
        } catch (e) {
            window.BlobBuilder = window.BlobBuilder ||
                window.WebKitBlobBuilder ||
                window.MozBlobBuilder ||
                window.MSBlobBuilder;
            if (e.name === 'TypeError' && window.BlobBuilder) {
                var builder = new BlobBuilder();
                builder.append(arrayBuffer);
                blob = builder.getBlob(imgType); // imgType为上传文件类型，即 file.type
            } else {
                console.log('版本过低，不支持上传图片');
            }
        }
        return blob;
    }
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">上报实际数据</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
</html>
