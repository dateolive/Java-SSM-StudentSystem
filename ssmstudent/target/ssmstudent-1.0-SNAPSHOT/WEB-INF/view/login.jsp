<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%--<#assign base=request.contextPath/>--%>
<html>
<head>
<%--        <base id="base" href="${base}">--%>
    <meta charset="UTF-8">
    <title>登录</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/login/css/normalize.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/login/css/demo.css" />
    <!--必要样式-->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/login/css/component.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layui/css/layui.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/layui/layui.js"></script>
</head>
<body>
<div class="container demo-1">
    <div class="content">
        <div id="large-header" class="large-header">
            <canvas id="demo-canvas"></canvas>
            <div class="logo_box">
                <h3>欢迎你</h3>
                <form id="form" class="layui-form " name="f" method="post">
                    <div class="input_outer">
                        <span class="u_user"></span>
                        <input id="" name="account" class="text" style="color: #FFFFFF !important" type="text" placeholder="请输入账户">
                    </div>
                    <div class="input_outer">
                        <span class="us_uer"></span>
                        <input id="" name="password" class="text" style="color: #FFFFFF !important; position:absolute; z-index:100;"value="" type="password" placeholder="请输入密码">
                    </div>

                    <div class="layui-row">
                        <div class="layui-col-xs6">
                            <div class="input_outer">
                                <input class="text" name="vcode" type="text" placeholder="请输入验证码" style="width: 200px;color:white;">
                            </div>
                        </div>
                        <div class="layui-col-xs6">
                            <div class="grid-demo">
                                <img title="点击图片切换验证码" id="vcodeImg" src="${pageContext.request.contextPath}/checkCode">
                            </div>
                        </div>
                    </div>

                    <div class="layui-row layui-col-space5">

                        <div class="layui-col-md4">
                            <input type="radio" id="radio-2" name="type" title="学生"  value="2" />
                        </div>
                        <div class="layui-col-md4">
                            <input type="radio" id="radio-3" name="type" title="老师"  value="3" />
                        </div>
                        <div class="layui-col-md4">
                            <input type="radio" id="radio-1" name="type" title="管理员" checked value="1" />
                        </div>

                    </div>


                    <div class="layui-form-item">
                        <div class="layui-input-block">
                            <input id="submitBtn" type="button" class="layui-btn" value="&nbsp;登&nbsp;&nbsp;&nbsp;&nbsp;录&nbsp;">
                        </div>
                    </div>
                </form>
                <div class="footer">Copyright@ datealive </div>

            </div>
        </div>
    </div>

</div><!-- /container -->

<script src="${pageContext.request.contextPath}/login/js/TweenLite.min.js"></script>
<script src="${pageContext.request.contextPath}/login/js/EasePack.min.js"></script>
<script src="${pageContext.request.contextPath}/login/js/rAF.js"></script>
<script src="${pageContext.request.contextPath}/login/js/demo-1.js"></script>
</body>
<script>
    //加载弹出层组件
    layui.use(['layer','form','jquery'],function(){
        var $ = layui.jquery;
        var layer = layui.layer;
        var form=layui.form;
//         $(function(){
        //点击图片切换验证码
        $("#vcodeImg").click(function(){
            this.src="${pageContext.request.contextPath}/checkCode?a="+new Date().getTime();
        });

        //登录
        $("#submitBtn").click(function(){
            //alert("hello");
            var data = $("#form").serialize();
            $.ajax({
                type: "post",
                url: "${pageContext.request.contextPath}/checkLogin",
                data: data,
                dataType: "text", //返回数据类型
                success: function(msg){
                    if("vcodeError" == msg){
                        //$.messager.alert("消息提醒", "验证码错误!", "warning");
                        top.layer.msg("验证码错误!");
                        $("#vcodeImg").click();//切换验证码
                        $("input[name='vcode']").val("");//清空验证码输入框
                    } else if("loginError" == msg){
                        //$.messager.alert("消息提醒", "用户名或密码错误!", "warning");
                        top.layer.msg("用户名或密码错误!!");
                        $("#vcodeImg").click();//切换验证码
                        $("input[name='vcode']").val("");//清空验证码输入框
                    } else if("loginSuccess" == msg){
                        window.location.href = "${pageContext.request.contextPath}/SystemServlet/toAdminView";
                    } else{
                        alert(msg);
                    }
                }

            });
        });

        //设置复选框
        $(".skin-minimal input").iCheck({
            radioClass: 'iradio-blue',
            increaseArea: '25%'
        });

    })
</script>
</html>