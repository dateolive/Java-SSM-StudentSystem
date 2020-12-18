<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>选课列表</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link rel="stylesheet" href="/layui/css/layui.css" media="all" />
	<link rel="stylesheet" href="/css/public.css" media="all" />
<!-- 	<script type="text/javascript" src="../../jquery/jquery.min.js"></script>
 -->	
</head>
<body class="childrenBody">
<form class="layui-form">
	<blockquote class="layui-elem-quote quoteBox">
		<form class="layui-form">
			<div class="layui-inline">
				
				<div class="layui-input-inline">
					<select id="studentid" name="studentid" lay-filter="studentid"></select> 				
				</div>
				
 				<div class="layui-input-inline">
 				<select id="courseid" name="courseid" lay-filter="courseid"></select> 
 				</div>
				<a class="layui-btn search_btn" data-type="reload">搜索</a>
			</div>
				<c:if test="${userType == 1 || userType == 2}">
			<div class="layui-inline">
				<a class="layui-btn layui-btn-normal addNews_btn">增选</a>
			</div>
			<div class="layui-inline">
				<a class="layui-btn layui-btn-danger layui-btn-normal delAll_btn">退选</a>
			</div>
			</c:if>
		</form>
	</blockquote>
	<table id="teacherList" lay-filter="teacherList"></table>
	
	
	<!--审核状态-->
	<script type="text/html" id="newsStatus">
		{{#  if(d.newsStatus == "1"){ }}
		<span class="layui-red">等待审核</span>
		{{#  } else if(d.newsStatus == "0"){ }}
		<span class="layui-blue">已存草稿</span>
		{{#  } else { }}
			审核通过
		{{#  }}}
	</script>

	<!--操作-->
	<script type="text/html" id="studentListBar">
		<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
		<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</a>
	</script>
</form>
<script type="text/javascript" src="/layui/layui.js"></script>
<!-- <script type="text/javascript" src="newsList.js"></script>
 -->
 <script type="text/javascript">
 
       
 layui.use(['form','layer','laydate','table','laytpl'],function(){
	    var form = layui.form,
	        layer = parent.layer === undefined ? layui.layer : top.layer,
	        $ = layui.jquery,
	        laydate = layui.laydate,
	        laytpl = layui.laytpl,
	        table = layui.table;
	    
	   
		
       
       $.ajax({
			type: "get",
			url: "/StudentServlet/StudentList?t="+new Date().getTime(),
			dataType:"json",
			success:function(data){
	            //console.log(data);
	            datas=data.data;//注意此处
	           //console.log(datas);
	            //alert(datas.length);
	            if(datas.length>0){
	                $("#studentid").empty();//清空下拉框
	                $("#studentid").append("<option value=''>--选择学生-</option>");
	                for(var i=0;i<datas.length;i++){
	                    var item=datas[i];
	                    $("#studentid").append("<option value="+item.id+">"+item.name+"</option>");
	                }
	            }else {
	                $("#studentid").empty();//清空下拉框
	                $("#studentid").append("<option value=''>--请新建规则--</option>");
	            }
	            form.render();//注意渲染页面表单，否则不显示数据
	        },
	        error: function() {
	            layer.msg('获取规则失败');
	            form.render();
	        }
							
		});
       
       $.ajax({
			type: "get",
			url: "/CourseServlet/CourseList?t="+new Date().getTime(),
			dataType:"json",
			success:function(data){
	            //console.log(data);
	            datas=data.data;//注意此处
	           //console.log(datas);
	            //alert(datas.length);
	            if(datas.length>0){
	                $("#courseid").empty();//清空下拉框
	                $("#courseid").append("<option value=''>--选择课程-</option>");
	                for(var i=0;i<datas.length;i++){
	                    var item=datas[i];
	                    $("#courseid").append("<option value="+item.id+">"+item.name+"</option>");
	                }
	            }else {
	                $("#courseid").empty();//清空下拉框
	                $("#courseid").append("<option value=''>--请新建规则--</option>");
	            }
	            form.render();//注意渲染页面表单，否则不显示数据
	        },
	        error: function() {
	            layer.msg('获取规则失败');
	            form.render();
	        }
							
		});
       
	    //选课信息列表
	    var tableIns = table.render({
	        elem: '#teacherList',
	        method: "post",
	        url : '/SelectedCourseServlet/SelectedCourseList?t='+new Date().getTime(),
	        cellMinWidth : 95,
	        page : true,
	        height : "full-125",
	        limit : 10,
	        limits : [10,15,20,25],
	        id : "teacherListTable",
	        toolbar:true,
	        totalrow:true,
	        cols : [[
	        	
	            {type: "checkbox", fixed:"left", width:50},
	            {field:'id',title:'ID',width:50, lign:"center",sortable: true},    
 		        {field:'student_id',title:'学生',width:150
 		        	,templet: function(d){
 		        		
 		        		var ans='not found';
 		        		$.ajax({
 		       			type: "get",
 		       			url: "/StudentServlet/StudentList?t="+new Date().getTime(),
 		       			dataType:"json",
 		       			async : false,//设置为同步
 		       			success:function(data){
 		       	            //console.log(data);
 		       	            //console.log("hello");
 		       	           var datas=data.data;
 		       	          // console.log(datas);
 		       	            //alert(datas.length);
 		       	            if(datas.length>0){
 		       	               
 		       	                for(var i=0;i<datas.length;i++){
 		       	                    var item=datas[i];
 		       	                    if(d.student_id==datas[i].id){
 		       	                    	ans=datas[i].name;break;
 		       	                    }
 		       	                }
 		       	            }else {
 		       	            }
 		       	        }
 		       							
 		       		});
 		        		return ans;
 		        		
				} 
 		        },     
 		       {field:'course_id',title:'课程',width:150
 		        	,templet: function(d){
 		        		
 		        		var ans='not found';
 		        		$.ajax({
 		       			type: "get",
 		       			url: "/CourseServlet/CourseList?t="+new Date().getTime(),
 		       			dataType:"json",
 		       			async : false,//设置为同步
 		       			success:function(data){
 		       	            //console.log(data);
 		       	            //console.log("hello");
 		       	           var datas=data.data;
 		       	         //  console.log(datas);
 		       	            //alert(datas.length);
 		       	            if(datas.length>0){
 		       	               
 		       	                for(var i=0;i<datas.length;i++){
 		       	                    var item=datas[i];
 		       	                    if(d.course_id==datas[i].id){
 		       	                    	ans=datas[i].name;break;
 		       	                    }
 		       	                }
 		       	            }else {
 		       	            }
 		       	        }
 		       							
 		       		});
 		        		return ans;
 		        		
				} 
 		        },
 				<c:if test="${userType == 1||userType ==3}">
 		       {field:'score_id',title:'分数',width:150,edit: 'text'}
 		       </c:if>
 		      <c:if test="${userType ==2}">
		       {field:'score_id',title:'分数',width:150}
		       </c:if>
 		       /*  ,     
	            {title: '操作', width:170, templet:'#studentListBar',fixed:"right",align:"center"} */
				
	        ]]
	   
	    });
	    
	     
	   /*  //是否置顶
	    form.on('switch(newsTop)', function(data){
	        var index = layer.msg('修改中，请稍候',{icon: 16,time:false,shade:0.8});
	        setTimeout(function(){
	            layer.close(index);
	            if(data.elem.checked){
	                layer.msg("置顶成功！");
	            }else{
	                layer.msg("取消置顶成功！");
	            }
	        },500);
	    }) */

	    //搜索【此功能需要后台配合，所以暂时没有动态效果演示】
	    $(".search_btn").on("click",function(){
	        if($(".searchValname").val() != ''||$("#userid").val()!=''){
	        	
	            table.reload("teacherListTable",{
	                page: {
	                    curr: 1 //重新从第 1 页开始
	                },
	                where: {
	                	studentid: $("#studentid").val() , //搜索的关键字
	                	courseid:$("#courseid").val()
	                }
	            })
	        }else{
	            layer.msg("请输入搜索的内容");
	            table.reload("teacherListTable",{ //再重新刷新表
	            	page: {
	                    curr: 1 //重新从第 1 页开始
	                },
	                where:{
	                	studentid:null,
	                	courseid:null
	                }
	            })
	        }
	    });



	    $(".addNews_btn").click(function(){
	        addNews();
	    })  
	    
	    //增选
	    function addNews(edit){
	        var index = layui.layer.open({
	            title : "添加选课信息",
	            type : 2,
	            content : "/SystemServlet/toSelectAdd",
	            success : function(layero, index){
	                var body = layui.layer.getChildFrame('body', index);
	                if(edit){
	                    body.find(".newsName").val(edit.name);
	                    body.find(".abstract").val(edit.info);
	                    form.render();
	                }
	                setTimeout(function(){
	                    layui.layer.tips('点击此处返回选课列表', '.layui-layer-setwin .layui-layer-close', {
	                        tips: 3
	                    });
	                },500)
	            }
	        })
	        layui.layer.full(index);
	        //改变窗口大小时，重置弹窗的宽高，防止超出可视区域（如F12调出debug的操作）
	        $(window).on("resize",function(){
	            layui.layer.full(index);
	        })
	    }
	   

	    //批量删除
	    $(".delAll_btn").click(function(){
	        var checkStatus = table.checkStatus('teacherListTable'),
	            data = checkStatus.data,
	            ids = [];
	        if(data.length > 0) {
	            for (var i in data) {
	            	ids.push(data[i].id);
	            }
	            layer.confirm('确定删除选中的选课信息？', {icon: 3, title: '提示信息'}, function (index) {
	                // $.get("删除文章接口",{
	                //     newsId : newsId  //将需要删除的newsId作为参数传入
	                // },function(data){
	               /*  tableIns.reload();
	                layer.close(index); */
	                // })
	                $.ajax({
						type: "post",
						url: "/SelectedCourseServlet/DeleteSelectedCourse",
						data: {ids:ids},
						success: function(msg){
							if(msg == "success"){
								tableIns.reload();
			                    layer.close(index);
							}
							else{
								tableIns.reload();
			                    layer.close(index);
								 top.layer.msg("选课信息删除失败！");	
								return;
							}
						}
					});
	            })
	        }else{
	            layer.msg("请选择需要删除的用户");
	        }
	    })
		
	     table.on('edit(teacherList)', function(obj){
			    var value = obj.value //得到修改后的值
			    ,data = obj.data //得到所在行所有键值
			    ,field = obj.field; //得到字段
			    
			    console.log(data);
			    $.ajax({
					type: "post",
					url: "/SelectedCourseServlet/EditSelectedCourse",
					data: data,
					success: function(msg){
						if(msg == "success"){
							tableIns.reload();
		                   // layer.close(index);
		                    top.layer.msg("成绩修改成功！");	
						} else{
							 top.layer.msg("成绩修改失败！");	
							return;
						}
					}
				});
			    
			  });





	});
 

	

 </script>
 
 
 </body>
</html>