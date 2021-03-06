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
<%
 	String domainName = ConfigCache.get("domainName", "www.zhongjiebao.com");
	request.setAttribute("domainName", domainName);
	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	StringBuilder hql = new StringBuilder("select  order.id as id, est.name as estateName, order.buyerName as buyerName ,order.buyerTel as buyerTel, "
			+ " order.sellerName as sellerName ,order.buyerGender as buyerGender ,order.sellerTel as sellerTel, order.addtime as addtime, order.status as orderStatus ,order.daikan as daikan from HouseOrder order, "
			+ "Estate est where order.estateId=est.id and sellerTel=?");
	String tel = request.getParameter("tel");
	List<Map> orderList = dao.listAsMap(hql.toString() , tel);
	request.setAttribute("orderList", JSONHelper.toJSONArray(orderList));
	request.setAttribute("tel", tel);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>推荐记录</title>
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
	var orderList = JSON.parse('${orderList}');
	if(orderList.length==0){
		$('#emptyMsg').show();
	}
	buildHtmlWithJsonArray("repeat", orderList , true,true);
});

</script>
<script type="text/javascript">
$(document).on('click', '.khlist a.box', function(event) {
  var T=$(this),
  TP=T.parent(),
  id=TP.attr('data-id'),
  C='active',
  Z='ShuList_';
  if($('.repeat_'+id).length>0){
	  var url = '/new-house/c/m/listOrderGenjin';
		YW.ajax({
			url: url,
			method:'post',
			cache:false,
			dataType: 'json',
			data:{orderId:id},
			returnAll:false,
			mysuccess:function(ret , err){
				if(ret){
					buildHtmlWithJsonArray("repeat_"+id,ret.genjiList , true,true);
					$(Z + id).html(getHtml(id));
				}else{
					alert('加载数据失败');
				}
			}
		});
  }else{
	$(Z + id).html(getHtml(id));
  }
  
  
  TP.addClass(C).siblings().removeClass(C);
  event.preventDefault();
  /* Act on the event */
});

function getHtml(id){
    var H;
    H='<ul class="ul">';
    
    // alax ....
    
    H=H+'</ul>';
    return H;
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
      <div class="wrap">
      	<div id="emptyMsg" style="text-align:center;display:none;">您还没有推荐过任何客户，赶快推荐拿佣金吧! </div>
        <ul class="khlist">
          <li class="repeat" style="display:none;" data-id="$[id]"><a href="#" class="box">
            <div class="fr"><i class="iconfont">&#xe672;</i></div>
            <strong class="xm">$[buyerName]</strong>
            <span class="hm">$[buyerTel]</span>
            <span class="zt">$[orderStatus]<b>$[addtime]</b></span>
            <span class="hn">$[estateName]</span>
          </a>
          <div class=" ShuList " id="ShuList_$[id]">
            <ul class="ul ">
              <li class="" >
                <span class="fl"><i class="iconfont">&#xe68a;</i></span>
                <h4>等待处理</h4>
                <p>$[addtime]</p>
              </li>
              <li class="repeat_$[id]" style="display:none;">
                <span class="fl"><i class="iconfont">&#xe68a;</i></span>
                <h4><b>$[uname]</b>将状态修改为<b>$[status]</b></h4>
                <p>$[addtime]</p>
              </li>
            </ul>
          </div>
          </li>
        </ul>
      </div>
    </div>
  </div>
  
</div>
</body>
</html>