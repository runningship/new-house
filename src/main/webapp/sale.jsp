<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="header.jsp" />
<script type="text/javascript">
  function closeOpen(id){
    LayerRemoveBox(id);
  }

function order_success(){
  var info = $('#success_info');
  var left = ($(document).width()-info.width())/2 ;
  var height = $(document).scrollTop()+(window.screen.height-info.height())/2 ;
  info.css({top:height,left:left});
  info.css('display','');
  
  setTimeout(function(){
    info.css('display','none'); 
  },2000);
  //alert(11);
}
</script>
</head>

<body>

<jsp:include page="top.jsp"></jsp:include>
<jsp:include page="nav.jsp"></jsp:include>
<div class="warp">

     <div class="main">
     
     
          <div class="teSelect">
               
               <h2>房金宝承诺真实房源<em>[共${page.totalCount }款特惠房源促销中]</em></h2>
               
<!--                <div class="choose"> -->
<!--                         <div class="choose_list"> -->
<!--                             <label class="pass-label">区域</label> -->
<!--                             <select onchange="checkSelect('qy');" id="quyu" class="sortSelect"> -->
<!--                                 <option value="" selected="">默认区域</option> -->
<%--                                 <c:forEach items="${quyus}" var="quyu"> --%>
<%--                                   <option value="${quyu.value}">${quyu.value}</option> --%>
<%--                                 </c:forEach> --%>
<!--                             </select> -->
<!--                         </div> -->
<!--                         <div class="choose_list"> -->
<!--                             <label class="pass-label">户型</label> -->
<!--                             <select onchange="checkSelect('hx');" id="huxing" class="sortSelect"> -->
<!--                                 <option value="" selected="">默认户型</option> -->
<%--                                 <c:forEach items="${hxings}" var="hxing"> --%>
<%--                                   <option value="${hxing.value}">${hxing.value}</option> --%>
<%--                                 </c:forEach> --%>
<!--                             </select> -->
<!--                         </div> -->
<!--                         <div class="choose_list"> -->
<!--                             <label class="pass-label">价位</label> -->
<!--                             <select onchange="checkSelect('jw');" id="jiawei" class="sortSelect"> -->
<!--                                 <option value="" selected="">默认价位</option> -->
<!--                                 <option value="1">6000元以下</option> -->
<!--                                 <option value="2">6000-10000元</option> -->
<!--                                 <option value="3">1-1.5万</option> -->
<!--                                 <option value="4">1.5-2万</option> -->
<!--                                 <option value="5">2-2.5万</option> -->
<!--                                 <option value="6">2.5-3万</option> -->
<!--                                 <option value="7">3万以上</option> -->
<!--                             </select> -->
<!--                         </div> -->
<!--                     </div> -->
          
          </div>
     
          <c:forEach items="${page.result}" var="youhui">
          <div class="teHui">
          
               <h2><span class="title">${youhui.name}<em>[${youhui.quyu}]</em></span></h2>
               <div class="lpPic"><a href="info.jsp?estateId=${youhui.id}"><img style="width:570px;height:280px;" src="${upload_path }/${youhui.img}" /></a></div>
               <div class="lpCon">
                   
                    <span class="hYPrice"><em>市场价  ${youhui.junjia}</em></span>
                    <span class="hYPrice" style="margin-bottom:10px;">
                    	<c:if test="${youhui.youhuiPlan != null}">独家特惠: ${youhui.youhuiPlan}</c:if>
<%--                     	<c:if test="${youhui.yufu != null && youhui.shidi !=null}">${youhui.yufu}享${youhui.shidi }</c:if> --%>
                    </span>
                    <span class="liaojie">
                          <div class="fl w180" style="margin-top:-6px;">
                               <p>楼盘位置：${youhui.quyu}</p>
                               <p style="margin-top:10px;">开盘日期：<fmt:formatDate value="${youhui.opendate}" pattern="yyyy-MM-dd"/></p>
                          </div>
                          <a href="info.jsp?estateId=${youhui.id}" class="btn-sub fl">了解详情</a>
                    </span>
                    
                    <span class="yuyue" style="margin-top:0px;">
                          <div class="fl w180">
                               <em>${youhui.orderCount }</em>人已预约看房
                          </div>
                          <a href="#" onclick="openNewWin('estate_order', '预约看房 ','yykf.jsp?estateId=${youhui.id}');return false" class="btn-main fl">预约看房</a>
                    </span>
                    
                    
                    <span class="tehuiClock">
<%--                     已成交:<em>${youhui.chengjiao}</em>套 &nbsp;  --%>
					<em>优惠活动截止于<fmt:formatDate value="${youhui.youhuiEndtime}" pattern="yyyy年MM月dd日"/></em>
<!--                     活动结束剩<em>93</em>天<em>7</em>小时<em>19</em>分钟<em>39</em>秒</span> -->
               
               </div>
          
          </div>
          </c:forEach>
		
		<jsp:include page="page.jsp" />
         
     </div>

</div>

<img id="success_info" src="images/success_info.png" style="display:none;position:absolute;border:1px solid #999"/>


<jsp:include page="foot.jsp"></jsp:include>
</body>
</html>
