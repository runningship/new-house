<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="../header.jsp" />
<script type="text/javascript" src="../../js/city/jquery.cityselect.js"></script>
<script type="text/javascript" src="http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js"></script>
<script type="text/javascript">
function save(){
  var adminId = $('#adminId').val();
  art.dialog.opener.saveJinJ(adminId);
  art.dialog.close();
}

$(function(){
});

</script>
<style type="text/css">
.form-field{height:30px;margin-top:15px;}
.form-field label{float:left;width:90px;}
.form-field select{width:210px;}
#city_reg select{width:68px;margin-top: 10px;}
</style>
</head>

<body>
<form name="form1" role="form">
<input type="hidden" name="sellerIds" id ="ids" />
<div class="dialog-custom dialog-book">
      <div class="form-field">
        <label>经纪服务人员</label>
        <select  name="adminId" id="adminId" style="width:150px;">
          <option name="adminId" value="">请选择</option>
	        <c:forEach items="${admins}" var="admin">
	          <option value="${admin.id}"> ${admin.account}</option>
	        </c:forEach>
        </select>
      </div>
      <div class="btn-wrap" style="margin-top:30px;">
        <button data-house-id="10" data-url="/fang/house/ajax-subscribe-house-see?houseId=3796" onclick="save();" class="btn-active" name="confirm" type="button">保存</button>
      </div>
    </div>
</form>

</body>
</html>
