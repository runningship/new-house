<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript" src="${projectName}/js/validate.js"></script>
<jsp:include page="header.jsp" />
<script type="text/javascript">
  
function login(){
  if(checkNotnullInput()==false){
      return;
  }
  var a=$('form[name=form1]').serialize();
    YW.ajax({
      type: 'POST',
      url: 'c/admin/user/login',
      data:a,
      dataType:'json',
      mysuccess: function(data){
          // $('#saveBtn').removeAttr('disabled');
          //art.dialog.close();
          // art.dialog.opener.doSearchAndSelectFirst();
          alert('登陆成功');
          window.location = 'sellerIndex.jsp';
      },
      error:function(data){
    	  var json = JSON.parse(data.responseText);
    	  alert(json.msg);
    	  $('#yzm').click();
      }
  });
}


</script>
</head>


<body>

<jsp:include page="top.jsp" />

<div class="warp loginMain">
<form name="form1" role="form" onsubmit="login();return false">
      
      <div class="main">
      
           <div class="fl loginLeft"><img src="images/tu.png" /></div>
           
           <div class="fr form-login">
           
                <p><label for="name">用户名</label><span class="form-tips">用户名不存在</span></p>
               <input type="text" placeholder="请输入手机号" class="name" name="tel" not-null="true">
               
              <p><label for="captcha">密码</label><span class="form-tips">请输入密码</span></p>
               <input type="password" placeholder="请输入密码" class="password" name="pwd" not-null="true">
               
               <p><label for="captcha">请输入图片验证码</label><span class="form-tips">请输入密码</span></p>
              <div class="form-field">
               <input type="text" placeholder="请输入图片验证码" class="captcha" name="yzm">
          			<img id="yzm" alt="图片验证码" src="c/yzm" onclick="this.src='c/yzm?t='+(+new Date)" style="cursor: pointer;width:100px;">
               </div>
               <input type="submit" class="btn-login" value="登录"  style="cursor:pointer"/>
           
           </div>
      
      </div>
</form>
</div>

<jsp:include page="foot.jsp"></jsp:include>

</body>
</html>
