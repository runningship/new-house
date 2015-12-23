<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="style/css.css" />
<script type="text/javascript">
$(function(){
  
});

function save(){
    var a=$('form[name=form1]').serialize();
        var b = $('#newPwd').val();
        var c = $('#replyPwd').val();
        if (b!=c) {
            alert('两次输入的密码不一致，请重新输入');
            window.location.reload();
            return;
        };
    YW.ajax({
        type: 'POST',
        url: '${projectName}/c/admin/user/modifyPwd',
        data:a,
        mysuccess: function(data){
            alert('修改成功');
            window.location.reload();
        }
    });
}
    
</script>
</head>

<body>

<div class="dialog-custom dialog-book" style=" margin-top:55px;">
      <div class="form-title">
      </div>
      <div class="form-field">
        <label>旧密码</label>
        <input type="password" placeholder="请输入旧密码" name="oldPwd" class="int int-num">
        <div name="tip" class="tips"><i class="icon-error"></i><span></span></div>
      </div>
      <div class="form-field">
        <label>新密码</label>
        <input type="password" placeholder="请输入新密码" name="newPwd" id="newPwd" autocomplete="off" class="int int-num">
        <div name="tip" class="tips"><i class="icon-error"></i><span></span></div>
      </div>
      <div class="form-field">
        <label>重复新密码</label>
        <input type="password" placeholder="重复新密码" name="replyPwd" id="replyPwd" class="int num">
        <div name="tip" class="tips"><i class="icon-error"></i><span></span></div>
      </div>
      
      <div class="btn-wrap">
        <button class="btn-active" name="confirm" type="button" onclick="save();return false;">确认修改</button>
      </div>
    </div>

</body>
</html>
