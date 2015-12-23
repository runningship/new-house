<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="header.jsp" />
<script type="text/javascript" src="js/pagination.js"></script>
<link rel="stylesheet" type="text/css" href="style/user.css" />

</head>

<body>

<jsp:include page="top.jsp"></jsp:include>
<jsp:include page="nav.jsp"></jsp:include>
<script type="text/javascript">
function doSearch(){
    var a=$('form[name=form1]').serialize();
    YW.ajax({
        type: 'get',
        url: '${projectName}/c/admin/estate/listData?sellerId=${seller.id}',
        data: a,
        dataType:'json',
        mysuccess: function(json){
            buildHtmlWithJsonArray("buyer",json.page.data);
            Page.setPageInfo(json.page);
        }
      });
}

$(function () {
    Page.Init();
    doSearch();
});

function delOrder(id){
	art.dialog.confirm('删除后不可恢复，确定要删除吗？', function () {
	    YW.ajax({
	        type: 'POST',
	        url: '${projectName}/c/admin/order/delete?id='+id,
	        data:'',
	        mysuccess: function(data){
                doSearch();
	            alert('删除成功');
	        }
	      });
	  },function(){},'warning');
}

function order_success(){
	var info = $('#success_info');
	var left = ($(document).width()-info.width())/2 +50;
    var height = $(document).scrollTop()+(window.screen.height-info.height())/2 -150;
	info.css({top:height,left:left});
	info.css('display','');
	
	setTimeout(function(){
		info.css('display','none');	
	},2000);
	//alert(11);
}

</script>
<style type="text/css">
  .btn-default{padding:5px;margin:0;height: 25px;}
</style>
<div class="warp">

     <div class="main">
     
          <div class="user">
               <div class="userLeft">
                    
                    <h2>${seller.name }</h2>
                    
                    
                    <div><a href="sellerIndex.jsp">个人资料</a></div>
                    <div><a href="estateYongJin.jsp" class="sel">楼盘佣金</a></div>
                    <div><a href="estateOrder.jsp">楼盘预约</a></div>
               		<div><a href="houseOrder.jsp">房源预约</a></div>
               
               </div>
               
               <div class="userRight">
               
                    <div class="tit"><span>楼盘佣金</span></div>
                    
                    <div class="con">
                    
                        <h2></h2>
                        
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <form class="form-inline definewidth m20" name="form1"  method="get" onsubmit="doSearch();return false;">
    <thead>
		  <tr>
		  	<td align="center" valign="middle" bgcolor="#eeeeee" height="35">城市</td>
		    <td align="center" valign="middle" bgcolor="#eeeeee" height="35">区域</td>
		    <td align="left" valign="middle" bgcolor="#eeeeee" height="35">项目推荐</td>
		    <td align="left" valign="middle" bgcolor="#eeeeee" height="35">项目地址</td>
		    <td align="center" valign="middle" bgcolor="#eeeeee" height="35">佣金</td>
		  </tr>
    </thead>
						  <tr style="display:none" class="buyer">
						  	<td align="center" valign="middle" height="30">$[city]</td>
						    <td align="center" valign="middle" height="30">$[quyu]</td>
						    <td align="left" valign="middle" height="30"><a href="javascript:void(0)" onclick="openNewWin('estate_order', '预约看房 ','yykf.jsp?estateId=$[id]', '400px');">$[name]</a></td>
						    <td align="left" valign="middle" height="30">$[addr]</td>
						    <td align="center" valign="middle" height="30">$[yongjin]</td>
						  </tr>
						</table>

                 </div>
                    
  				<div class="footer" style="margin-top:5px;margin-left:35px;">
        			<div class="maxHW mainCont ymx_page foot_page_box"></div>
               
               </div>
               
          </div>
          
     </div>

</div>
</div>
<img id="success_info" src="images/success_info.png" style="display:none;position:absolute;border:1px solid #999"/>
<jsp:include page="foot.jsp"></jsp:include>

</body>
</html>
