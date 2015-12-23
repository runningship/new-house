<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../header.jsp" />
	<script type="text/javascript">
		function cfgChild(radio){
			if(radio.value==1){
				$('#tr_conts').css('display','none');
			}else{
				$('#tr_conts').css('display','');
			}
		}
		
		$(function(){
			
		});
		
		function save(){
		    var a=$('form[name=form1]').serialize();
		    YW.ajax({
		        type: 'POST',
		        url: '${projectName}/c/admin/user/doSave',
		        data:a,
		        mysuccess: function(data){
		            alert('添加成功');
		        }
		    });
		}
		
</script>
</head>
<body>
<form name="form1" method="post" class="definewidth m20">
<input type="hidden" name="type" value="seller"/>
<table class="table table-bordered table-hover m10">
	
    <tr>
        <td class="tableleft">姓名</td>
        <td><input type="text" name="dhao"/></td>
    </tr>
    <tr>
        <td class="tableleft">电话</td>
        <td><input type="text" name="unit"/></td>
    </tr>
    <tr>
        <td class="tableleft">密码</td>
        <td><input type="password" name="fhao"/></td>
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