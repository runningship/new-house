<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="header.jsp" />
<link rel="stylesheet" type="text/css" href="style/user.css" />
<script type="text/javascript" src="${projectName}/js/uploadify/jquery.uploadify.js"></script>
<script type="text/javascript" src="${projectName}/js/fjb.js"></script>
<script type="text/javascript">
$(function(){
    setTimeout(function(){
        initPortrait('ChangePortrait' , ${seller.id});
    },100)
})

</script>
<style type="text/css">
.user_inforight{margin-top:5px;}

.user_inforight div{
margin-top:10px;
}

.user_pic{margin-top: -43px;}
.user_pic img{height:145px;margin-left: 57%;border: 2px solid #c3c3c3;}

</style>
</head>

<body>

<jsp:include page="top.jsp"></jsp:include>
<jsp:include page="nav.jsp"></jsp:include>

<div class="warp">

     <div class="main">
     
          <div class="user">
               <div class="userLeft">
                    
                    <h2>${seller.name }</h2>
                    
                    <div><a href="#" class="sel">个人资料</a></div>
                    <div><a href="estateYongJin.jsp">楼盘佣金</a></div>
                    <div><a href="estateOrder.jsp">楼盘预约</a></div>
               		<div><a href="houseOrder.jsp">房源预约</a></div>
               </div>
               
               <div class="userRight">
               
                    <div class="tit"><a href="#">我的房金宝</a> > <span>个人资料</span></div>
                    
                    <div class="con">
                    	<div><img /></div>
                        <div class="user_inforight">
	                        <div> 姓名：${seller.name }&#12288;</div>
	                        <div>手机号码：${seller.tel }&#12288;&#12288;</div>
	                        <div>所属经纪公司：${seller.compName }</div>
	                        <div>所属门店：${seller.deptName }</div>
                        </div>
                        <div class="user_pic" >
                        	<c:if test="${touxiang ne '' }">
                        		<img src="${upload_path }/${touxiang}" />
                        	</c:if>
                            <c:if test="${touxiang eq '' }">
                        		<img src="${projectName }/images/touxiang0.png" />
                        	</c:if>
                        </div>
                        <div style="float:right;"><input id="ChangePortrait" /></div>
                        <div class="user_moreinfo">
                             
                            <h2>账户安全</h2>
			
			
                            <div class="table" style="margin-left:10px;">
                                <table width="600">
                                    <tbody><tr>
                                        <td width="20%"><img src="images/user_icon1.png"> 认证手机</td>
                                        <td width="65%"><span style="color:#4682da">${seller.tel }</span></td>
                                        <td width="15%"></td>
                                    </tr>
                                    <tr>
                                        <td width="20%"><img src="images/user_icon4.png"> 更改密码</td>
                                        <td width="65%">修改密码之后要牢记密码,不要把密码给陌生人看</td>
                                        <td width="15%"><a type="button" onclick="openNewWin('modify_pwd','修改密码' ,'xgmm.jsp');" title="" href="javascript:">更改密码</a></td>
                                    </tr>
                                </tbody></table>
                                
                             </div>
                             
                        
                        </div>
                        
                    </div>
                    
               
               </div>
               
          </div>
          
     </div>

</div>

<jsp:include page="foot.jsp" />
</body>
</html>
