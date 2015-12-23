<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="style/css.css" />
<link rel="stylesheet" type="text/css" href="style/user.css" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/artDialog/jquery.artDialog.source.js?skin=default"></script>
<script type="text/javascript" src="js/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="js/buildHtml.js"></script>
<script type="text/javascript">
function save(){
    var a=$('form[name=form1]').serialize();
    $.ajax({
        type: 'POST',
        url: '${projectName}/c/admin/order/fankui',
        data:a,
        success: function(data){
            alert('提交成功');
            setTimeout(function(){ window.location.reload();} , 1500);
        }
    });
}
</script>
</head>

<body>

<div class="dialog-custom dialog-book">
      <div class="form-title">
        <p class="title-main">预约信息查看</span></p>
      </div>
      
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="fkTable">
<form class="form-inline definewidth m20" name="form1"  method="get" onsubmit="return false;">
<input type="hidden" name="orderId" value="${order.id}"/>
  <tr>
    <td height="25" width="60" bgcolor="#eeeeee" class="t">客户姓名:</td>
    <td>${order.buyerName}</td>
    <td width="60" bgcolor="#eeeeee" class="t">联系电话:</td>
    <td>${order.buyerTel}</td>
  </tr>
  <tr>
    <td height="25" width="60" bgcolor="#eeeeee" class="t">预约楼盘:</td>
    <td>${estate.name} <c:if test="${house.dhao!=null && house.fhao!=null}">${house.dhao}#${house.fhao}</c:if></td>
    <td width="60" bgcolor="#eeeeee" class="t">预约时间:</td>
    <td><fmt:formatDate value="${order.addtime}" pattern="yyyy-MM-dd HH:mm"/></td>
  </tr>
  <tr>
    <td width="60" bgcolor="#eeeeee" class="t">状态:</td>
    <td>${order.status}</td>
  </tr>
<!--   <tr> -->
<!--     <td height="25" width="60" bgcolor="#eeeeee" class="t" valign="top"><span style="display:block; list-style:25px; margin-top:3px;">备注:</span></td> -->
<%--     <td colspan="3"><textarea style="width:300px; height:50px; border:1px solid #CCC; margin-top:5px;" name="sellerMark">${order.sellerMark }</textarea></td> --%>
<!--   </tr> -->
  <tr>
    <td height="25" width="60" bgcolor="#eeeeee" class="t" valign="top"><span style="display:block; list-style:25px; margin-top:3px;">添加跟进:</span></td>
    <td colspan="3"><textarea style="width:300px; height:50px; border:1px solid #CCC; margin-top:5px;" name="conts"></textarea></td>
  </tr>
  <tr>
    <td colspan="4">
    <div  style=" width:100%; margin:10px 0; max-height:145px; overflow:hidden; overflow-y:auto; color:#666666; font-family:'宋体';">
    <c:forEach items="${genjiList}" var="genjin">
        <p style=" margin-bottom:5px;"><em style="color:#999999;">${genjin.addtime} :</em>${genjin.conts}</p>
    </c:forEach>
    </div>
    </td>
  </tr>
  </form>
</table>



      
      
      <div class="btn-wrap">
        <button class="btn-active" name="confirm" type="button" onclick="save();return false">提交反馈</button>
      </div>
    </div>

</body>
</html>
