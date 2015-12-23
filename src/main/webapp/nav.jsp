<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="warp nav">

     <ul class="main">
          
          <li><a href="index.jsp"  <c:if test="${currNav == 'index'}">class="sel"</c:if> >首页</a></li>
          <li><a href="sale.jsp" <c:if test="${currNav == 'sale'}">class="sel"</c:if>>限时特惠</a></li>
          <li><a href="houses.jsp" <c:if test="${currNav == 'houses'}">class="sel"</c:if>>所有楼盘</a></li>
          <li><a href="houseMap.jsp" <c:if test="${currNav == 'map'}">class="sel"</c:if>>地图找房</a></li>
     
     </ul>

</div>

