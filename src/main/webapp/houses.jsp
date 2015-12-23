<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="header.jsp" />
<script type="text/javascript">
function searchByPrice(){
	//window.location='houses.jsp?searchText='+$('#searchText').val()+'&quyu='+$('#quyu').val()+'&lxing='+$('#lxing').val();
	$('#quyu_input').val($('#quyu_select').val());
	$('#lxing_input').val($('#lxing_select').val());
	$('#jiageStart_input').val($('#jiageStart_select').val());
	$('#jiageEnd_input').val($('#jiageEnd_select').val());
	document.forms[0].submit();
}

$(function(){
	$('#jiageStart_select').val(${jiageStart});
	$('#jiageEnd_select').val(${jiageEnd});
});
</script>
</head>

<body>

<jsp:include page="top.jsp"></jsp:include>
<jsp:include page="nav.jsp"></jsp:include>


<div class="warp">

     <div class="main">
     
          <div class="teSelect fl">
               
               <h2>房金宝在售房源<em><c:if test="${session_city !=null }">[${session_city }最低价]</c:if></em></h2>
               
               <div class="choose">
                        <div class="choose_list">
                            <label class="pass-label">区域</label>
                            <select onchange="checkSelect();" id="quyu_select" class="sortSelect">
                                <option value="" selected="">全市</option>
                                <c:forEach items="${quyus}" var="quyu">
                                  <option <c:if test="${quyu.value eq selectedQuyu }">selected="selected"</c:if> value="${quyu.value}">${quyu.value}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="choose_list">
                            <label class="pass-label">楼型</label>
                            <select onchange="checkSelect()" id="lxing_select" class="sortSelect">
                                <option value="" selected="">所有</option>
                                <c:forEach items="${lxings}" var="lxing">
                                    <option <c:if test="${lxing.value eq selectedLxing }">selected="selected"</c:if> value="${lxing.value}">${lxing.value}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="choose_list">
                            <label class="pass-label">价位</label>
                            <!-- <select style="width:85px;" onchange="checkSelect()" id="jiageStart_select"  class="sortSelect">
                                <option value="" selected="">默认价位</option>
                                <option value="6000">6000元</option>
                                <option value="10000">1万</option>
                                <option value="15000">1.5万</option>
                                <option value="20000">2万</option>
                                <option value="25000">2.5万</option>
                                <option value="30000">3万</option>
                            </select><span> 以上</span>
                            <select style="width:85px;" onchange="checkSelect()" id="jiageEnd_select"    class="sortSelect">
                                <option value="" selected="">默认价位</option>
                                <option value="6000">6000</option>
                                <option value="10000">1万</option>
                                <option value="15000">1.5万</option>
                                <option value="20000">2万</option>
                                <option value="25000">2.5万</option>
                                <option value="30000">3万</option>
                            </select><span> 以下</span> -->
                            <input id="jiageStart_select" style="width:100px;height:21px;"/>~<input id="jiageEnd_select" style="width:100px;height:21px;"/><span>元</span>
                            <a href="#" onclick="searchByPrice()" style="text-decoration:underline">查询</a>
                        </div>
               </div>
          
          </div>
          
          <div class="allList fl">
          
               <ul>
                <c:forEach items="${page.result}" var="house">
                     <li>
                        <a target="_blank" href="info.jsp?estateId=${house.id}"><img width="180" height="120" src="${upload_path}/${house.img}"></a>
                        <span class="f_name"><a target="_blank" href="#">[${house.quyu}]${house.name}</a></span>
                        
                        <span class="f_price"><em>${house.junjia}<c:if test="${house.junjia != null}">元/㎡</c:if></em>
                        <span class="f_sale"><c:if test="${house.youhuiPlan != null}"><span style="background-color:red;color:white">优惠 </span></c:if><b>&nbsp; ${house.youhuiPlan }</b></span>
<%--                         <a target="_blank" href="info.jsp?estateId=${house.id}"> --%>
<!--                         <button class="button_tao" title="了解更多" type="submit">了解更多</button></a></span> -->
                     </li>   
                </c:forEach>                      
               </ul>
               
           <jsp:include page="page.jsp" />
          </div>
          
          <div class="rightList fl">
          
			<jsp:include page="right.jsp"></jsp:include>
          </div>
     	
     </div>

</div>



<jsp:include page="foot.jsp"></jsp:include>
</body>
</html>
