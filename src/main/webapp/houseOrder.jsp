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
        url: '${projectName}/c/admin/order/listHouseData?sellerId=${seller.id}',
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
                    <div><a href="estateYongJin.jsp">楼盘佣金</a></div>
                    <div><a href="estateOrder.jsp">楼盘预约</a></div>
               		<div><a href="houseOrder.jsp" class="sel">房源预约</a></div>
               
               </div>
               
               <div class="userRight">
               
                    <div class="tit"><span>客户列表</span></div>
                    
                    <div class="con">
                    
                        <h2></h2>
                        
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <form class="form-inline definewidth m20" name="form1"  method="get" onsubmit="doSearch();return false;">
    <thead>
		  <tr>
		    <td align="center" valign="middle" bgcolor="#eeeeee" height="35">姓名</td>
		    <td align="center" valign="middle" bgcolor="#eeeeee" height="35">电话</td>
		    <td align="center" valign="middle" bgcolor="#eeeeee" height="35">楼盘</td>
		    <td align="center" valign="middle" bgcolor="#eeeeee" height="35">栋号</td>
		    <td align="center" valign="middle" bgcolor="#eeeeee" height="35">单元</td>
		    <td align="center" valign="middle" bgcolor="#eeeeee" height="35">房间号</td>
		    <td align="center" valign="middle" bgcolor="#eeeeee" height="35">预约时间</td>
		    <td align="center" valign="middle" bgcolor="#eeeeee" height="35">状态</td>
		    <td align="center" valign="middle" bgcolor="#eeeeee" height="35">操作</td>
		  </tr>
    </thead>
						  <tr style="display:none" class="buyer">
						    <td align="center" valign="middle" height="30">$[buyerName]</td>
						    <td align="center" valign="middle" height="30">$[buyerTel]</td>
						    <td align="center" valign="middle" height="30">$[estateName]</td>
						    <td align="center" valign="middle" height="30">$[dhao]</td>
						    <td align="center" valign="middle" height="30">$[unit]</td>
						    <td align="center" valign="middle" height="30">$[fhao]</td>
						    <td align="center" valign="middle" height="30">$[addtime]</td>
						    <td align="center" valign="middle" height="30">$[status]</td>
						    <td align="center" valign="middle" height="30">
						    	<a href="javascript:" show="'$[protect]'==0" onclick="openNewWin('bookroom','预约信息反馈','xxfk.jsp?orderId=$[id]');">查看</a>
						    </td>
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
<jsp:include page="foot.jsp"></jsp:include>

</body>
</html>
