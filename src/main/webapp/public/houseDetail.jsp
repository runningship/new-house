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
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
 	String domainName = ConfigCache.get("domainName", "www.zhongjiebao.com");
	request.setAttribute("domainName", domainName);
	Integer estateId = Integer.valueOf(request.getParameter("estateId"));
	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	Estate po = dao.get(Estate.class, estateId);
	try{
		Float.parseFloat(po.yongjin);
		po.yongjin = po.yongjin+" 元";
	}catch(Exception ex){
	}
	request.setAttribute("estate", po);
	List<HouseImage> hxImgList = dao.listByParams(HouseImage.class, "from HouseImage where estateUUID=? and type=? ", po.uuid , Constants.HuXing);
	List<HouseImage> xgImgList = dao.listByParams(HouseImage.class, "from HouseImage where estateUUID=? and type=? ", po.uuid , Constants.XiaoGuo);
	request.setAttribute("hxImgList", JSONHelper.toJSONArray(hxImgList));
	request.setAttribute("xgImgList", JSONHelper.toJSONArray(xgImgList));
	request.setAttribute("tel", request.getParameter("tel"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>新房</title>
<link rel="stylesheet" type="text/css" href="./css.css" />
<link rel="stylesheet" type="text/css" href="./style.css" />
<link href="animate.min.css" rel="stylesheet" />
<link href="../style/house.css" rel="stylesheet" />
<script type="text/javascript" src="../js/jquery.js"></script>
<link href="../js/owl-carousel/owl.carousel.css" rel="stylesheet" />
<script src="../js/owl-carousel/owl.carousel.min.js" type="text/javascript"></script>
<script src="../js/carousel.min.js" type="text/javascript"></script>
<script src="../js/buildHtml.js" type="text/javascript"></script>
<script type="text/javascript">
$(document).ready(function() {
	var huxing = JSON.parse('${hxImgList}');
	var xiaoguo = JSON.parse('${xgImgList}');
	buildHtmlWithJsonArray("repeat_xiaoguo", xiaoguo , true,true);
	buildHtmlWithJsonArray("repeat_huxing", huxing , true,true);
	initImg();
});

function initImg(){
	var owl = $('.owl-carousel');
	  owl.owlCarousel({
      lazyLoad : true,
      //autoPlay:3000,
      loop: true,
      navigation:true,
      navigationText:['<i class="iconfont">&#xe68f;</i>','<i class="iconfont">&#xe68e;</i>'],
      singleItem : true,
      autoHeight : true,
      pagination:true,
      addClassActive:true,
      afterInit:function(e){
      },
      afterMove:function(e){
      }
	  });
}

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
  <div class="owl-carousel" id="IMG_banner">
    <div class="owl-info repeat_xiaoguo" style="display:none;"><img class="lazyOwl" data-src="http://${domainName }/zjb_newhouse_images/$[estateUUID]/$[path].x.jpg"></div>
<!--     <div class="owl-info repeat_xiaoguo" ><img class="lazyOwl" data-src="http://192.168.1.222/zjb_newhouse_images/f74ecbff-4b8b-41f4-aa66-822831610599/3d102%E6%88%B7%E5%9E%8B.png.x.jpg"></div> -->
  </div>
      
      <h2 class="h2">${estate.name}<a class="abtn bg_orange borr3 big fr" onclick="parent.alertBoxFun(${estate.id}); return false;">我有客户</a></h2>
      <div class="wrap pb">
        <div class="p ">
          <div class="pd"><label class="">均价: </label><span class="F_junjia">${estate.junjia }</span><i class="tip">元/平米</i></div>
        </div>
        
        <div class="p ">
          <div class="pd"><label class="">开盘: </label><span class=""><fmt:formatDate value="${estate.opentime}" pattern="yyyy-MM-dd"/></span> </div>
          <div class="pd"><label class="">绿化: </label><span class="">${estate.lvhua }</span><i class="">%</i></div>
        </div>
        <div class="p ">
          <div class="pd"><label class="">交通: </label><span class="">${estate.jiaotong }</span></div>
          <div class="pd"><label class="">学区: </label><span class="">${estate.xuequ }</span></div>
          <div class="pd"><label class="">生活: </label><span class="">${estate.shenghuo }</span></div>
        </div>
        <div class="p ">
          <div class="pd"><label class="">建筑类型: </label><span class=""><a class="abtn">${estate.lxing }</a></span></div>
        </div>
        <div class="p ">
          <div class="pd"><label class="">物业类型: </label><span class=""><a class="abtn">${estate.wylx }</a></span></div>
        </div>
        <div class="p ">
        <div class="pd"><label class="">地址: </label><span class="">${estate.addr }<a class="abtn bg_gray borr3"></a></span></div>
        </div>
      </div>
      <h3 class="h3">佣金政策</h3>
      <div class="wrap pb">
        <div class="p ">
          <div class="pd"><label class="">结佣公司: </label><span class="">中介宝</span> </div>
          <div class="pd"><label class="">预计结佣周期: </label><span class="">T+3</span></div>
          <div class="pd"><label class="">经纪人佣金: </label><span class="yongjin" style="color:#F60">${estate.yongjin }</span></div>
          <div class="pd"><label class="">开发商界定规则: </label><span class="">经纪人推荐的客户号码隐藏中间四位，开发商方面如选择查看完整号码，则代表要约达成，客户状态变成“有效”。</span> </div>
          <div class="pd"><label class="">案场联系: </label><span class="">${estate.tel }</span> </div>
          <div class="pd"><label class="">带看规则: </label><span class="">${estate.daikanRule }</span> </div>
        </div>
      </div>
      <div class="wrap text"></div>
      <h3 class="h3">楼盘特色</h3>
      <div class="wrap text">${estate.tese }</div>

      <h3 class="h3">户型图</h3>
      <div class="owl-carousel" id="IMG_images">
      	<div class="owl-info repeat_huxing" style="display:none;"><img class="lazyOwl" data-src="http://${domainName }/zjb_newhouse_images/$[estateUUID]/$[path].x.jpg"></div>
      </div>

      <h3 class="h3">拓客技巧</h3>
      <div class="wrap text">1.周边竞品截留</div>
      <div class="wrap text">2.周边产业园客户拓展</div>
      <div class="wrap text">3.周边商业派单活动摆展宣传</div>
      <div class="wrap text">4.投资性客户宣传</div>

    </div>
    <div class="siderB"><span class="fl">　佣金: ${estate.yongjin } </span><a onclick="parent.alertBoxFun(${estate.id});" class="abtn bg_orange borr3 big fr">我有客户</a></div>
  </div>
  
</div>
</body>
</html>