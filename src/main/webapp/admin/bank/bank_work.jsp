<%@page import="java.util.List"%>
<%@page import="com.youwei.newhouse.banking.entity.BankLabel"%>
<%@page import="com.youwei.newhouse.banking.entity.Bank"%>
<%@page import="org.bc.sdak.TransactionalServiceHelper"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@page import="com.youwei.newhouse.entity.User"%>
<%@page import="com.youwei.newhouse.ThreadSessionHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	User u = ThreadSessionHelper.getUser();
	request.setAttribute("user", u);
	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	if(u!=null){
		Bank po = dao.getUniqueByKeyValue(Bank.class, "managerUid", u.id);
		if(po==null){
			po = new Bank();
			po.name = "";
			po.biz="";
			po.managerUid = u.id;
			dao.saveOrUpdate(po);
		}
		request.setAttribute("bank", po);
		List<BankLabel> labels = dao.listByParams(BankLabel.class, "from BankLabel where bankId=?", po.id);
		request.setAttribute("labels", labels);	
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>业务设置</title>
<script type="text/javascript" src="js/jquery.js"></script>
<link href="../../js/BS/css/bootstrap.min.css" rel="stylesheet" />
<script src="../../js/BS/js/bootstrap.min.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="css/reset.css" />
<link rel="stylesheet" type="text/css" href="css/style.css" />
<script src="../../js/layer/layer.js" type="text/javascript"></script>
<script src="../../js/buildHtml.js" type="text/javascript"></script>
<script src="js/jquery.jform.js" type="text/javascript"></script>
<script type="text/javascript">
$(document).on('click', '.btn_act', function(event) {
  var T=$(this),
  TYPE=T.attr('data-type');
  if(TYPE=='addTab'){
    var TP=T.parents('li'),
    Tid=TP.attr('data-id');
    layer.msg('确认'+Tid);
  }else if(TYPE=='submit'){
    submit_act();
  }else if(TYPE=='addLi'){
    addLi();
  }else if(TYPE=='addLiServ'){
    addLiServ(T)
  }else if(TYPE=='addLiNo'){
    addLiNo(T)
  }else if(TYPE=='editLi'){
    editLi(T);
  }else if(TYPE=='editLiServ'){
    editLiServ(T);
  }else if(TYPE=='editLiNo'){
    editLiNo(T)
  }else if(TYPE=='delLi'||TYPE=='editLiDel'){
	  YW.ajax({
		    type: 'post',
		    url: '/new-house/c/admin/bank/deleteLabel',
		    data: {id: $(this).attr('label-id') },
		    dataType:'json',
		    mysuccess: function(json){
		    	delLi(T);
		    }
		});
  }else{}
  event.preventDefault();
  /* Act on the event */
});
function inputAct(t){
tp=t.parents('li');
tp.siblings().removeClass('err');
var tii=0,tnum=6;
var times=setInterval(function(){
if(tii==0){
tp.addClass('err');
tii++;
}else{
tp.removeClass('err');
tii--;
}
if(--tnum<=0){ clearInterval(times);}
},150);
}
function submit_act(){
    var J=new Object(),
    Fm=$('.form1'),
    Fid=Fm.attr('data-id'),
    Fva=Fm.find('.name'),
    Fvb=Fm.find('.biz'),
    Fli=Fm.find('li.for'),
    isFerr=0;
    if(!Fva.val()){inputAct(Fva);Fva.focus();return false;}
    if(!Fvb.val()){inputAct(Fvb);Fvb.focus();return false;}
    //JSON.parse('{}');
    J.name=Fva.val();
    J.biz=Fvb.val();
    var jstr=JSON.stringify(J);
    
    
    YW.ajax({
	    type: 'post',
	    url: '/new-house/c/admin/bank/add',
	    data: {id: '${bank.id}' , name: Fva.val() , biz: Fvb.val()},
	    dataType:'json',
	    mysuccess: function(json){
	    	layer.msg('保存成功');
	    }
	});
}
function addLi(){
var listr='<li class="for" data-id="">'
+'<div class="libox">'
+'<h2><input type="text" class="title" value="" placeholder="标签标题"></h2>'
+'<div class="licont"><textarea rows="5" class="conts" placeholder="标签内容"></textarea>'
+'<a href="#" class="btn_act btn btn-primary" data-type="addLiServ">保存</a> '
+'<a href="#" class="btn_act btn btn-default" data-type="addLiNo">取消</a>'
+'</div>'
+'</div>'
+'</li>';
$('.form1 .form-ul').append(listr).find('.title').focus();
}
function addLiServ(Thi){
  var TP=Thi.parents('li'),
  TPT=TP.find('.title'),
  TPC=TP.find('.conts');
  if(TPT.val()&&TPC.val()){
    var J=new Object();
    J.title=TPT.val();
    J.conts=TPC.val();
    var Jstr=JSON.stringify(J);
    // ajax...
    // if true then
    // TP.attr('data-id',id);
    YW.ajax({
	    type: 'post',
	    url: '/new-house/c/admin/bank/addLabel',
	    data: {bankId: '${bank.id}' , title: J.title , conts: J.conts},
	    dataType:'json',
	    mysuccess: function(json){
	    	LiServ(TP,J);
	    }
	});
    
  }else{
    if(!TPT.val()){inputAct(TPT);TPT.focus();return false;}
    if(!TPC.val()){inputAct(TPC);TPC.focus();return false;}
  }
}
function addLiNo(Thi){
  var TP=Thi.parents('li'),
  Tid=TP.attr('data-id');
  if(Tid){
    // ajax...
    layer.msg(Tid)
  }else{
    layer.msg('敬告：获取不到ID')
  }
    TP.remove();
}
function editLi(Thi){
  var TP=Thi.parents('li'),
Tt=TP.find('.libox h2'),
Tc=TP.find('.licont');
TP.attr('data-title',Tt.text());
TP.attr('data-conts',Tc.text());
var listr='<div class="libox"><h2><input type="text" class="title" value="'+Tt.text()+'" placeholder="标签标题"></h2>'
+'<div class="licont"><textarea rows="5" class="conts" placeholder="标签内容">'+Tc.text()+'</textarea>'
+'<a href="#" class="btn_act btn btn-primary" data-type="editLiServ">保存</a> '
+'<a href="#" class="btn_act btn btn-default" data-type="editLiNo">取消</a> '
+'</div></div>';
TP.html(listr).find('.title').focus();
}
function editLiServ(Thi){
  var TP=Thi.parents('li'),
  TPid=TP.attr('data-id'),
  TPT=TP.find('.title'),
  TPC=TP.find('.conts');
  if(TPT.val()&&TPC.val()){
    var J=new Object();
    J.id=TPid;
    J.title=TPT.val();
    J.conts=TPC.val();
    var Jstr=JSON.stringify(J);
    YW.ajax({
	    type: 'post',
	    url: '/new-house/c/admin/bank/addLabel',
	    data: {id: TPid ,bankId: '${bank.id}' , title: J.title , conts: J.conts},
	    dataType:'json',
	    mysuccess: function(json){
	    	LiServ(TP,J);
	    }
	});
    // ajax...
    // if true then
    // TP.attr('data-id',id);
  }else{
    if(!TPT.val()){inputAct(TPT);TPT.focus();return false;}
    if(!TPC.val()){inputAct(TPC);TPC.focus();return false;}
  }
}
function editLiNo(Thi){
  var TP=Thi.parents('li'),
  TPid=TP.attr('data-id'),
  TPT=TP.attr('data-title'),
  TPC=TP.attr('data-conts'),
  J=new Object();
  J.id=TPid;
  J.title=TPT;
  J.conts=TPC;
  LiServ(TP,J);
}
function LiServ(TP,Json){
var J=Json,
Jid=J.id,
Jt=J.title,
Jc=J.conts;
var listr='<div class="icoBtnBox"><a href="#" class="icoBtn btn_act" data-type="editLi"><i class="iconfont">&#xe62b;</i></a><a href="#" class="icoBtn btn_act" data-type="delLi"><i class="iconfont">&#xe68c;</i></a></div>'
+'<div class="libox">'
+'<h2>'+Jt+'</h2>'
+'<div class="licont">'+Jc+'</div>'
+'</div>';
TP.attr('data-id', Jid);
TP.html(listr);
}
function delLi(Thi){
  var TP=Thi.parents('li'),
  Tid=TP.attr('data-id');
  if(Tid){
  }else{
    layer.msg('敬告：获取不到ID')
  }
    TP.remove();
}
$(document).ready(function() {
//  alert($('li.for').lenght)
  if($('li.for').lenght<1){addLi();}
});
</script>
<style type="text/css">
.btn{ color: #FFF; }
.btn-default{ color: #666; }
html{ overflow: visible; }
.bodys{ margin-top: 0; }
.bodyer{padding: 100px 0 50px;}
a.header_logo{color: #679ECA;}
a.header_logo i{ font-size: 70px;}
a.header_logo span{ padding-left: 10px; display: inline-block; height:36px; line-height: 36px; vertical-align: text-bottom; }
.navbar-toggle .icon-bar{ background:#679ECA;  }
.bodys_text h1{ margin-bottom: 30px; }
.bodys_text .abtn{ display: inline-block; height: 36px; line-height: 36px; padding: 0 20px; background: #F0F0F0; border: 1px solid #DFDFDF; color: #333; border-radius: 2px; }
.bodys_text .abtn:hover{ background: #E0E0E0; border: 1px solid #D0D0D0;}
.bodys_text .abtn_blue{ background: #277DC1; border: 1px solid #277DC1; color: #FFF;}
.bodys_text .abtn_blue:hover{ background: #318AD1; border: 1px solid #277DC1; color: #FFF;}
.form-ul li{ margin-bottom: 30px;}
.form-ul .w1{ width: 10%; }
.form-ul .w2{ width: 23%; }
.form-ul .w3{ width: 35%; }
.form-ul .w6{ width: 50%; }
.form-section{ border-width: 0; border-bottom-width: 1px; }
.for{ position: relative; border: 1px solid #FFF; }
.for .icoBtnBox{ position: absolute; top: 2px; right: 0px; }
.for .icoBtnBox a { padding: 10px; display: inline-block;}
.for .icoBtna{ position: absolute; top: 6px; right: 10px; padding: 5px 10px; color: #FFF;}
.for:hover{}
.for:hover .icoBtn{ color: #666; }
.err{ border:1px solid #FF6100; }

.libox{ display: block; border: 1px solid #E6E6E6;}
.libox h2{ font-size: 16px; padding: 8px 10px 10px ; background: #F0F0F0; }
.libox .licont{ font-size: 14px; color: #666; padding: 10px;  }
.libox h2 input{border: none; padding-left: 10px; border-bottom: 1px solid #CCC; width: 90%;}
.libox .licont textarea{ border: none; height: 100%; width: 100%; }

.navbar-brand{ height: 58px; }
.navbar-collapse{ background: #F6F6F6; border-bottom:1px solid #999; box-shadow: 0 3px 2px rgba(0,0,0,0.2); }
.in .menu a{ margin-bottom: 0; }

@media screen and (max-width: 800px) {
.for .icoBtn{ right: 2px; color: #666; }
.bodys_text{ padding: 40px 40px 80px; }
.form-ul .w1,
.form-ul .w2,
.form-ul .w3,
.form-ul .w6{ width: 50%; }
}
@media screen and (max-width: 600px) {
.bodys_text{ padding: 20px 20px 40px; }
.form-ul .w1,
.form-ul .w2,
.form-ul .w3,
.form-ul .w6{ width: 100%; }
}

</style>
</head>

<body class="bank work add">
<nav class="header navbar navbar-default equinav equinav-collapse" role="navigation">
  <div class="navbar-header">
    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse">
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
    </button>
    <span class="navbar-brand">
      <a href="#" title="" class="header_logo"><i class="iconfont">&#xe687;</i><span>银行业务</span></a>
    </span>
  </div><!-- /.navbar-header -->
  <div class="navbar-collapse collapse" style="height: 1px;">
    <ul class="menu">
      <li class="menu-item"><a href="bank.html">申请列表</a></li>
      <li class="menu-item"><a href="#" class="checked">业务设置</a></li>
      <li class="menu-item"><a href="login.html" class="">退出</a></li>
    </ul>
  </div><!-- /.navbar-collapse -->
</nav>
<div class="header navbar navbar-default equinav equinav-collapse hidden">
  <div class="container-fluid">
    <div class="navbar-header">
      <button class="navbar-toggle collapsed" type="button" data-toggle="collapse" data-target=".header" aria-controls="header_navbar" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <div class="navbar-brand">
        <a href="#" title="" class="header_logo"><i class="iconfont">&#xe687;</i><span>银行</span></a>
      </div>
    </div>
    <nav class="collapse navbar-collapse navbar-right">
      <div class="">
        <ul class="menu">
          <li class="menu-item"><a href="bank.html">申请列表</a></li>
          <li class="menu-item"><a href="#" class="checked">业务设置</a></li>
        </ul>
      </div>
    </nav>
  </div>
</div>
<div class="bodyer">
  <div class="container bodys">
    <div class="row">
      <div class="bodys_text">
        <h1 class="h1">${user.name }</h1>
        
<form action="" class=" form1" data-id="1">
 
  <div class="form-box">
    <ul class="form-ul">
      <li class="w6"><label class="form-section form-active"><strong class="input-label">分行名称</strong><input type="text"  value="${bank.name }" class="input placeholder name" name="name" placeholder="分行名称" value=""><span class="tip"></span></label></li>
      <li class=""><label class="form-section form-active"><strong class="input-label">业务简介</strong><input type="text" value="${bank.biz }" class="input placeholder biz" name="biz" placeholder="业务简介" value=""><span class="tip"></span></label></li>
    	<c:forEach items="${labels }"  var="label">
		     <li class="for" data-id="${label.id }"><div class="icoBtnBox"><a href="#" class="icoBtn btn_act" data-type="editLi"><i class="iconfont"></i></a>
		     	<a href="#" class="icoBtn btn_act" label-id="${label.id }" data-type="delLi"><i class="iconfont"></i></a></div>
		     	<div class="libox"><h2>${label.title }</h2><div class="licont">${label.conts }</div></div>
		     </li>
     	</c:forEach>
    </ul>
    <a href="#" class="abtn btn_act" data-type="addLi">新增标签</a>
    <a href="#" class="abtn abtn_blue btn_act" data-type="submit">保存</a>
    <input type="submit" class="submit hidden" value="submit">
  </div>

</form>

      </div>
    </div>
  </div>
</div>
<div class="footer"></div>
</body>
</html>