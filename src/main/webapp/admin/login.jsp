<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
	<link type="image/x-icon" rel="icon" href="../images/fjb.png">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
	<div id="container">
		<div class="logo">
			<a href="#"><img src="assets/img/logo.png" alt="" /></a>
		</div>
		<div id="box">
			<form name="form1">
			<p class="main">
				<label>账号: </label>
				<input name="account" value="" /> 
				<label>密码: </label>
				<input type="password" name="pwd" value="">	
			</p>

			<p class="space">
				
				<input type="button" value="登陆" onclick="login();" class="login" />
			</p>
			</form>
		</div>
	</div>

	</body>
</html>