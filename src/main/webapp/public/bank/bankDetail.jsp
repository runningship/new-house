<%@page import="com.youwei.newhouse.banking.entity.BankLabel"%>
<%@page import="java.util.List"%>
<%@page import="com.youwei.newhouse.banking.entity.Bank"%>
<%@page import="org.bc.sdak.TransactionalServiceHelper"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	String bankId = request.getParameter("bankId");
	Bank bank = dao.get(Bank.class, Integer.valueOf(bankId));
	request.setAttribute("bank", bank);
	List<BankLabel> labels = dao.listByParams(BankLabel.class, "from BankLabel where bankId=?" , Integer.valueOf(bankId));
	request.setAttribute("labels", labels);
%>
<!-- 
      <div class="owl-carousel" id="IMG_banner">
        <div class="owl-info" data-hiid="1" data-zan="1" data-zanCount="11" data-shit="0" data-shitCount="111"><img class="lazyOwl" data-src="images/cmb_banner.png"></div>
        <div class="owl-info" data-hiid="2" data-zan="0" data-zanCount="12" data-shit="0" data-shitCount="122"><img class="lazyOwl" data-src="http://placehold.it/570x300/42bdc2/FFFFFF"></div>
      </div>
 -->
       
<h2 class="h2">招商银行<a class="abtn bg_orange borr3 big fr submitKH" onclick="alertBoxFun();return false;">提交客户</a></h2>
<div class="wrap text">
   <div class="p ">${bank.biz }</div>
</div>
<c:forEach items="${labels }" var="label">
<h3 class="h3"><span class="fr"></span>${label.title }</h3>
<div class="wrap text">${label.conts }</div>
</c:forEach>s