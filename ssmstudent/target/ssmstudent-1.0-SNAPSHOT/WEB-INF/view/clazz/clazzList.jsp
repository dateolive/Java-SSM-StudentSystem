<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>班级列表</title>
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
<form class="layui-form">
	<blockquote class="layui-elem-quote quoteBox">
		<c:if test="${userType == 1 }">
	
		<form class="layui-form">
			<div class="layui-inline">
				<div class="layui-input-inline">
					<input type="text" class="layui-input searchVal" placeholder="请输入搜索的内容" />
				</div>
				<a class="layui-btn search_btn" data-type="reload">搜索</a>
			</div>
			<div class="layui-inline">
				<a class="layui-btn layui-btn-normal addNews_btn">添加班级</a>
			</div>
			<div class="layui-inline">
				<a class="layui-btn layui-btn-danger layui-btn-normal delAll_btn">删除</a>
			</div>
		</form>
		</c:if>
	</blockquote>
	<table id="newsList" lay-filter="newsList"></table>
	
	
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
	<script type="text/html" id="newsListBar">
			<c:if test="${userType == 1 }">
		<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
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

	    //班级列表
	    var tableIns = table.render({
	        elem: '#newsList',
	        method: "post",
	        url : '/ClazzServlet/getClazzList?t='+new Date().getTime(),
	        cellMinWidth : 95,
	        page : true,
	        height : "full-125",
	        limit : 10,
	        limits : [10,15,20,25],
	        id : "newsListTable",
	        toolbar:true,
	        totalrow:true,
	        cols : [ [
	        	
	            {type: "checkbox", fixed:"left", width:50},
	            {field: 'id', title: 'ID', width:60, align:"center"},
	            {field: 'name', title: '班级名称', width:350},
	            {field: 'info', title: '班级介绍', width:350},
	            {title: '操作', width:170, templet:'#newsListBar',fixed:"right",align:"center"}
	        ] ]
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
	        if($(".searchVal").val() != ''){
	            table.reload("newsListTable",{
	                page: {
	                    curr: 1 //重新从第 1 页开始
	                },
	                where: {
	                	clazzName: $(".searchVal").val()  //搜索的关键字
	                }
	            })
	        }else{
	            layer.msg("请输入搜索的内容");
	            table.reload("newsListTable",{
	                page: {
	                    curr: 1 //重新从第 1 页开始
	                },
	                where: {
	                	clazzName: null  //搜索的关键字
	                }
	            })
	        }
	    });

	     //编辑用户
	    function editNews(edit){
	        var index = layui.layer.open({
	            title : "编辑用户",
	            type : 2,
	            content : "/SystemServlet/toClazzEdit",
	            success : function(layero, index){
	                var body = layui.layer.getChildFrame('body', index);
	                if(edit){
	                	body.find(".newsID").val(edit.id);
	                    body.find(".newsName").val(edit.name);
	                    body.find(".abstract").val(edit.info); 
	                    form.render();
	                }
	                setTimeout(function(){
	                    layui.layer.tips('点击此处返回班级列表', '.layui-layer-setwin .layui-layer-close', {
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
	            title : "添加用户",
	            type : 2,
	            content : "/SystemServlet/toClazzAdd",
	            success : function(layero, index){
	                var body = layui.layer.getChildFrame('body', index);
	                if(edit){
	                    body.find(".newsName").val(edit.name);
	                    body.find(".abstract").val(edit.info);
	                    form.render();
	                }
	                setTimeout(function(){
	                    layui.layer.tips('点击此处返回班级列表', '.layui-layer-setwin .layui-layer-close', {
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
	        var checkStatus = table.checkStatus('newsListTable'),
	            data = checkStatus.data,
	            newsId = [];
	        if(data.length > 0) {
	            for (var i in data) {
	                newsId.push(data[i].id);
	            }
	            layer.confirm('确定删除选中的班级？', {icon: 3, title: '提示信息'}, function (index) {
	                // $.get("删除文章接口",{
	                //     newsId : newsId  //将需要删除的newsId作为参数传入
	                // },function(data){
	               /*  tableIns.reload();
	                layer.close(index); */
	                // })
	                $.ajax({
						type: "post",
						url: "/ClazzServlet/DeleteAllClazz",
						data: {newsId:newsId},
						success: function(msg){
							if(msg == "success"){
								tableIns.reload();
			                    layer.close(index);
							} else{
								 top.layer.msg("用户删除失败！");	
								return;
							}
						}
					});
	            })
	        }else{
	            layer.msg("请选择需要删除的班级");
	        }
	    })

	    //列表操作
	    table.on('tool(newsList)', function(obj){
	        var layEvent = obj.event,
	            data = obj.data;

	        if(layEvent === 'edit'){ //编辑
	        	editNews(data);
	        } else if(layEvent === 'del'){ //删除
	            layer.confirm('确定删除此班级？',{icon:3, title:'提示信息'},function(index){
	                // $.get("删除文章接口",{
	                //     newsId : data.newsId  //将需要删除的newsId作为参数传入
	                // },function(data){
	                   /*  tableIns.reload();
	                    layer.close(index); */
	                // })
	                
	                    $.ajax({
							type: "post",
							url: "/ClazzServlet/DeleteClazz",
							data: {clazzid: data.id},
							success: function(msg){
								if(msg == "success"){
									tableIns.reload();
									top.layer.msg("班级删除成功！");	
				                    layer.close(index);
								} else{
									 top.layer.msg("班级删除失败！");	
									return;
								}
							}
						});
	            });
	        } 
	    });

	})
 </script>
 
 
 </body>
</html>