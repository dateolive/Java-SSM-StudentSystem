<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>教师添加</title>
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
				<div class="layui-form-item magt3">
					<label class="layui-form-label">姓名</label>
					<div class="layui-input-block">
						<input type="text" id="add_name" name="name" class="layui-input add_name" lay-verify="newsName" placeholder="请输入姓名">
					</div>
				</div>
				<div class="layui-form-item magt3">
					<label class="layui-form-label">密码</label>
					<div class="layui-input-block">
						<input type="password" id="add_password" name="password" class="layui-input add_password" lay-verify="add_password" placeholder="请输入密码">
					</div>
				</div>
				<div class="layui-form-item magt3">
					<label class="layui-form-label">性别</label>
					<div class="layui-input-block">
				      <input type="radio" name="sex" value="男" title="男" checked>
				      <input type="radio" name="sex" value="女" title="女" >
				    </div>
					<!-- <div class="layui-input-block">
						<input type="text" id="add_sex" name="sex" class="layui-input add_sex" lay-verify="add_sex" placeholder="请输入文章标题">
					</div> -->
				</div>
				<div class="layui-form-item magt3">
					<label class="layui-form-label">职位</label>
					<div class="layui-input-block">
						<input type="text" id="add_tposition" name="tposition" class="layui-input add_tposition"  placeholder="请输入职位">
					</div>
				</div>
				<div class="layui-form-item magt3">
					<label class="layui-form-label">工资</label>
					<div class="layui-input-block">
						<input type="text" id="add_salary" name="salary" class="layui-input add_salary"  placeholder="请输入工资">
					</div>
				</div>
				<div class="layui-form-item magt3">
					<label class="layui-form-label">班级名称</label>
					<div class="layui-input-block">
				<select id="userid" name="userid" lay-filter="userid"></select>  
					
<!-- 						<input type="text" id="add_clazzid" name="clazzid" class="layui-input add_clazzid" lay-verify="add_clazzid" placeholder="请输入班级名称">
 -->					</div>
				</div>
				<!-- <div class="layui-form-item">
					<label class="layui-form-label">班级介绍</label>
					<div class="layui-input-block">
						<textarea id="edit_info" placeholder="请输入班级介绍"  name="info" class="layui-textarea abstract"></textarea>
					</div>
				</div> -->
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

	    //渲染下拉框
	    $.ajax({
			type: "get",
			url: "/ClazzServlet/getClazzList?t="+new Date().getTime()+"&from=combox",
			dataType:"json",
			success:function(data){
	           // console.log(data);
	            datas=data.data;//注意此处
	          // console.log(datas);
	            //alert(datas.length);
	            if(datas.length>0){
	                $("#userid").empty();//清空下拉框
	                $("#userid").append("<option value=''>--请选择--</option>");
	                for(var i=0;i<datas.length;i++){
	                    var item=datas[i];
	                    //option里面value存放班级id
	                    $("#userid").append("<option value="+item.id+">"+item.name+"</option>");
	                }
	            }else {
	                $("#userid").empty();//清空下拉框
	                $("#userid").append("<option value=''>--请新建规则--</option>");
	            }
	            form.render();//注意渲染页面表单，否则不显示数据
	        },
	        error: function() {
	            layer.msg('获取规则失败');
	            form.render();
	        }
							
		});

	    form.verify({
	        newsName : function(val){
	            if(val == ''){
	                return "姓名不能为空";
	            }
	        }
	    	,add_password : function(val){
	            if(val == ''){
	                return "密码不能为空";
	            }
	        }
	    	/* ,add_clazzid : function(val){
	            if(val == ''){
	                return "班级名称不能为空";
	            }
	        } */
	    	
	    })
	    form.on("submit(addNews)",function(data){
	        //截取文章内容中的一部分文字放入文章摘要
/* 	        var abstract = layedit.getText(editIndex).substring(0,50);
 */	        //弹出loading
	        var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
	        // 实际使用时的提交信息
	        // $.post("上传路径",{
	        //     newsName : $(".newsName").val(),  //文章标题
	        //     abstract : $(".abstract").val(),  //文章摘要
	        //     content : layedit.getContent(editIndex).split('<audio controls="controls" style="display: none;"></audio>')[0],  //文章内容
	        //     newsImg : $(".thumbImg").attr("src"),  //缩略图
	        //     classify : '1',    //文章分类
	        //     newsStatus : $('.newsStatus select').val(),    //发布状态
	        //     newsTime : submitTime,    //发布时间
	        //     newsTop : data.filed.newsTop == "on" ? "checked" : "",    //是否置顶
	        // },function(res){
	        //
	        // })
	        	$.ajax({
					type: "post",
					url: "/TeacherServlet/AddTeacher",
					//data: $("#editForm").serialize(), 
					data:form.val("formTest"),
					success: function(msg){
							if(msg == "success"){
								top.layer.msg("老师添加成功！");
							} else{
							 top.layer.msg("老师添加失败！");		
							 return;
							}
						}
				});
	        setTimeout(function(){
	            top.layer.close(index);
	            
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