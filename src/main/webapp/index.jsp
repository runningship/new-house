<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="header.jsp" />
</head>

<body>
<jsp:include page="top.jsp"></jsp:include>
<jsp:include page="nav.jsp"></jsp:include>
<script type="text/javascript" src="js/kxbdSuperMarquee.js"></script>
<script type="text/javascript">
/*
var system = { win: false, mac: false, xll: false };
//检测平台      
var p = navigator.platform;
system.win = p.indexOf("Win") == 0;
system.mac = p.indexOf("Mac") == 0;
system.x11 = (p == "X11") || (p.indexOf("Linux") == 0);
//跳转语句      
if (system.win || system.mac || system.xll) {            }
else {
    window.location.href = "m/index.jsp";
}   
*/
$(function(){
  //一次横向滚动一个
  $('#marquee1').kxbdSuperMarquee({
    distance:376,
    duration:99,
    btnGo:{left:'#goL',right:'#goR'},
    direction:'left'
  });

});

</script>
<style type="text/css">
  #marquee1 {
  width:650px;
  height:100px;
  overflow:hidden;
}
    #marquee1 ul li {float:left;height:100px;}
    #marquee1 ul li img {display:block;}

</style>
<div class="warp banner">
      
      <div class="bigBgImg">
               
                    <ul id="bigPic">
                    
                        <a href="http://www.jinbaohouse.com/fjb/info.jsp?estateId=42" target="_blank"><li style="z-index:1; display:list-item; background:url(images/banner11.jpg) no-repeat center top;" ></li></a>
                        <a href="http://www.jinbaohouse.com/fjb/info.jsp?estateId=36" target="_blank"><li style="z-index:0; display:none; background:url(images/banner12.jpg) no-repeat center top;"></li></a>
                        <a href="http://www.jinbaohouse.com/fjb/info.jsp?estateId=43" target="_blank"><li style="z-index:0; display:none; background:url(images/banner13.jpg) no-repeat center top;"></li></a>
                        <a href="http://www.jinbaohouse.com/fjb/info.jsp?estateId=53" target="_blank"><li style="z-index:0; display:none; background:url(images/banner14.jpg) no-repeat center top;"></li></a>
<!--                         <li style="z-index:0; display:none; background:url(images/banner3.jpg) no-repeat center top;"></li> -->
                    
                    </ul>
                    <ul id="litPic"></ul>
               
      </div>
      
      
      <div class="warp" style="position:absolute;  top:0; left:0;">

           <div class="main">
           
                <div class="l-r-box" style="z-index:100;">
                        
                        <div class="bg"></div>
                		<c:if test="${seller ==null }">
			            <div class="l-r">
                            <a href="login.jsp" class="fl i-p-login">登录</a>
                            <a href="register.jsp" class="fr i-p-register">注册</a>
                        </div>
                        </c:if>
                        <div class="l-r-step">
                            <a href="register.jsp" class="i-p-step-1">
                                <i><img src="images/step1.png" /></i>
                                <strong>经纪人注册</strong>
                                <span>一键注册、轻松操作</span>
                            </a>
                            <a href="login.jsp" class="i-p-step-2">
                                <i><img src="images/step2.png" /></i>
                                <strong>不仅销售二手房</strong>
                                <span>增加销售渠道 新房也能卖</span>
                            </a>
                            <a href="login.jsp" class="i-p-step-3">
                                <i><img src="images/step3.png" /></i>
                                <strong>赚取佣金</strong>
                                <span>推荐销售即得佣金</span>
                            </a>
                        </div>
                </div>
           
           </div>
           
      </div>
      
      
      

</div>

<div class="warp">

     <div class="main">
     
          <div class="tuijian">
          
               <div class="tit"><span class="t fl">推荐楼盘</span><span class="m fr">本期共有<strong>${total}</strong>个合作楼盘，<strong>优惠幅度最大${maxYouhui }</strong></span></div>
               <ul class="con"> 
                  <c:forEach items="${page.result}"  var="tuijian">
                    <li>
                      <a href="info.jsp?estateId=${tuijian.id}">
                        <span class="img"><img src="${upload_path}/${tuijian.img}" /></span>
                      </a>
                       <p><strong>[${tuijian.quyu}]${tuijian.name}</strong></p>
                       <p><em>均价：¥${tuijian.junjia}/m2</em></p>
                       
<%--                        <p><c:if test="${tuijian.yufu != null && tuijian.shidi !=null}"><span class="yhBg">优惠</span> <b>${tuijian.yufu}享${tuijian.shidi }</b></c:if>&nbsp;</p> --%>
                       <p><c:if test="${tuijian.youhuiPlan != null}"><span class="yhBg">优惠</span> <b>${tuijian.youhuiPlan}</b></c:if>&nbsp;</p>
                    </li>
                  </c:forEach>
                    
               </ul>
    <jsp:include page="page.jsp" />
          
          </div>
          
          <div class="rightList fr">
          
<jsp:include page="right.jsp"></jsp:include>
          
          </div>
     
    <div class="partners" style="height:300px;">
      <div class="partners-inner clearfix">
        <div class="tit"><span class="t fl">合作伙伴：</span></div>
        <div class="partners-r clearfix scroll-img"  >
          <div id="control" style="position:relative">
            <img src="${projectName}/images/left.jpg" style="width:30px;height:50px;position: absolute;top: 18px;left: 6px;cursor:pointer" id="goL">
            <div id="marquee1" style="position:absolute;left:36px">
              <ul>
                <li><img src="${projectName}/images/hzhb/szjt.jpg" alt="尚泽集团" id="moveleft"  style="margin-right: 3px;width:91px;height:100px;" title="尚泽集团"></li>
                <li><img src="${projectName}/images/hzhb/sljt.jpg" alt="圣联集团" id="moveleft" title="圣联集团" style="margin-right: 3px;width:91px;height:100px;" ></li>
                <li><img src="${projectName}/images/hzhb/wy.jpg" alt="文一" id="moveleft" title="文一" style="margin-right: 3px;width:91px;height:100px;" ></li>
                <li><img src="${projectName}/images/hzhb/zttz.jpg" alt="中天投资" id="moveleft" title="中天投资" style="margin-right: 3px;width:91px;height:100px;" ></li>
                <li><img src="${projectName}/images/hzhb/1.jpg" alt="信达地产"  style="margin-right: 3px;width:91px;height:100px;" title="信达地产"></li>
                <li><img src="${projectName}/images/hzhb/2.jpg" alt="万科"  style="margin-right: 3px;width:91px;height:100px;" title="万科"></li>
                <li><img src="${projectName}/images/hzhb/3.jpg" alt="万达集团"  style="margin-right: 3px;width:91px;height:100px;" title="万达集团"></li>
                <li><img src="${projectName}/images/hzhb/4.jpg" alt="华邦集团" id="moveright" style="margin-right: 3px;width:91px;height:100px;" title="华邦集团"></li>
                <li><img src="${projectName}/images/hzhb/5.jpg" alt="绿地集团" id="moveright" style="margin-right: 3px;width:91px;height:100px;" title="绿地集团"></li>
                <li><img src="${projectName}/images/hzhb/6.jpg" alt="保利地产" id="moveright" style="margin-right: 3px;width:91px;height:100px;" title="保利地产"></li>
                <li><img src="${projectName}/images/hzhb/7.jpg" alt="恒大集团" id="moveright"  style="margin-right: 3px;width:91px;height:100px;" title="恒大集团"></li>
              </ul>
            </div>
            <img src="${projectName}/images/right.jpg" style="width:30px;height:50px;position: absolute;float:right;right: -230px;bottom: -68px;cursor:pointer" id="goR">
          </div>
        </div>
      </div>
      <div style="position: relative;top: 130px;">
          <div class="tit"><span class="t fl">旗下运营：</span></div>
            <div class="partners-r clearfix" style="float:left;">
              <img src="${projectName}/images/hzhb/wxah.jpg" alt="无限安徽" title="无限安徽" style="margin-right: 3px;width:90px;height:100px;" >
              <img src="${projectName}/images/hzhb/zjb.jpg" alt="中介宝" title="中介宝" style="margin-right: 3px;width:90px;height:100px;" >
              <img src="${projectName}/images/hzhb/kqcm.jpg"  style="margin-right: 3px;width:90px;height:100px;" alt="科奇传媒" title="科奇传媒">
              <img src="${projectName}/images/hzhb/hkly.jpg" style="margin-right: 3px;width:90px;height:100px;" alt="泓扣礼仪" title="泓扣礼仪">
            </div>
      </div>
</div>
</div>
</div>
<jsp:include page="foot.jsp"></jsp:include>

</body>
</html>
