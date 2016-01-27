<%@page import="com.youwei.newhouse.user.Role"%>
<%@page import="com.youwei.newhouse.ThreadSessionHelper"%>
<%@page import="com.youwei.newhouse.entity.OrderGenJin"%>
<%@page import="com.youwei.newhouse.Constants"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.youwei.newhouse.entity.Estate"%>
<%@page import="com.youwei.newhouse.entity.User"%>
<%@page import="org.bc.sdak.TransactionalServiceHelper"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@page import="com.youwei.newhouse.entity.HouseOrder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
Integer id = Integer.valueOf(request.getParameter("id"));
HouseOrder po = dao.get(HouseOrder.class, id);
Estate estate = dao.get(Estate.class, po.estateId);
request.setAttribute("order", po);
User me = ThreadSessionHelper.getUser();
if(Role.销售主管.name().equals(me.role)){
	if(Constants.HouseOrderConfirming.equals(po.status) || Constants.HouseOrderInValid.equals(po.status)){
		request.setAttribute("hideTel", true);
	}else{
		request.setAttribute("hideTel", false);
	}	
}else{
	request.setAttribute("hideTel", false);
}
request.setAttribute("estate", estate);
List<String> statusList = new ArrayList<String>();
if(Constants.HouseOrderConfirming.equals(po.status)){
	statusList.add(Constants.HouseOrderValid);
	statusList.add(Constants.HouseOrderInValid);	
}else if(Constants.HouseOrderValid.equals(po.status)){
	statusList.add(Constants.HouseOrderBiz);
}else if(Constants.HouseOrderBiz.equals(po.status)){
	statusList.add(Constants.HouseOrderRenChou);
}else if(Constants.HouseOrderRenChou.equals(po.status)){
	statusList.add(Constants.HouseOrderDeal);
}else if(Constants.HouseOrderDeal.equals(po.status)){
	statusList.add(Constants.HouseOrderJieYong);
}
request.setAttribute("statusList",statusList);

List<OrderGenJin> genjiList = dao.listByParams(OrderGenJin.class, "from OrderGenJin where orderId=?", id);
request.setAttribute("genjiList", genjiList);
%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../header.jsp" />
<script type="text/javascript">

function save(){
	if($('#status').val()=='已结佣'){
		if($('#yongjin').val()==''){
			alert('请输入佣金金额');
			return;
		}
	}
    var a=$('form[name=form1]').serialize();
    YW.ajax({
        type: 'POST',
        url: '${projectName}/c/admin/order/update',
        data:a,
        mysuccess: function(data){
            alert('修改成功');
            window.location.reload();
        }
    });
}

function statusChanged(status){
	if("已结佣"==status){
		$('#yongjinTR').show();
	}else{
		$('#yongjinTR').hide();
	}
}
</script>
</head>
<body>
<form name="form1" method="post" class="definewidth m20">
	<input type="hidden" name="id"  value="${order.id}"/>
<table class="table table-bordered table-hover m10">
	
    <tr>
        <td class="tableleft">楼盘</td>
        <td>${estate.name}</td>
    </tr>
    <tr>
        <td class="tableleft">经纪人姓名</td>
        <td><span>${order.sellerName}</span>
        </td>
    </tr>
     <tr>
        <td class="tableleft">经纪人电话</td>
        <c:if test="${hideTel }">
        	<td><span><c:out value="${fn:substring(order.sellerTel,0,3)}****${fn:substring(order.sellerTel,7,11)}"></c:out></span></td>
        </c:if>
        <c:if test="${!hideTel }">
        	<td><span>${order.sellerTel }</span></td>
        </c:if>
    </tr>
    <tr>
        <td class="tableleft">客户姓名</td>
        <td><span>${order.buyerName}</span>
        </td>
    </tr>
    <tr>
        <td class="tableleft">客户电话</td>
        <c:if test="${hideTel }">
        	<td><span><c:out value="${fn:substring(order.buyerTel,0,3)}****${fn:substring(order.buyerTel,7,11)}"></c:out></span></td>
        </c:if>
        <c:if test="${!hideTel }">
        	<td><span>${order.buyerTel }</span></td>
        </c:if>
    </tr>
    <tr>
        <td class="tableleft">状态</td>
        <td>
        	<c:if test="${statusList.size()>0 }">
            <select <c:if test="${order.status eq '已结佣' }">readonly="readonly"</c:if> id="status"  class="sortSelect" name="status" onchange="statusChanged(this.value);">
                <c:forEach items="${statusList}" var="status">
                  <option <c:if test="${status eq order.status }">selected="selected"</c:if> value="${status}">${status}</option>
                </c:forEach>
            </select>
            </c:if>
            <c:if test="${statusList.size()<=0 }">
            	<select readonly="readonly" name="status"><option selected="selected" value="${order.status }">${order.status }</option></select>
            	
            </c:if>
        </td>
    </tr>
    <tr id="yongjinTR" <c:if test="${order.status ne '已签约' && order.status ne '已结佣'}"> style="display:none;"</c:if>>
        <td class="tableleft">佣金</td>
        <td><input type="text"  <c:if test="${order.status eq '已结佣' }">readonly="readonly"</c:if> desc="佣金"  id="yongjin" name="yongjin" value="${order.yongjin }"/></td>
    </tr>
    <tr>
        <td class="tableleft">是否带看</td>
        <td>
        	<input <c:if test="${order.daikan==1 }">checked="checked"</c:if> type="radio" name="daikan" value="1"/> 已带看
        	<input <c:if test="${order.daikan!=1 }">checked="checked"</c:if> type="radio" name="daikan" value="0"/>未带看
        </td>
    </tr>
    <tr>
        <td class="tableleft">备注</td>
        <td><input type="text"  name="sellerMark" value="${ order.sellerMark}"/></td>
    </tr>
    <tr>
        <td class="tableleft"></td>
        <td>
            <button class="btn btn-primary" type="button" onclick="save();return false;">保存</button>
        </td>
    </tr>
    <tr>
        <td class="tableleft">跟进信息</td>
        <td>
	        <div  style=" width:100%; margin:10px 0; overflow-y:auto; color:#666666; font-family:'宋体';">
			<c:forEach items="${genjiList}" var="genjin">
			    <p style=" margin-bottom:5px;">${genjin.uname} 将状态修改为 ${genjin.status }</p><span style="color:#ccc"><fmt:formatDate value="${genjin.addtime}" pattern="yyyy-MM-dd HH-mm"/></span>
			</c:forEach>
			</div>
		</td>
    </tr>
</table>

</form>
</body>
</html>