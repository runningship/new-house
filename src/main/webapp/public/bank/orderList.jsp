<%@page import="com.youwei.newhouse.entity.User"%>
<%@page import="com.youwei.newhouse.ThreadSessionHelper"%>
<%@page import="com.youwei.newhouse.banking.entity.LoanOrder"%>
<%@page import="java.util.Map"%>
<%@page import="org.bc.sdak.utils.JSONHelper"%>
<%@page import="com.youwei.newhouse.Constants"%>
<%@page import="com.youwei.newhouse.entity.HouseImage"%>
<%@page import="java.util.List"%>
<%@page import="com.youwei.newhouse.entity.Estate"%>
<%@page import="org.bc.sdak.TransactionalServiceHelper"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@page import="com.youwei.newhouse.cache.ConfigCache"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	String sellerTel = request.getParameter("selletTel");
	List<LoanOrder> orderList = dao.listByParams(LoanOrder.class, "from LoanOrder where sellerTel=?", sellerTel);
	request.setAttribute("orderList", orderList);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>推荐记录</title>
<link rel="stylesheet" type="text/css" href="../css.css" />
<link rel="stylesheet" type="text/css" href="../style.css" />
<link href="../animate.min.css" rel="stylesheet" />
<link href="../../style/house.css" rel="stylesheet" />
<script type="text/javascript" src="../../js/jquery.js"></script>
<link href="../../js/owl-carousel/owl.carousel.css" rel="stylesheet" />
<script src="../../js/owl-carousel/owl.carousel.min.js" type="text/javascript"></script>
<script src="../../js/carousel.min.js" type="text/javascript"></script>
<script src="../../js/buildHtml.js" type="text/javascript"></script>
<script type="text/javascript">
$(document).ready(function() {
});

</script>
<style type="text/css">
.bodyer .sider{width:100%;}
.siderC{top:0;}
</style>
</head>

<body class="newhousev2">
<div class="bodyer">
   <div class="sider">
    <div class="siderC">
      <div class="wrap">
      	<c:if test="${empty orderList }">
      		<div id="emptyMsg" style="text-align:center;">您还没有推荐过任何客户</div>
      	</c:if>
      	
        <ul class="khlist">
        	<c:forEach items="${orderList }" var="order">
        		<li class="repeat" data-id="$[id]">
	          		<a href="#" class="box">
			            <div class="fr"><i class="iconfont">&#xe672;</i></div>
			            <strong class="xm">${order.area }</strong>
			            <span class="zt">
			            	<c:if test="${order.status==1 }">待确认</c:if>
			            	<c:if test="${order.status==2 }">已接收</c:if>
			            	<c:if test="${order.status==3 }">已拒绝</c:if>
			            	<b><fmt:formatDate value="${order.addtime }" pattern="yyyy-MM-dd HH:mm"/></b>
			            </span>
			            <span class="hn">面积: ${order.mji }平方  总价: ${order.zjia } 万 贷款: ${order.loan } 万</span>
	          		</a>
	          </li>
        	</c:forEach>
        </ul>
      </div>
    </div>
  </div>
  
</div>
</body>
</html>