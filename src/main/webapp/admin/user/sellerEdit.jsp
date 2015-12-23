<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="../header.jsp" />
<script type="text/javascript" src="../../js/city/jquery.cityselect.js"></script>
<script type="text/javascript" src="http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js"></script>
<script type="text/javascript">
var hid
function save(){
  var a=$('form[name=form1]').serialize();
    YW.ajax({
      type: 'POST',
      url: '${projectName}/c/admin/user/updateSeller',
      data:a,
      mysuccess: function(data){
        alert('保存成功');
      }
  });
}

function startEditPwd(){
	$('#password').removeAttr('disabled','');
	$('#modifyPwd').val('1');
	return false;
}
$(function(){
    //var province_reg = remote_ip_info['province'];
    //var city_reg = remote_ip_info['city']
    //var district_reg = remote_ip_info['district'];
    $("#city_reg").citySelect({
      prov: '${seller.province}', 
        city: '${seller.city}',
        dist: '${seller.quyu}'
    });
  hid = getParam('hid');
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
<input type="hidden" name="id" value="${seller.id}"/>
<input type="hidden"  id="modifyPwd" name="modifyPwd" value="0"/>
<div class="dialog-custom dialog-book">
      <div class="form-field">
        <label>手机号</label>
        <input type="text" placeholder="请输入手机号" name="tel" value="${seller.tel}" class="int int-num">
        <div name="tip" class="tips"><i class="icon-error"></i><span></span></div>
      </div>
      <div class="form-field">
        <label>姓&#12288;名</label>
        <input type="text" placeholder="请输入真实姓名" name="name" value="${seller.name}" autocomplete="off" class="int int-num">
        <div name="tip" class="tips"><i class="icon-error"></i><span></span></div>
      </div>
      <div class="form-field">
        <label>密&#12288;码</label>
        <input id="password" type="password" placeholder="" name="pwd"  disabled="disabled" value="${seller.pwd}" autocomplete="off" class="int int-num"><a href="#" onclick="startEditPwd();">修改</a>
        <div name="tip" class="tips"><i class="icon-error"></i><span></span></div>
      </div>
	     <div class="form-field" >
            <span style="font-size:14px; width:50px;margin-right:43px;">区&#12288;域 </span>
            	<div id="city_reg"  style="display:inline-block;">
			       <select class="prov"  id="province_reg"  name="province"></select> 
			       <select class="city" name="city"></select>
			       <select class="dist"  name="quyu"></select>
		       </div>
	     </div>
      <div class="form-field">
        <label>所属公司</label>
        <input type="text" placeholder="请输入公司名称" name="compName" value="${seller.compName}" autocomplete="off" class="int int-num">
        <div name="tip" class="tips"><i class="icon-error"></i><span></span></div>
      </div>
      <div class="form-field">
        <label>所属门店</label>
        <input type="text" placeholder="请输入分店名称" name="deptName" value="${seller.deptName}"autocomplete="off" class="int int-num">
        <div name="tip" class="tips"><i class="icon-error"></i><span></span></div>
      </div>
      <div class="form-field">
        <label>经纪服务人员</label>
        <select  name="adminId" >
          <option name="adminName" value="">请选择</option>
	        <c:forEach items="${admins}" var="admin">
	          <option <c:if test="${admin.account==seller.adminName}"> selected="selected" </c:if> value="${admin.id}"> ${admin.account}</option>
	        </c:forEach>
        </select>
      </div>
      <div class="btn-wrap" style="margin-top:20px;">
        <button data-house-id="10" data-url="/fang/house/ajax-subscribe-house-see?houseId=3796" onclick="save();" class="btn-active" name="confirm" type="button">保存</button>
      </div>
    </div>
</form>

</body>
</html>
