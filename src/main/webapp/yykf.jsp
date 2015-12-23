<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="header.jsp" />
<script type="text/javascript">
var hid
function save(){
  var a=$('form[name=form1]').serialize();
    YW.ajax({
      type: 'POST',
      url: 'c/admin/order/doSave',
      data:a,
      mysuccess: function(data){
    	window.parent.order_success();
        if (hid=="") {
          LayerRemoveBox2("estate_order");
        }else{
          LayerRemoveBox2("house_order");
        }
        
        //alert('预约提交成功,房金宝稍后与您联系!');
      }
  });
}

function LayerRemoveBox2(id){
  $(window.top.document).contents().find(".maskLayer").remove();
  $(window.top.document).contents().find("#"+id).remove();
}

$(function(){
  hid = getParam('hid');
})

</script>
</head>

<body>
<form name="form1" role="form">
<input type="hidden" name="estateId" value="${estate.id }"/>
<input type="hidden" name="hid" value="${house.id }"/>
<div class="dialog-custom dialog-book">
      <div class="form-title">
        <p class="title-main">预约&nbsp;<span>${estate.name } <c:if test="${house !=null }">${house.dhao }栋 ${house.unit }单元 ${house.fhao }室</c:if></span></p>
        <p class="title-sub">请填写您的姓名和手机号，以便经纪人联系您看房</p>
      </div>
      <div class="form-field" style="border:none">
        <label>手机号</label>
        <input type="text" placeholder="请输入手机号" name="buyerTel" class="int int-num" style="border:1px solid #c3c3c3" />
        <div name="tip" class="tips"><i class="icon-error"></i><span></span></div>
      </div>
      <div class="form-field" style="border:none">
        <label>姓&#12288;名</label>
        <input type="text" placeholder="请输入姓名" name="buyerName" autocomplete="off" class="int int-num" style="border:1px solid #c3c3c3" />
        <div name="tip" class="tips"><i class="icon-error"></i><span></span></div>
      </div>
      <!-- 
      <div class="form-field">
        <label>验证码</label>
        <input type="text" placeholder="请输入图片验证码" name="yzm" class="int int-code"><a class="btn-link">
          <img alt="图片验证码" src="c/yzm" onclick="this.src='c/yzm?t='+(+new Date)" style="width:97px;height:46px;position:static">
        </a>
        <div name="tip" class="tips"><i class="icon-error"></i><span></span></div>
      </div>
       -->
      <div class="btn-wrap">
        <button data-house-id="10" data-url="/fang/house/ajax-subscribe-house-see?houseId=3796" onclick="save();" class="btn-active" name="confirm" type="button">立即预约</button>
      </div>
    </div>
</form>

</body>
</html>
