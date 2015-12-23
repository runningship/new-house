<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript" src="${projectName}/js/validate.js"></script>
<jsp:include page="header.jsp" />

<style type="text/css">
#city_reg select{height:30px;width:120px;margin-top: 20px;margin-bottom: 10px;}
</style>
</head>


<body>

<jsp:include page="top.jsp"></jsp:include>

<div class="warp loginMain" style="margin-bottom:50px;">
      
      
<form name="form1" role="form" onsubmit="save();return false">
	<input name="type" type="hidden" value="seller"/>
      <div class="main">
      
           <div class="fr loginLeft" style="margin-top:140px;"><img src="images/tu.png" /></div>
           
           <h2 style=" font-size:18px; margin-bottom:8px; color:#444444;">新用户注册</h2>
           <div class="fl form-login">
              
                <p><label for="name">手机号码</label><span class="form-tips">用户名不存在</span></p>
               <input type="text" placeholder="请输入手机号" class="name" name="tel" not-null="true">
               
              <p><label for="captcha">密码</label><span class="form-tips">请输入您的密码</span></p>
               <input type="password" placeholder="请输入您的密码" class="password" name="pwd" not-null="true">

              <p><label for="captcha">姓名</label><span class="form-tips">请输入您的姓名</span></p>
               <input type="text" placeholder="请输入您的姓名" class="name" name="name" not-null="true">
               
               <div id="city_reg" style="display:inline-block;">
<!--                		<span style="font-size:14px; width:50px;pading-right:20px;">区域 </span> -->
			  		<select class="prov"  id="province_reg"  name="province"></select> 
			    	<select class="city" name="city"></select>
			    	<select class="dist"  name="quyu"></select>
		    	</div>
		    
               <p><label for="captcha">公司名称</label><span class="form-tips">请输入您的公司名称</span></p>
               <input type="text" placeholder="公司" class="name" name="compName" not-null="true">
               
               <p><label for="captcha">分店名称</label><span class="form-tips">请输入您的分店名称</span></p>
               <input type="text" placeholder="分店" class="name" name="deptName" not-null="true">
               
               <input type="submit" class="btn-login" value="注册" style="cursor:pointer" />
           
           </div>
      
      </div>
</form>
</div>

<jsp:include page="foot.jsp"></jsp:include>

<script type="text/javascript">
  
function save(){
  if(checkNotnullInput()==false){
      return;
  }
  var a=$('form[name=form1]').serialize();
    YW.ajax({
      type: 'POST',
      url: 'c/admin/user/doRegiste',
      data:a,
      mysuccess: function(data){
          // $('#saveBtn').removeAttr('disabled');
          //art.dialog.close();
          infoAlert('注册成功,工作人员会第一时间与您联系，审核成功后即可登录');
      },
      error:function(data){
    	  var json = JSON.parse(data.responseText);
    	  alert(json.msg);
    	  $('#yzm').click();
      }
  });
}

$(function(){
	var province_reg = remote_ip_info['province'];
	var city_reg = remote_ip_info['city']
	var district_reg = remote_ip_info['district'];
	if(sessionProvince && sessionCity){
		$("#city_reg").citySelect({
			prov : sessionProvince, 
	    	city : sessionCity
		});
	}else{
		$("#city_reg").citySelect({
			prov: province_reg, 
	    	city: city_reg,
	    	dist: district_reg
		});
	}
});
</script>
</body>
</html>
