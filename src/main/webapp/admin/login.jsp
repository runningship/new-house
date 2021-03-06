<%@page import="org.bc.sdak.utils.LogUtil"%>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
// 	Enumeration<String> names=request.getHeaderNames();
// 	String agent = request.getHeader("User-Agent");
// 	System.out.println(agent);
// 	if(!agent.contains("MicroMessenger")){
// 		out.write("请在微信中打开");
// 		return;
// 	}
String host = request.getServerName();
if("bank.zhongjiebao.com".equals(host)){
	response.sendRedirect("/new-house/admin/bank/login.html");
}
%>
<!DOCTYPE html>
<html>
	<head>
	<link type="image/x-icon" rel="icon" href="../images/zjb.png">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="maximum-scale=1.0,minimum-scale=1.0,user-scalable=0,width=device-width,initial-scale=1.0"/>
		<title>中介宝新房通管理平台</title>
		<link type="text/css" href="assets/css/login.css" rel="stylesheet" />	
		<script type="text/javascript" src="assets/js/jquery-1.8.1.min.js"></script>
	    <script type="text/javascript" src="../js/bootstrap.js"></script>
	    <script type="text/javascript" src="../js/artDialog/jquery.artDialog.source.js?skin=default"></script>
		<script type="text/javascript" src="../js/artDialog/plugins/iframeTools.source.js"></script>
		<script type="text/javascript" src="../js/json2.js"></script>
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
	function setErr(txt){
		var EB=$('.errTip');
		EB.text(txt);
		var ET=setTimeout(function(){
			EB.text('');
			clearTimeout(ET);
		},3000);
	}
	$(document).on('keyup',function(event){
		if(event.keyCode==13){
			var A=$('.tel'),
			AV=A.val(),
			B=$('.pwd'),
			BV=B.val();
			if(!AV){
				A.focus();
			}else if(!BV){
				B.focus();
			}else{
				login();
			}
		}
	});
	$('.tel').focus();
});
</script>
<style type="text/css">
	.foot{padding-top: 50px;color:#666; font-size:15px;}
	.errTip{ font-size: 14px; color: #F00; height: 20px; line-height: 20px; text-align: center; display: block; }
</style>
	</head>
	<body>
	<div class="container">
		<div class="top">
			<a href="#" class="logos"><i class="iconfont">&#xe687;</i><strong>新房通管理平台</strong></a>
		</div>
		<div class="bottom">
			<form class="form1" name="form1">
				<label class="inputbox">
					<input type="text" class="input tel" name="account" value="" placeholder="手机号">
				</label>
				<label class="inputbox">
					<input type="password" class="input pwd" name="pwd" value="" placeholder="密码">
				</label>
				<label class="btnbox">
					<a href="" class="button" onclick="login();">登录</a>
				</label> 
			</form>
			<p class="errTip"></p>
		</div>
		 <div class="foot">
			<span class="me">中介宝专属服务热线：0551-65639055   QQ:912958833</span>
		</div>
	</div>
	   
	</body>
</html>