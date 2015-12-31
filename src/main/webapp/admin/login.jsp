<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
	<link type="image/x-icon" rel="icon" href="../images/fjb.png">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="maximum-scale=1.0,minimum-scale=1.0,user-scalable=0,width=device-width,initial-scale=1.0"/>
		<title>Wide Admin - Login</title>
		<link type="text/css" href="assets/css/login.css" rel="stylesheet" />	
		<script type="text/javascript" src="assets/js/jquery-1.8.1.min.js"></script>
	    <script type="text/javascript" src="../js/bootstrap.js"></script>
	    <script type="text/javascript" src="../js/artDialog/jquery.artDialog.source.js?skin=default"></script>
		<script type="text/javascript" src="../js/artDialog/plugins/iframeTools.source.js"></script>
		<script type="text/javascript" src="../js/buildHtml.js"></script>

<script type="text/javascript">
function login(){
	var a=$('form[name=form1]').serialize();
	YW.ajax({
	    type: 'post',
	    url: '${projectName}/c/admin/user/login?type=admin',
	    data: a,
	    mysuccess: function(json){
	        window.location="index.jsp";
	    },
	    error:function(data){
	    	  alert('用户名或密码错误');
	      }
	  });
}
$(function(){
	$(document).on('keyup',function(event){
		if(event.keyCode==13){
			login();
		}
	});
});
</script>
	</head>
	<body>
	<div class="container">
		<div class="top">
			<a href="#" class="logos"><i class="iconfont">&#xe687;</i><strong>这里是小标题</strong></a>
		</div>
		<div class="bottom">
			<form class="form1" name="form1">
				<label class="inputbox">
					<input type="text" class="input" name="account" value="" placeholder="手机号/邮箱/账号">
				</label>
				<label class="inputbox">
					<input type="password" class="input" name="pwd" value="" placeholder="密码">
				</label>
				<label class="btnbox">
					<botton class="botton" onclick="login();">登录</botton>
				</label> 
			</form>
		</div>
	</div>

	</body>
</html>