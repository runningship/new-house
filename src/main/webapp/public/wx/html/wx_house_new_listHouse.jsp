<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.youwei.newhouse.ThreadSessionHelper"%>
<%@page import="org.bc.sdak.TransactionalServiceHelper"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
String uid="";
for(Cookie coo : request.getCookies()){
	if("new_hosue_user_id".equals(coo.getName())){
		uid = coo.getValue();
		break;
	}
}
if(StringUtils.isEmpty(uid)){
	out.write("<script type=\"text/javascript\">window.location='wx_house_new_login.html';</script>");
	return;
}
Integer userId = 0;
try{
	userId = Integer.valueOf(uid);	
}catch(Exception ex){
	userId=4820;
}
CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
StringBuilder hql = new StringBuilder("select  order.id as id, est.name as estateName, order.buyerName as buyerName ,order.buyerTel as buyerTel, "
		+ " order.sellerName as sellerName ,order.buyerGender as buyerGender ,order.sellerTel as sellerTel, order.addtime as addtime, order.status as status ,order.daikan as daikan from HouseOrder order, "
		+ "Estate est where order.estateId=est.id and est.managerUid=?");
List<Map> list = dao.listAsMap(hql.toString(), userId);
request.setAttribute("userId", userId);
request.setAttribute("list", list);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="maximum-scale=1.0,minimum-scale=1.0,user-scalable=0,width=device-width,initial-scale=1.0"/>
<title>中介宝</title>
<meta name="description" content="">
<meta name="keywords" content="">
<link href="../css/weui.min.css" rel="stylesheet">
<link href="../css/style.css" rel="stylesheet"/>
<script src="../js/jquery.min.js" type="text/javascript"></script>
<script src="../js/layer/layer.js" type="text/javascript"></script>
<script src="../js/jquery-wechat.js" type="text/javascript"></script>
<script src="../../../js/buildHtml.js?12" type="text/javascript"></script>
<script type="text/javascript" src="../../../js/artDialog/jquery.artDialog.source.js?skin=default"></script>
<script type="text/javascript" src="../../../js/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript">
$(document).on('click', '.btn_act', function(event) {
    var T=$(this),
    TT=T.data('type');
    if(TT=='ThiAct'){
    	 var old_status = T.find('.status').text();
        var orderId=T.data('id'),
        ht='<div class="radiobox">';
        ht=ht+getStatusItem(0,old_status, "确认中");
        ht=ht+getStatusItem(1,old_status, "有效");
        ht=ht+getStatusItem(2,old_status, "洽谈中");
        ht=ht+getStatusItem(3,old_status, "已认筹");
        ht=ht+getStatusItem(4,old_status, "已签约");
        ht=ht+getStatusItem(5,old_status, "已结佣");
        ht=ht+getStatusItem(6,old_status, "无效");
//         ht=ht+'<span><input id="radio_1" text="有效" class="radio" type="radio" name="types" value="1" ><label  for="radio_1"class="radio"><span class="radio_1">有效</span></label></span>';
//         ht=ht+'<span><input id="radio_2" text="洽谈中" class="radio" type="radio" name="types" value="2"><label  for="radio_2"class="radio"><span class="radio_2">洽谈中</span></label></span>';
//         ht=ht+'<span><input id="radio_3" text="已认筹" class="radio" type="radio" name="types" value="3"><label  for="radio_3"class="radio"><span class="radio_3">已认筹</span></label></span>';
//         ht=ht+'<span><input id="radio_4" text="已签约" class="radio" type="radio" name="types" value="4"><label  for="radio_4"class="radio"><span class="radio_4">已签约</span></label></span>';
//         ht=ht+'<span><input id="radio_5" text="已结佣" class="radio" type="radio" name="types" value="5"><label  for="radio_5"class="radio"><span class="radio_5">已结佣</span></label></span>';
        //ht=ht+'<span><input id="radio_6" class="radio" type="radio" name="types" value="6"><label for="radio_6" class="radio"><span class="radio_6">已带看</span></label></span>';
//         ht=ht+'<span><input id="radio_7" text="无效" class="radio" type="radio" name="types" value="7"><label for="radio_7" class="radio"><span class="radio_7">无效</span></label></span>';
        ht=ht+'</div>';
        
        var qqq = layer.alert(ht,{
                btn: ['确定','取消'] //按钮
            }, function(){
                var radioid=$('[name=types]:checked').val();
               
                var status = $('.radio_'+radioid).text();
                if(!radioid){alert('请先选择状态'); return false;}
                YW.ajax({
            	    type: 'post',
            	    url: '/new-house/c/admin/order/setStatus',
            	    data: {uid : ${userId} , status: status , orderId: orderId},
            	    mysuccess: function(json){
            	    	alert('状态修改成功');
            	    	$('#order_'+orderId+' .status').text(status);
            	    	layer.close(qqq)
            	    },
            	    error:function(data){
            	    	  alert('操作失败');
            	      }
            	  });
            }, function(){
        })
    }else{
		alert('ok!'+orderId);
    }
    event.preventDefault();
    /* Act on the event */
});

$(document).on('click', '.alist a', function(event) {
	$('.alist a').removeClass('active');
	$(this).addClass('active');
	
	var status = $(this).text();
	if(status=='所有'){
		$('.weui_cell').show();
	}else{
		$('.weui_cell').hide();
		$('.weui_cell:contains('+status+')').show();	
	}
	event.preventDefault();
    /* Act on the event */
});
function getStatusItem(index,oldStatus,status){
	var str = "";
	if(oldStatus==status){
		str="checked";
	}else{
		str="";
	}
	return '<span><input id="radio_'+index+'" '+str+' class="radio" type="radio" name="types" value="'+index+'" ><label  for="radio_'+index+'"class="radio"><span class="radio_'+index+'">'+status+'</span></label></span>'
}
</script>
<style type="text/css">
.BR{ border-top: 1px solid #FF6100; }
</style>
</head>
<body  class="bodyer listHouse ">
    <div id="mainer" class="mainer Jbox">
        <div class="JLeft">
            <div class="alist">
                <a class="a">所有</a>
                <a class="a active">确认中</a>
                <a class="a">有效</a>
                <a class="a">洽谈中</a>
                <a class="a">已认筹</a>
                <a class="a">已签约</a>
                <a class="a BR">已结佣</a>
<!--                 <a class="a">已带看</a> -->
                <a class="a">无效</a>
            </div>
        </div>
        <div class="JRight">
            <div class="weui_cells noMarTop">
            	<c:forEach items="${list }" var="order">
            		<a class="weui_cell btn_act" data-type="ThiAct"  id="order_${order.id}" data-id="${order.id }">
	                    <div class="weui_cell_hd">
	                        <p>${order.buyerName}</p>
	                        <p>${order.sellerName}</p>
	                    </div>
	                    <div class="weui_cell_bd weui_cell_primary">
	                        <p class="gray"><c:out value="${fn:substring(order.buyerTel,0,3)}****${fn:substring(order.buyerTel,7,11)}"></c:out></p>
	                        <p class="gray"><c:out value="${fn:substring(order.sellerTel,0,3)}****${fn:substring(order.sellerTel,7,11)}"></c:out></p>
	                    </div>
	                    <div class="weui_cell_ft">
	                        <p class="orange status">${order.status }</p>
	                        <p class="gray"><fmt:formatDate value="${order.addtime}" pattern="MM-dd"/></p>
	                    </div>
	                </a>
            	</c:forEach>
            </div>
        </div>
    </div>
    <div id="footer" class="footer">
    </div>
</body>
</html>