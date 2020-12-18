<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>增加选课信息</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link rel="stylesheet" href="/layui/css/layui.css" media="all" />
	<link rel="stylesheet" href="/css/public.css" media="all" />
</head>
<body class="childrenBody">
<form class="layui-form layui-row layui-col-space10" id="editForm" lay-filter="formTest">
<!-- 	<div class="layui-col-md9 layui-col-xs12">
 -->		<!-- <div class="layui-row layui-col-space10"> -->
			<div class="layui-col-md9 layui-col-xs7">
				
				<div class="layui-input-inline">
					<select id="studentid" name="studentid" lay-filter="studentid"></select> 				
				</div>
				
 				<div class="layui-input-inline">
 				<select id="courseid" name="courseid" lay-filter="courseid"></select> 
 				</div>
				
			</div>
		<!-- </div> -->
		<hr class="layui-bg-gray" />
		<div class="layui-form-item magb0">
				<a class="layui-btn layui-btn-sm" lay-filter="addNews" lay-submit><i class="layui-icon">&#xe609;</i>发布</a>
				 <button type="reset" class="layui-btn layui-btn-primary layui-btn-sm">重置</button>
		</div>

<!-- 	</div>
 -->	
</form>
<script type="text/javascript" src="/layui/layui.js"></script>
 <script type="text/javascript">
 layui.use(['form','layer','layedit','laydate','upload'],function(){
	    var form = layui.form
	        layer = parent.layer === undefined ? layui.layer : top.layer,
	        laypage = layui.laypage,
	        upload = layui.upload,
	        layedit = layui.layedit,
	        laydate = layui.laydate,
	        $ = layui.jquery;

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
	    
	    form.on("submit(addNews)",function(data){

	        var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});

	        	$.ajax({
					type: "post",
					url: "/SelectedCourseServlet/AddSelectedCourse",
					//data: $("#editForm").serialize(), 
					data:form.val("formTest"),
					success: function(msg){
							if(msg == "success"){
								top.layer.msg("选课信息添加成功！");
							} 
							else if(msg=="courseFull"){
								 top.layer.msg("该课程已满！");		
								 return;
							}
							else if(msg=="courseSelected"){
								 top.layer.msg("你已选课！");		
								 return;
							}
							else{
							 top.layer.msg("选课失败！");		
							 return;
							}
						}
				});
	        setTimeout(function(){
	            top.layer.close(index);
	            //top.layer.msg("选课信息添加成功！");
	            layer.closeAll("iframe");
	            //刷新父页面
	            parent.location.reload();
	        },500);
	        return false;
	    })

	   

	

	})
 </script>
 </body>
</html>