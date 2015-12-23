<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="page">
<!--   <span><a href="javascript:void(0);">首页</a><a href="javascript:void(0);">上一页</a><a class="current" href="?base_id=5&amp;second_id=5001&amp;page=1">1</a><a href="javascript:void(0);">下一页</a><a href="javascript:void(0);">末页</a></span> -->
	
	<span>
     <c:choose>
       <c:when test="${page.currentPageNo==1}">
         <span class="prev"><b>&lt;</b>上一页</span>
       </c:when>
       <c:otherwise>
         <a title="上一页"  class="btn-s prev"  href="?currentPageNo=${page.currentPageNo-1}"><b>&lt;</b>上一页</a>
       </c:otherwise>
     </c:choose>
     
     <c:forEach var="i"  begin="1"  end="5"  step="1">
       <c:if test="${page.currentPageNo-(6-i)>0}">
         <a pagetag="go" href="?currentPageNo=${page.currentPageNo-(6-i) }">${page.currentPageNo-(6-i) }</a>
       </c:if>
       </c:forEach>
       <span class="current">${page.currentPageNo}</span>
     <c:forEach var="j"  begin="1"  end="5"  step="1">
       <c:if test="${page.currentPageNo+j<=page.totalPageCount}">
         <a pagetag="go"  href="?currentPageNo=${page.currentPageNo+j}">${page.currentPageNo+j }</a>
       </c:if>
       </c:forEach>
       
       <c:choose>
       <c:when test="${page.currentPageNo==page.totalPageCount}">
         <span class="prev">下一页<b>&gt;</b></span>
       </c:when>
       <c:otherwise>
         <a title="下一页" class="btn-s next" href="?currentPageNo=${page.currentPageNo+1}">下一页<b>&gt;</b></a>
       </c:otherwise>
     </c:choose>
     </span>
</div>

