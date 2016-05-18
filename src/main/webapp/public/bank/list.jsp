<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.youwei.newhouse.banking.entity.Bank"%>
<%@page import="org.bc.sdak.TransactionalServiceHelper"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);

	String tel = request.getParameter("sellerTel");
	request.setAttribute("sellerTel", tel);
	String sellerName = request.getParameter("sellerName");
	request.setAttribute("sellerName", sellerName);
	
	String comp = request.getParameter("comp");
	request.setAttribute("comp", comp);
	
	List<Map> bankList = dao.listAsMap("select b.id as id , b.name as fenhang , b.biz as biz , b.logo as logo ,u.name as bankName from Bank b , User u where u.id=b.managerUid and b.name <>'' ");
	request.setAttribute("bankList", bankList);
	if(bankList.size()>0){
		request.setAttribute("firstBankId", bankList.get(0).get("id"));	
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title></title>
<link rel="stylesheet" type="text/css" href="css/reset.css" />
<link rel="stylesheet" type="text/css" href="css/style.css" />
<link href="css/animate.min.css" rel="stylesheet" />
<script type="text/javascript" src="js/jquery.js"></script>
<script src="../../js/layer/layer.js" type="text/javascript"></script>
<script src="../../js/buildHtml.js" type="text/javascript"></script>
<link href="js/owl-carousel/owl.carousel.css" rel="stylesheet" />
<script src="js/owl-carousel/owl.carousel.min.js" type="text/javascript"></script>
<script type="text/javascript">

</script>
<script type="text/javascript">
$(document).ready(function() {
  var owl = $('.owl-carousel');
  owl.owlCarousel({
    lazyLoad : true,
    autoPlay:3000,
    loop: true,
    navigation:true,
    navigationText:['<i class="iconfont">&#xe68f;</i>','<i class="iconfont">&#xe68e;</i>'],
    singleItem : true,
    autoHeight : true,
    pagination:true,
    addClassActive:true,
    afterInit:function(e){
    },afterMove:function(e){
    }
  });

  getBankDetail(${firstBankId});
});

function getBankDetail(bankId){
	$.ajax({
	    type: 'get',
	    url: 'bankDetail.jsp?bankId='+bankId,
	    success: function(html){
	    	$('.siderC').html(html);
	    }
	});
}
</script>
<style type="text/css">

.w2 { display: table; width: 100%; font-size: 16px;padding-bottom: 5px;}
.w2 .wa { display: table-cell;width: 50%; }
.w2 .wa span{ color: #999; display: inline-block; height: inherit;}

.posa{ position: absolute; }
.posa.Ptr{ top: 0; right: 0; }

.aui_state_focus{ display: none; }
.newhousev2{ position: relative; display: block; }

.winPage{ position: fixed; top: 0; right: 0; bottom: 0; left: 0; overflow: auto; z-index: 88888; padding-top: 40px; background:rgba(229,229,229,.90);}
.winPage .contop{ width: 80%; min-width: 730px; margin: 0 auto 16px;text-indent: 0; color: #666;}
.winPage .contop:after {content: "\0020";display: block;clear: both;}
.winPage .contop h1{ font-size: 36px; font-weight: bold; padding-bottom: 10px; color: #FD6440;}
.winPage .contop .badge{ font-weight: normal; }
.winPage .contop .l{ float: left; width: 300px;   }
.winPage .contop .r{ position: relative; margin-left: 330px; }
.winPage .contop .Fjunjia b{ font-size: 30px; color: #F00; }
.winPage .content{ position: relative; width: 80%; min-width: 730px; min-height: 1000px; margin: 0 auto 16px;  background: #FFF;box-shadow: 0 1px 3px rgba(34,25,25,.4); }
.winPageArrows .winPagePrev,
.winPageArrows .winPageNext{visibility: visible; position: fixed; top: 40%; width: 60px; height: 120px; line-height: 120px; text-align: center; color: rgba(0,0,0,0.3); }
.winPageArrows .winPagePrev{ left: 0px; border-top-right-radius: 300px; border-bottom-right-radius: 300px; }
.winPageArrows .winPageNext{ right: 0px; border-top-left-radius: 300px; border-bottom-left-radius: 300px; }
.winPageArrows i{ font-size: 50px; }
.winPageArrows a:hover{ background: rgba(0,0,0,0.3); color: #FFF;}

.btn{ display: inline-block; text-align: center; padding: 10px 16px; font-size: 16px; color: #FFF; background: #FD6440; border-radius: 5px; }
.btn:hover{ color: #FFF; background: #FD7A5C; }
.btn.block{ display: block; }

a.abtn{ display: inline-block; padding: 1px 5px; font-size: 14px; }
.borr{ border-radius: all; }
.borr3{ border-radius: 3px; }
.borr5{ border-radius: 5px; }

a.abtn.big{ padding: 6px 10px; }

.bg_blue{ background: #09F; color: #FFF; }
.bg_blue:hover{ background: #2AF; color: #FFF; }
.bg_orange{ background: #FD7A5C; color: #FFF; }
.bg_orange:hover{ background: #FD7A5C; color: #FFF; }
.bg_gray{ background: #EEE; color: #666; }
.bg_gray:hover{ background: #DFDFDF; color: #666; }
.bg_border{ background: #F6F6F6; border: 1px solid #CCC; color: #666; }
.bg_border:hover{ background: #FFF; color: #666; }





.imageShow{ width:300px;overflow:hidden;}
.large_box{margin-bottom:10px;width:inherit;height:220px;overflow:hidden;}
.large_box img{display:block;}
.large_box ul,.large_box ul li{height:inherit; width:inherit;}
.large_box ul li{ background: no-repeat center; background-size: cover;}
.small_box{width:300px;height:50px;line-height:50px;overflow:hidden; position: relative;}
.small_list{position:relative;float:left;width:200px;height:inherit;overflow:hidden; width: 100%;}
.small_list ul{height:inherit;overflow:hidden;}
.small_list ul li{position:relative;float:left;margin-right:5px;width:70px; height: 50px;}
.small_list ul li img{display:block; width: 100%; height: 100%;}
.small_list ul li .bun_bg{display:none;position:absolute;top:0;left:0;width:100%;height:100%;background:#000;filter:alpha(opacity=60);-moz-opacity:0.6;-khtml-opacity:0.6;opacity:0.6;}
.small_list ul li.on .bun_bg{display:block;}
.left_btn,.right_btn{ position: absolute; top: 0; display:block; padding:0;height:inherit;cursor:pointer; border-radius: 0;background: rgba(0,0,0,0.5); color: #FFF;}
.left_btn:hover,.right_btn:hover{background-color:#e7000e;}
.left_btn i,.right_btn i{ font-size: 16px; }
.left_btn{left:0;float:left;margin-right:10px;background-image:url(../images/left_btn.png);}
.right_btn{ right: 0; float:right;background-image:url(../images/right_btn.png);}

.divs{ height: 300px; }

.posNavBox{ position:absolute; display: block; top: 0; width: 100%; min-width: 730px; margin: 0 auto 0; background: #FD6440; }
.posNavBox.fixed{ position: fixed; width: 80%; }
.posNav{ display: -webkit-box;}
.posNav li{-webkit-box-flex: 1; }
.posNav li a{ display: block; height: inherit; text-align: center; height: 40px; line-height: 40px; color: #FFF; font-size: 16px; }
.posNav li a.active{background: #F34C25;}
.posNav li a:hover{background: #F75733;}



/* 内页DIV仿Table样式 */

.table{ display: table;  border-collapse:separate; margin:0;}
.tr {display:table-row;}
.tr>.td {display:table-cell; vertical-align: top;}
.tbody{display:table-cell;}

.table_box{ height: 100%;}


.bodyer{ position: relative; height: 100%;}
.bodyer .sider{ position: absolute; top: 0; bottom: 0; left: 0; width: 35%; height: 100%; overflow: hidden; overflow-y: auto; border-right: 1px solid #EEE;}
.bodyer .mainer{ position: absolute; top: 0; bottom: 0; right: 0; left: 35%; height: 100%; overflow: hidden; overflow-y: auto;}
.bodyer .sider{ }
/* now house v2 list box */
.NH2LB{}
.NH2L li{ padding: 6px 6px; border:1px solid transparent; border-left: 0; border-right: 0; }
.NH2L li .abtn{ display:none; }
.NH2L li:after {content: "\0020";display: block; clear: both;}
.NH2L li:hover{ border-color: #CCC; border-left: 0; border-right: 0; box-shadow: 0 0 5px #CCC;}
.NH2L li.active{ border-color: #CCC; border-left: 0; border-right: 0; box-shadow: 0 0 5px #CCC;}
.NH2L li:hover .abtn{ display: inline-block; }
.NH2L .L{ float: left; width: 120px; height:100px; margin-right: 6px; background: #EEE; }
.NH2L .L img{ display: block; width: 100%; }
.NH2L .C{ }
.NH2L .R{ float: right; }
.NH2L .p{ font-size: 12px; margin-top: 5px; }

.F_h2{ font-size: 18px; color: #F60; }
.F_junjia strong{ font-size: 26px; color: #F60; }
.F_junjia i{ font-size: 12px; color: #CCC; display: inline-block; }
.F_huxing .abtn{ font-size: 12px; }
.F_dizhi{ font-size: 12px; color: #999; }


/* sider */
.sider{ position: relative; }
.siderT{ position: absolute; top: 0; left: 0; width: 100%; height: 40px; line-height: 40px; border-bottom: 1px solid #EFEFEF; }
.siderB{ position: absolute; bottom: 0; left: 0; width: 100%; height: 40px; line-height: 40px; border-top: 1px solid #EFEFEF; }
.siderC{ position: absolute; top: 00px; bottom: 40px; left: 0; width: 100%;  overflow: hidden; overflow-y: auto; }

.sNav{}
.sNav{ display: -webkit-box; background: #FD6440;}
.sNav li{-webkit-box-flex: 1; }
.sNav li a{ display: block; height: inherit; text-align: center; height: 40px; line-height: 40px; color: #FFF; font-size: 16px; }
.sNav li a.active{background: #F34C25;}
.sNav li a:hover{background: #F75733;}

.owl-carousel{ overflow: hidden; }
.owl-carousel .owl-item img{display: block;width: 100%;height: auto;}
.owl-buttons{ position: absolute; top: 30%; width: 100%; }
.owl-buttons .owl-prev,
.owl-buttons .owl-next{ height: 80px; line-height: 80px; width: 30px; text-align: center; background: rgba(0,0,0,0.05); color: #FFF;}
.owl-buttons .owl-prev:hover,
.owl-buttons .owl-next:hover{ background: rgba(0,0,0,0.3);  }
.owl-buttons .owl-prev{ position: absolute; left: 0; }
.owl-buttons .owl-next{ position: absolute; right: 0; }
.owl-pagination{ position: absolute; bottom:10px; right: 10px; }
.owl-pagination .owl-page { display: inline-block; padding-left: 3px; }
.owl-pagination .owl-page span{ display: inline-block; width: 10px; height: 10px; border-radius: 1px; background: rgba(0,0,0,0.1);}
.owl-pagination .owl-page.active span{background: rgba(0,0,0,0.3);}
/*.owl-controls{ position: absolute; left: 0; bottom: 0; right: 0; height: 40px; background: rgba(0,0,0,0.3); }*/

.siderT { box-shadow: 0 0 10px #999;}

.siderC{}
.siderC .wrap{ width: 100%; }
.siderC h2{ font-size: 24px; padding: 10px 6px; }
.siderC h3{ font-size: 16px; padding: 5px 6px; margin-top: 10px; background: #EFEFEF; }
.siderC h3 .fr{ font-size: 12px; }

.siderC .pb{}
.siderC .p{}
.siderC .pd{ padding: 3px 6px 3px; }
.siderC .pd label{ font-size: 14px; padding-right: 6px; color: #9F9F9F; }
.siderC .pd i.tip{ font-size: 14px; padding-left: 6px; color: #9F9F9F; }
.siderC .pd span.F_junjia{ font-size: 26px; color: #F60;}
.siderC .p2 .pd{ display: inline-block; width: 49%; }
.siderC .pd span{ font-size: 16px; color: #3F3F3F;}
.siderC .text{ padding: 6px 6px 6px; }

.siderB { padding-top: 3px; padding-right: 3px; box-shadow: 0 0 10px #999; }
.siderB .abtn{ line-height: 1.5em; }

.F_h2{ font-size: 18px; color: #F60; line-height: 1.5em; }
.F_h3{ font-size: 16px; color: #CCC; line-height: 1.5em; }
.F_h4{ font-size: 14px; color: #999; line-height: 1.5em; }
.F_junjia strong{ }
.F_junjia i{ font-size: 12px; color: #CCC; display: inline-block; }
.F_huxing .abtn{ font-size: 12px; }
.F_dizhi{ font-size: 12px; color: #999; }

.tipbox{ font-size: 13px; color: #999; background: #EEE;width: 300px; margin-top: 10px; padding: 6px; }
</style>
</head>

<body class="bank default">
<div class="bodyer">
  <div class="sider">
    <div class="siderC">
    </div>
    <div class="siderB"><div class="wrap text"><a class="abtn bg_orange borr3 big fr submitKH" onclick="alertBoxFun();return false;">提交客户</a></div></div>
  </div>

  <div class="mainer">
    <div class="NH2LB">
      <ul class="NH2L">
      	<c:forEach items="${bankList }" var="bank" >
	        <li onclick="getBankDetail(${bank.id});">
	          <div class="L"><img src="images/${bank.logo}" ></div>
	          <div class="R"><a class="abtn bg_orange borr3 big fr submitKH dh" onclick="alertBoxFun();return false;">提交客户</a></div>
	          <div class="C">
	            <h2 class=" F_h2">${bank.bankName }</h2>
	            <h3 class=" F_h3">
	              ${bank.fenhang}
	            </h3>
	            <h4 class=" F_h4">${bank.biz }</h4>
	          </div>
	        </li>
        </c:forEach>
      </ul>
    </div>
  </div>
</div>

<style type="text/css">
.form1{ padding:20px; }
.form1 .form-ul{ width: 300px;}
.btn_block{ display: block; }
.hidden{ display: none; }
input{outline: none;}
</style>
<script type="text/javascript">
var layer_index;
function alertBoxFun(){
	layer_index = layer.open({
        type: 1,
        title:'提交客户',
        area: ['340px', '430px'], 
        content: $('.form1'),
        success: function(layero,index){ },
        cancel: function(index){ } 
    });
}
$(document).ready(function() {
    $(document).find('.form-active').find('.input').focusin(function(){
        $(this).parent().addClass('active').addClass('focus');
    }).focusout(function(){
        if($(this).is('select')){
            if($(this).is(":selected")){
                $(this).parent().removeClass('active');
            }
        }else{
            if(!$(this).val()){
                $(this).parent().removeClass('active');
            }
        }
        $(this).parent().removeClass('focus').removeClass('curr');
    }).hover(function() {
        $(this).parent().addClass('hover');
    }, function() {
        $(this).parent().removeClass('hover');
    }).each(function(index, el) {
        if($(this).is('select')){
            $(this).parent().addClass('curr');
        }
    });
});

function addOrder(){
	$('.bankId').val($('#bankId').text());
	var url = '/new-house/c/admin/bank/addOrder';
	var a=$('form[name=form1]').serialize();
	YW.ajax({
		url: url,
		method:'post',
		cache:false,
		dataType: 'json',
		data : a,
		returnAll:false,
		mysuccess:function(ret , err){
			if(ret && ret.return_status!='302'){
				alert('提交成功');
				$('li input').val('');
				layer.close(layer_index);
			}else{
				alert('提交数据失败...');
			}
		}
	});
}
</script>
<div class="form-box form1">
	<form name="form1">
	<input type="hidden" name="sellerName" value="${sellerName }"/>
	<input type="hidden" name="sellerTel" value="${sellerTel }"/>
	<input type="hidden" name="comp" value="${comp }"/>
	<input type="hidden" name="bankId" class="bankId" value=""/>
  <ul class="form-ul">
    <li class=""><label class="form-section form-active"><strong class="input-label">小区名</strong><input desc="小区名" name="area" type="text" class="input placeholder" placeholder="小区名称"><span class="tip"></span></label></li>
    <li class=""><label class="form-section form-active"><strong class="input-label">面积 (数字)</strong><input desc="面积" name="mji" type="text" class="input placeholder" placeholder="面积 (数字)"><span class="tip">m²</span></label></li>
    <li class=""><label class="form-section form-active"><strong class="input-label">价格 (万元)</strong><input desc="总价" name="zjia" type="text" class="input placeholder" placeholder="价格 (万元)"><span class="tip">万元</span></label></li>
    <li class=""><label class="form-section form-active"><strong class="input-label">拟贷款 (万元)</strong><input desc="贷款金额" name="loan" type="text" class="input placeholder" placeholder="拟贷款 (万元)"><span class="tip">万元</span></label></li>
    <a href="javascript:void(0);" class="btn btn_block btn_act" onclick="addOrder()">提交</a>
<!--         <input type="submit" class="submit hidden btn btn_act" value="submit" > -->
  </ul>
<div class="tipbox">
<p>· 填写购房客户购买的楼盘简况及拟贷款金额。</p>
<p>· 银行工作人员收到提交信息后会主动与您联系。</p>
<p>· 该业务仅限门店办理。</p>
<p>· 为您提供银行房贷方面的选择渠道。</p>
</div>
  </form>
</div>
</body>
</html>