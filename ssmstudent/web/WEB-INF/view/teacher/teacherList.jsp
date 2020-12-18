<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>教师列表</title>
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
		<c:if test="${userType == 1}">
	
		<form class="layui-form">
			<div class="layui-inline">
				<div class="layui-input-inline">
					<input type="text" class="layui-input searchValname" placeholder="请输入搜索的老师姓名" />
				</div>
				<div class="layui-input-inline">
				<select id="userid" name="userid" lay-filter="userid"></select>  
				
<!-- 				<input type="text" class="layui-input searchValclazz" placeholder="请输入搜索的班级" />			
 --><!-- 					<input id="clazzList" type="text" class="layui-input searchValclazz" placeholder="请输入搜索的班级" />
 -->			</div>
				<a class="layui-btn search_btn" data-type="reload">搜索</a>
			</div>
			<div class="layui-inline">
				<a class="layui-btn layui-btn-normal addNews_btn">添加老师</a>
			</div>
			<div class="layui-inline">
				<a class="layui-btn layui-btn-danger layui-btn-normal delAll_btn">删除</a>
			</div>
		</form>
		</c:if>
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
	
	<c:if test="${userType == 1}">
		<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</a>
	</c:if>
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
			url: "/ClazzServlet/getClazzList?t="+new Date().getTime(),
			dataType:"json",
			success:function(data){
	            //console.log(data);
	            datas=data.data;//注意此处
	           //console.log(datas);
	            //alert(datas.length);
	            if(datas.length>0){
	                $("#userid").empty();//清空下拉框
	                $("#userid").append("<option value=''>--请选择--</option>");
	                for(var i=0;i<datas.length;i++){
	                    var item=datas[i];
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
       
	    //新闻列表
	    var tableIns = table.render({
	        elem: '#teacherList',
	        method: "post",
	        url : '/TeacherServlet/TeacherList?t='+new Date().getTime(),
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
	            /* {field: 'id', title: 'ID', width:60, align:"center"},
	            {field: 'name', title: '班级名称', width:350},
	            {field: 'info', title: '班级介绍', width:350}, */
	            
	            {field:'id',title:'ID',width:50, lign:"center",sortable: true},    
 		        {field:'sn',title:'工号',width:200, sortable: true},    
 		        {field:'name',title:'姓名',width:200},
 		        {field:'sex',title:'性别',width:100},
 		        {field:'tposition',title:'职位',width:150},
 		        {field:'salary',title:'工资',width:150},
 		        {field:'clazz_id',title:'班级',width:150
 		        	,templet: function(d){
 		        		
 		        		var ans='not found';
 		        		$.ajax({
 		       			type: "get",
 		       			url: "/ClazzServlet/getClazzList?t="+new Date().getTime(),
 		       			dataType:"json",
 		       			async : false,//设置为同步
 		       			success:function(data){
 		       	            //console.log(data);
 		       	           // console.log("hello");
 		       	           var datas=data.data;
 		       	          // console.log(datas);
 		       	            //alert(datas.length);
 		       	            if(datas.length>0){
 		       	               
 		       	                for(var i=0;i<datas.length;i++){
 		       	                    var item=datas[i];
 		       	                    if(d.clazz_id==datas[i].id){
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
	            {title: '操作', width:170, templet:'#studentListBar',fixed:"right",align:"center"}
				
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
	                	name: $(".searchValname").val() , //搜索的关键字
	                	userid:$("#userid").val()
	                }
	            })
	        }else{
	            layer.msg("请输入搜索的内容");
	            table.reload("teacherListTable",{ //再重新刷新表
	            	page: {
	                    curr: 1 //重新从第 1 页开始
	                },
	                where:{
	                	name:null,
	                	userid:null
	                }
	            })
	        }
	    });

	     //编辑用户
	    function editNews(edit){
	        var index = layui.layer.open({
	            title : "编辑老师",
	            type : 2,
	            content : "/SystemServlet/toTeacherEdit",
	            success : function(layero, index){
	                var body = layui.layer.getChildFrame('body', index);
	                if(edit){
	                	body.find(".newsID").val(edit.id);
	                    body.find(".newsName").val(edit.name);
	                   // body.find("#sex").val(edit.sex);
	                    body.find(".edit_tposition").val(edit.tposition);
	                    body.find(".edit_salary").val(edit.salary);
	                    //body.find("#userid").val(edit.clazzId);
	                    form.render();
	                }
	                setTimeout(function(){
	                    layui.layer.tips('点击此处返回教师列表', '.layui-layer-setwin .layui-layer-close', {
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
	    $(".addNews_btn").click(function(){
	        addNews();
	    }) 
	    
	    //添加用户
	    function addNews(edit){
	        var index = layui.layer.open({
	            title : "添加老师",
	            type : 2,
	            content : "/SystemServlet/toTeacherAdd",
	            success : function(layero, index){
	                var body = layui.layer.getChildFrame('body', index);
	                if(edit){
	                    body.find(".newsName").val(edit.name);
	                    body.find(".abstract").val(edit.info);
	                    form.render();
	                }
	                setTimeout(function(){
	                    layui.layer.tips('点击此处返回教师列表', '.layui-layer-setwin .layui-layer-close', {
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
	            layer.confirm('确定删除选中的教师？', {icon: 3, title: '提示信息'}, function (index) {
	                // $.get("删除文章接口",{
	                //     newsId : newsId  //将需要删除的newsId作为参数传入
	                // },function(data){
	               /*  tableIns.reload();
	                layer.close(index); */
	                // })
	                $.ajax({
						type: "post",
						url: "/TeacherServlet/DeleteTeacher",
						data: {ids:ids},
						success: function(msg){
							if(msg == "success"){
								tableIns.reload();
			                    layer.close(index);
			                    top.layer.msg("教师删除成功！");	
							} else{
								 top.layer.msg("教师删除失败！");	
								return;
							}
						}
					});
	            })
	        }else{
	            layer.msg("请选择需要删除的教师");
	        }
	    })

	    //列表操作
	    table.on('tool(teacherList)', function(obj){
	        var layEvent = obj.event,
	            data = obj.data,
	            ids = [];
				ids.push(data.id);
	        if(layEvent === 'edit'){ //编辑
	        	editNews(data);
	        } else if(layEvent === 'del'){ //删除
	            layer.confirm('确定删除此教师?',{icon:3, title:'提示信息'},function(index){
	                // $.get("删除文章接口",{
	                //     newsId : data.newsId  //将需要删除的newsId作为参数传入
	                // },function(data){
	                   /*  tableIns.reload();
	                    layer.close(index); */
	                // })
	                
	                    $.ajax({
							type: "post",
							url: "/TeacherServlet/DeleteTeacher",
							data: {ids:ids},
							success: function(msg){
								if(msg == "success"){
									tableIns.reload();
									top.layer.msg("教师删除成功！");	
				                    layer.close(index);
								} else{
									 top.layer.msg("教师删除失败！");	
									return;
								}
							}
						});
	            });
	        } 
	    });

	});
 

	

 </script>
 
 
 </body>
</html>