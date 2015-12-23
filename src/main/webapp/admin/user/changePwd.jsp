<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../header.jsp" />
	<script type="text/javascript">
		$(function(){
			
		});
		
		function save(){
		    var a=$('form[name=form1]').serialize();
            var b = $('#newPwd').val();
            var c = $('#replyPwd').val();
            if (b!=c) {
                alert('两次输入的密码不一致，请重新输入');
                return;
            };
		    YW.ajax({
		        type: 'POST',
		        url: '${projectName}/c/admin/user/modifyPwd',
		        data:a,
		        mysuccess: function(data){
		            alert('修改成功');
		        }
		    });
		}
		
</script>
</head>
<body>
<form name="form1" method="post" class="definewidth m20">
<table class="table table-bordered table-hover m10">
    <tr>
        <td class="tableleft">原密码</td>
        <td><input type="password" name="oldPwd"/></td>
    </tr>
    <tr>
        <td class="tableleft">新密码</td>
        <td><input type="password" id="newPwd" name="newPwd"/></td>
    </tr>
    <tr>
        <td class="tableleft">重复新密码</td>
        <td><input type="password" id="replyPwd" name="replyPwd"/></td>
    </tr>
    <tr>
        <td class="tableleft"></td>
        <td>
            <button class="btn btn-primary" type="button" onclick="save();return false;">保存</button>
        </td>
    </tr>
</table>
</form>
</body>
</html>