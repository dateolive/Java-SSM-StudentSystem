<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>修改密码</title>
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
<form class="layui-form layui-row changePwd" lay-filter="formTest">
	<div class="layui-col-xs12 layui-col-sm6 layui-col-md6">
		<div class="layui-input-block layui-red pwdTips">新密码必须两次输入一致才能提交</div>

		<div class="layui-form-item">
			<label class="layui-form-label">旧密码</label>
			<div class="layui-input-block">
				<input type="password" name="password" value="" placeholder="请输入旧密码" lay-verify="required|oldPwd" class="layui-input pwd">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">新密码</label>
			<div class="layui-input-block">
				<input type="password" value="" name="newpassword" placeholder="请输入新密码" lay-verify="required|newPwd" id="oldPwd" class="layui-input pwd">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">确认密码</label>
			<div class="layui-input-block">
				<input type="password" value="" name="newpassword" placeholder="请确认密码" lay-verify="required|confirmPwd" class="layui-input pwd">
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
<!-- 				<button class="layui-btn" lay-submit="" lay-filter="changePwd">立即修改</button> -->
<!-- 				<button type="reset" class="layui-btn layui-btn-primary">重置</button> -->
					<a class="layui-btn layui-btn-sm" lay-filter="addNews" lay-submit><i class="layui-icon">&#xe609;</i>提交</a>
				 <button type="reset" class="layui-btn layui-btn-primary layui-btn-sm">重置</button>
			</div>
		</div>
	</div>
</form>
<script type="text/javascript" src="/layui/layui.js"></script>
<!-- <script type="text/javascript" src="user.js"></script> -->
<script type="text/javascript">
layui.use(['form','layer','laydate','table','laytpl'],function(){
    var form = layui.form,
        layer = parent.layer === undefined ? layui.layer : top.layer,
        $ = layui.jquery,
        laydate = layui.laydate,
        laytpl = layui.laytpl,
        table = layui.table;

    //添加验证规则
    form.verify({
        newPwd : function(value, item){
            if(value.length < 6){
                return "密码长度不能小于6位";
            }
        },
        confirmPwd : function(value, item){
            if(!new RegExp($("#oldPwd").val()).test(value)){
                return "两次输入密码不一致，请重新输入！";
            }
        }
    })
    
    
    form.on("submit(addNews)",function(data){

	        var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});


	        	$.ajax({
					type: "post",
					url: "/SystemServlet/EditPasswod",
					//data: $("#editForm").serialize(), 
					data:form.val("formTest"),
					success: function(msg){
					if(msg == "success"){
						  top.layer.msg("密码修改成功！");	
						} else{
							 top.layer.msg(msg);		
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