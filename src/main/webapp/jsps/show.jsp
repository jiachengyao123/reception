<%--
  Created by IntelliJ IDEA.
  User: jia
  Date: 2019-08-28
  Time: 21:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<style>
    *{
        margin: 0px;
    }
</style>
<%-- layui --%>
<link rel="stylesheet" href="<%= request.getContextPath()%>/static/layui-v2.5.4/layui/css/layui.css"/>
<script src="<%= request.getContextPath()%>/static/js/jquery-3.2.1.min.js"></script>
<script src="<%= request.getContextPath()%>/static/js/echarts.min.js"></script>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<body class="layui-layout-body">
    <input type="hidden" id="userRessid" value="${user.ressid}">
    <input type="hidden" id="userid" value="${user.id}">
   <input type="hidden" id="userLevel" value="${user.userLevel}">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">太平洋保险</div>
        <!-- 头部区域（可配合layui已有的水平导航） -->

        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;">
                    <img src="http://t.cn/RCzsdCq" class="layui-nav-img">
                    ${user.userName}
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="">基本资料</a></dd>
                    <dd><a href="">安全设置</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item"><a href="javascript:Cancellation()">退了</a></li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <div title="菜单缩放" class="kit-side-fold"><i class="fa fa-navicon" aria-hidden="true"></i></div>
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree"  lay-filter="test">

                <li class="layui-nav-item layui-nav-itemed">
                    <a class="" href=""><i class="layui-icon layui-icon-form fa fa-user-circle-o fa-lg" style="color: #69ffd3;font-size: 15px"></i><span>&nbsp;&nbsp;查看数据</span></a>

                </li>
                <c:if test="${user.userLevel==1}">
                <li class="layui-nav-item">
                    <a href="javascript:void(0);" onclick="management(this,'zTree.jsp')"><i class="fa fa-vcard fa-lg layui-icon layui-icon-set-sm" style="color: #22ffa9;font-size: 17px"></i><span id="jigou">&nbsp;&nbsp;机构管理</span></a>
                </li>
                </c:if>
                <c:if test="${user.userLevel==1 || user.userLevel==2}">
                <li class="layui-nav-item">
                    <a href="javascript:;" onclick="management(this,'userManagement.jsp')"><i class="fa fa-vcard fa-lg layui-icon layui-icon-user" style="color: #00FF00"></i><span>&nbsp;&nbsp;用户管理</span></a>

                </li>
                </c:if>
                <c:if test="${user.userLevel==2 || user.userLevel==3}">
                <li class="layui-nav-item">
                    <a href="javascript:;" onclick="management(this,'forecastData.jsp')"><i class="fa fa-vcard fa-lg layui-icon layui-icon-tabs" style="color: #00FF00"></i><span>&nbsp;&nbsp;预报数据</span></a>

                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;" onclick="management(this,'actualData.jsp')"><i class="fa fa-vcard fa-lg layui-icon layui-icon-tabs" style="color: #00FF00"></i><span>&nbsp;&nbsp;上报数据</span></a>

                </li>
                </c:if>
            </ul>
        </div>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="padding: 15px;" class="" >
            <div class="layui-collapse lay-accordion" style="height: 640px">
                <div class="layui-colla-item">
                    <h2 class="layui-colla-title" id="h2">查看数据</h2>
                    <div class="layui-colla-content layui-show" style="height: 100%">
                        <form class="layui-form" action="">
                            <div class="layui-form-item">
                                <label class="layui-form-label">开始时间:</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="title" id="startDate" required  lay-verify="required" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
                                </div>
                                <label class="layui-form-label">结束时间:</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="title" id="endDate" required  lay-verify="required" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
                                </div>
                                <button type="button" class="layui-btn layui-btn-radius" lay-submit lay-filter="formDemo">查询</button>
                            </div>
                        </form>
                        <div class="layui-tab layui-tab-card">
                            <ul class="layui-tab-title">
                                <li class="layui-this">统计图</li>
                                <li>列表详情信息</li>
                            </ul>
                            <div class="layui-tab-content" style="height: 80%;">
                                <div class="layui-tab-item layui-show layui-row">
                                    <!-- 2 设置echarts基板 -->
                                    <div id="hengPie" style="height: 20%;width: 400px;" >
                                    </div>
                                    <!-- 2 设置echarts基板 -->
                                    <div id="pie" style="height: 80%;width: 320px;" class="layui-col-md6">

                                    </div>
                                    <!-- 2 设置echarts基板 -->
                                    <div id="line" style="height: 80%;width: 800px;" class="layui-col-md6"></div>
                                </div>
                                <div class="layui-tab-item">
                                    <table id="dataTable" lay-filter="test"></table>
                                </div>
                            </div>
                        </div>

                </div>
            </div>
        </div>
    </div>

    <div class="layui-footer layui-text" style="text-align: center">
        <!-- 底部固定区域 -->
        <em> © 数据云 - 贾成遥</em>
    </div>
    </div>
</div>
</body>
<script src="<%= request.getContextPath()%>/static/layui-v2.5.4/layui/layui.js" charset="utf-8" ></script>
<script type="text/javascript">
    layui.use(["form","jquery","element","tree","layer","laydate","table"],function () {
        var element=layui.element;
        var $=layui.jquery;
        var form=layui.form;
        var layer=layui.layer;
        var laydate=layui.laydate;
        var table=layui.table;
        //初始化时间
        laydate.render({
            elem:"#startDate",
            trigger: 'click'
        })
        laydate.render({
            elem:"#endDate",
            trigger: 'click'
        })
        $("#userLevel").val()==""?location.href="${pageContext.request.contextPath}/jsps/login.jsp":"";

        form.on("submit(formDemo)",function (data) {
            layer.msg("aa")
            return false;
        })
        //第一个实例
        table.render({
            elem: '#dataTable'
            ,method:"post"
            ,height: 312
            ,where:{id:$("#userid").val(),ressid:$("#userRessid").val(),userLevel:$("#userLevel").val()}
            ,cellMinWidth: 100 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
            ,url: '${pageContext.request.contextPath}/secReportingData/getsecReportingDataTable' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {field: 'id', title: 'ID', width:120, sort: true, fixed: 'left'}
                ,{field: 'planName', title: '计划名称', width:100,templet:function (e) {
                        return e.planName;
                    }}
                ,{field: 'planNumberTables', title: '计划桌数', width:100, sort: true}
                ,{field: 'actualTableCount', title: '实际桌数', width:120, sort: true}
                ,{field: '', title: '执行率(%)', width:120, sort: true,templet:function (e) {
                        return e.actualTableCount/e.planNumberTables*100+"%";
                    }}
                ,{field: 'newCustomers', title: '新客户', width:120, sort: true}
                ,{field: 'oldCustomers', title: '旧客户', width:120, sort: true}
                ,{field: 'intentionalCustomers', title: '意向客户', width:120, sort: true}
                ,{field: 'premium', title: '预估保费(万)', width:120, sort: true}
                ,{field: 'name', title: '所属区域', width:120, }
            ]]
        });
    })
    <%--         注销          --%>
    function Cancellation(){
        $.post({
            url:"${pageContext.request.contextPath}/secUser/getCancellation",
            success:function (data) {
                console.log(data)
                data==true?location.href="${pageContext.request.contextPath}/jsps/login.jsp":alert("退出失败")
            }
        })
    }
    <%--         左树管理         --%>
    function management(obj,jsp) {
        // $("#h2").text($(obj).children("span").text())
      //  $("#iframe").attr("src","${pageContext.request.contextPath}/jsps/zTree.jsp");
        layui.use("layer",function () {
            var layer=layui.layer;
            layer.closeAll()
            //iframe窗
            layer.open({
                type: 2,
                title: false,
                closeBtn: 0, //不显示关闭按钮
                shade: [0],
                area: ['340px', '215px'],
                offset: 'rb', //右下角弹出
                time: 1000, //1秒后自动关闭
                anim: 2,
                content: ['${pageContext.request.contextPath}/jsps/'+jsp, 'no'], //iframe的url，no代表不显示滚动条
                end: function(){ //此处用于演示
                    layer.open({
                        type: 2,
                        title: $(obj).children("span").text(),
                        shadeClose: true,
                        shade: false,
                        maxmin: true, //开启最大化最小化按钮
                        area: ['1000px', '680px'],
                        content: '${pageContext.request.contextPath}/jsps/'+jsp
                    });
                }
            });
        })
    }
    var ressNameArr=[];
    var countArr=[];
    $.post({
        url:"${pageContext.request.contextPath}/secAddress/getsecAddressName",
        data:{id:$("#userRessid").val()},
        success:function (data) {
            var ArrNameVal=[]
            ressNameArr.push(data.name)
            ArrNameVal.push({value:100,name:data.name,level:data.level,id:data.id})
            // 3 初始化echarts
            var myChartPie = echarts.init(document.getElementById('hengPie'));
            options= {
                tooltip : {
                    trigger: 'item',
                    formatter: "{a} <br/>{b}",
                },
                legend : {
                    orient:"vertical",
                    left:"left",
                    data:ressNameArr
                },
                series : [{
                    name:'区域',
                    type: 'pie',
                    radius : '100%',
                    avoidLabelOverlap: false,
                    center: ['50%', '50%'],
                    label: {
                        normal: {
                            show: false,
                            position: 'center'
                        },emphasis:{
                            show: true,
                            textStyle: {
                                fontSize: '30',
                                fontWeight: 'bold'
                            }
                        }
                    },
                    labelLine: {
                        normal: {
                            show: false
                        }
                    },
                    data:ArrNameVal,
                }]
            };

    $.post({
        url:"${pageContext.request.contextPath}/secReportingData/getsecReportingDataTableEchartsline",
        data:{ressid:$("#userRessid").val(),userLevel:$("#userLevel").val()},
        success:function (data) {
            var count=0;
            $(data).each(function (i,val) {
                count+=val.premium;
            })
            countArr.push(count)
            myChart(ressNameArr,countArr)
        }
    })

            // 5 将配置项和数据加载到echarts中
            myChartPie.setOption(options);
            myChartPie.on("click",function (param) {
                $.post({
                    url:"${pageContext.request.contextPath}/secReportingData/getsecReportingDataTableEchartsline",
                    data:{ressid:param.data.id,userLevel:param.data.level},
                    success:function (data) {
                        var ressNameArr=[];
                        var countArr=[];
                        var count=0;
                        $(data).each(function (i,val) {
                            count+=val.premium;
                        })
                        ressNameArr.push(param.name)
                        countArr.push(count)
                        myChart(ressNameArr,countArr)
                    }
                })
            })
        }

    })
    myChart(ressNameArr,countArr)
    function myChart(ressNameArr,countArr) {
        // 3 初始化echarts
        var myChart = echarts.init(document.getElementById('line'));

        // 4 指定图表的配置项和数据
        var option = {
            //标题
            title: {
                //主标题
                text: '河北省各市预估保费统计图',
                //主标题链接
                //link : 'https://www.baidu.com',
                //当前页面打开链接
                //target : 'self',
                //副标题
                subtext : '河北省太平洋保险',
                //居中
                left : 'center'
            },
            //x轴
            xAxis: {
                //坐标轴类型, x轴默认值为:category(类目轴), y轴默认值:value(数值轴); 还有:'time'(时间轴),'log' (对数轴)
                type : 'category',
                //轴姓名
                name : '预估保费(万)',
                //坐标值 类目
                data : ressNameArr,
                //x轴文字倾斜
                axisLabel: {
                    interval:0,
                    rotate:20
                }
            },
            //y轴
            yAxis : {},
            //提示框组件
            tooltip : {

                //触发类型   默认:item (多用于饼图,散点图) ,'axis'(多用于柱状图,折现图)
                trigger: 'axis',
                formatter: "{a} <br/>{b}({c}万)"

            },
            //图例
            legend : {
                //关联 series 中的name
                data : ['预估保费'],
                //位置 居左 ('right','conter')
                left : "left"

            },
            //系列参数
            series : [{

                //类型为 折线图 ('bar':柱状图;'pie':饼图)
                type : 'bar',
                //数据
                data : countArr,
                //系列名称，用于tooltip的显示，legend 的图例筛选
                name : '预估保费',
                //折线图显示数据
                label: {
                    normal: {
                        show: true,
                        position: 'top'
                    }
                },

            },],
            // {
            //     //类型为 折线图 ('bar':柱状图;'pie':饼图)
            //     type : 'line',
            //     //数据
            //     data : [10,21,15,17,14,30],
            //     //系列名称，用于tooltip的显示，legend 的图例筛选
            //     name : '毛利'
            //
            // }
            //工具框
            toolbox: {
                //是否显示
                //show: true,
                //工具框朝向  默认为:horizontal(横项)   'vertical'(纵向)
                orient: 'vertical',
                feature: {
                    //数据视图 : 是否不可编辑
                    dataView: {readOnly: true},
                    //动态类型切换               	折线            柱状
                    magicType: {type: ['bar']},
                    // 还原, 刷新   show默认true
                    restore: {show:true},
                    //保存图片  show默认true
                    saveAsImage: {}
                }
            }

        }

        // 5 将配置项和数据加载到echarts中
        myChart.setOption(option);
        // myChart.on("click",function (param) {
        //     console.log(param)
        // })
    }


   $.post({
       url:"${pageContext.request.contextPath}/secAddress/getSecAddressByid",
       data:{id:$("#userRessid").val(),level:$("#userLevel").val()},
       success:function (data) {
           if(data){
           var ArrName =[];
           var ArrNameVal =[];
            $(data).each(function (i,val) {
                ArrName.push(val.name)
                ArrNameVal.push({value:val.id,name:val.name,level:val.level})
            })
           // 3 初始化echarts
           var myChartPie = echarts.init(document.getElementById('pie'));
               pie(myChartPie,ArrName,ArrNameVal)
       }
    }
   })

    function pie(myChartPie,ArrName,ArrNameVal) {
        options= {
            title : {
                text: '河北省区域展示',
                subtext: '河北省太平洋保险',
                x:'center'
            },
            tooltip : {
                trigger: 'item',
                formatter: "{a} <br/>{b}",
            },
            legend : {
                orient:"vertical",
                left:"left",
                data:ArrName
            },
            xAxis : {
                name:"区域",
                data:ArrName,
                //x轴文字倾斜
                axisLabel: {
                    interval:0,
                    rotate:20
                }
            },
            yAxis : {
                type: 'value'
            },
            series : [{
                name:'区域',
                type: 'pie',
                radius : '55%',
                center: ['50%', '50%'],
                label: {
                    normal: {
                        show: true,
                        position: 'top'
                    }
                },
                data:ArrNameVal,
            }]
        };
        // 5 将配置项和数据加载到echarts中
        myChartPie.setOption(options);
        myChartPie.on("click",function (param) {
            $.post({
                url:"${pageContext.request.contextPath}/secReportingData/getsecReportingDataTableEchartsline",
                data:{ressid:param.value,userLevel:param.data.level},
                success:function (data) {
                    var ressNameArr=[];
                    var countArr=[];
                    var count=0;
                    $(data).each(function (i,val) {
                        count+=val.premium;
                    })
                    ressNameArr.push(param.name)
                    countArr.push(count)
                    myChart(ressNameArr,countArr)
                }
            })
        })
    }

</script>
</html>
