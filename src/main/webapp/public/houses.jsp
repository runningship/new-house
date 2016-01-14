<%@page import="com.youwei.newhouse.cache.ConfigCache"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
 	String domainName = ConfigCache.get("domainName", "www.zhongjiebao.com");
	request.setAttribute("domainName", domainName);
	String tel = request.getParameter("tel");
	request.setAttribute("tel", tel);
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
<script type="text/javascript" src="../js/artDialog/jquery.artDialog.source.js?skin=default"></script>
<script type="text/javascript" src="../js/artDialog/plugins/iframeTools.source.js"></script>
<script src="../js/buildHtml.js" type="text/javascript"></script>
<script type="text/javascript">
$(document).ready(function() {
	loadData();
});

var orderEstateId;
var gender;
function loadData(){
	var url = '/new-house/c/m/listSalesData';
	YW.ajax({
		url: url,
		method:'post',
		cache:false,
		 dataType: 'json',
		data:{name:''},
		returnAll:false,
		mysuccess:function(ret , err){
			if(ret){
				buildHtmlWithJsonArray("repeat",ret.page.data , true,true);
				$('.NH2L li').first().click();
			}else{
			}
		}
	});
}

function saveOrder(){
	var url = '/new-house/c/admin/order/doSave';
	var buyerName = $('#name').val();
	var buyerTel = $('#tel').val();
	if(!buyerName){
		infoAlert('请先填写客户姓名');
		return;
	}
	if(!buyerTel){
		infoAlert('请先填写客户电话');
		return;
	}
	YW.ajax({
		url: url,
		method:'post',
		cache:false,
		dataType: 'json',
		data:{sellerName: "" , sellerTel: "${tel}", buyerName: buyerName , buyerTel: buyerTel , buyerGender: gender , estateIds: orderEstateId},
		returnAll:false,
		mysuccess:function(ret , err){
			if(ret && ret.return_status!='302'){
				infoAlert('提交成功');
				$('.ss_alert_close').click();
			}else{
				infoAlert('提交数据失败...');
			}
		}
	});
}

function viewEstate(id){
	$('#estateFrame').attr('src', 'houseDetail.jsp?tel=${tel}&estateId='+id);
}
</script>
<style type="text/css">
.NH2L .L .img{width:100%;    height: 100%}
.bodyer .sider {
    overflow: hidden;
}
</style>
</head>

<body class="newhousev2">
<div class="bodyer">
   <div class="sider">
   	<iframe id="estateFrame" style="height:100%;width:100%;" src=""></iframe>
  </div>
  
  <div class="mainer">
    <div class="NH2LB">
      <ul class="NH2L">
        <li class="repeat" style="display:none;" onclick="viewEstate($[id])">
          <div class="L"><img class="img" src="http://${domainName }/zjb_newhouse_images/$[uuid]/$[img].t.jpg"/></div>
          <div class="R"><div class="p F_junjia"><strong>$[junjia]</strong> <i>均价</i></div></div>
          <div class="C">
            <h2 class=" F_h2">$[name]</h2>
            <div class="p F_huxing">
              <a href="" class="abtn bg_gray borr3">$[mainHuxing]</a>
            </div>
            <div class="p F_dizhi">$[quyu] $[addr]</div>
            <div class="p">
              <a href="" class="abtn bg_gray borr3">$[wylx]</a>
            </div>
          </div>
        </li>
      </ul>
    </div>
  </div>
</div><style type="text/css">

.form_info{ width: 80%; margin: 0 auto; }
.form_info li{ padding: 5px 0; }

.inputbox{ border: 1px solid #CCC; background: #FFF; border-radius: 3px; height: 40px; line-height: 40px; width: 100%;}
.inputbox input{ display: block; border: none; background: none; border-radius: inherit; height:inherit; width: 100%; padding-left: 5px; font-size: 16px; font-family: 'microsoft yahei';}

.btnGroup{ display: -webkit-box; text-align: center; height: 30px; line-height: 30px; border-radius: 100px; background: #CFCFCF; overflow: hidden; }
.btnGroup .btns{ -webkit-box-flex: 1;display: block; height: inherit;}
.btnGroup .btns.active{ background: #BBB; }
.btnGroup.orange{ background: #FF6100; color: #FFF; }
.btnGroup.orange .btns{ color: #FFD0D0; }
.btnGroup.orange .btns.active{ background: #EB4923; color: #FFF; }

.newhousev2 .btnGroup{float: right; width: 40%; margin: 5px 5px 0 0 ;}
.newhousev2 .inputbox.t2{ width: 50%; }
.newhousev2 p.tip{ color: #9F9F9F; }
</style>
<div class="ss_alertBox" style="display:;">
  <div class="ss_alert_tit">
    <div class="ss_alert_head">
      <h1>提交客户：</h1>
      <p style="display: hidden;"></p>
    </div>
    <a href="#" class="ss_alert_close">X</a>
  </div>
  <div class="ss_alert_cont">
    <ul class=" form_info">
        <li>
            <div class="btnGroup t2 orange">
                <a class="btns active" onclick="gender='先生'">先生</a>
                <a class="btns" onclick="gender='女士'">女士</a>
            </div>
            <div class="inputbox t2"><input id="name" type="text" class="input" placeholder="客户姓名"></div>
        </li>
        <li><div class="inputbox"><input id="tel" type="text" class="input" placeholder="客户电话"></div></li>
        <li><div class="inputbox"><input type="text" class="input" readonly="readonly" value="${tel }" placeholder="您的联系电话"></div></li> 
        <li style="cursor:pointer;"><a onclick="saveOrder();" class="btn block">提交</a></li>
    </ul>

  </div>
</div>
<script type="text/javascript">
function alertBoxFun(id){
  orderEstateId = ""+id;
  var T=$('.ss_alertBox'),
  TW=T.innerWidth(),
  TH=T.innerHeight(),
  B=$('body'),
  BW=B.width(),
  TL=BW/2-TW/2;
  T.css({'display':'block','left':TL+'px'});
  //T.find('.input').val('');
  $('#tel').val('');
  $('#name').val('');
  T.find('.input').eq(0).focus();

  T.find('.form_info').attr('data-id',id);
}

$(document).ready(function() {
  $('.textconta').hover(function() {
    $(this).next().removeClass('hidden');
  }, function() {
    $(this).next().addClass('hidden');
  }).click(function(event) {
    event.preventDefault();
  });
  $(document).on('click', '.ss_alertBox .ss_alert_close', function(event) {
    $('.ss_alertBox').hide();
    event.preventDefault();
    /* Act on the event */
  });
  $(document).on('click','.btnGroup .btns', function(event) {
    var btn=$(this),
    //group=btn.parents('.btnGroup'),
    C='active';
    btn.addClass(C).siblings().removeClass(C);
    event.preventDefault();
    /* Act on the event */
  });
});
</script>
</body>
</html>