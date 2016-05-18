<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../header.jsp" />
<script type="text/javascript" src="../../js/city/jquery.cityselect.js"></script>
<script type="text/javascript" src="http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js"></script>
<script type="text/javascript">
function doSearch(){
	var a=$('form[name=form1]').serialize();
	YW.ajax({
	    type: 'get',
	    url: '${projectName}/c/admin/bank/listAllOrder',
	    data: a,
	    dataType:'json',
	    mysuccess: function(json){
	        buildHtmlWithJsonArray("repeat",json.page.data);
	        Page.setPageInfo(json.page);
	    }
	  });
}
	function delPost(id){
		art.dialog.confirm('删除后不可恢复，确定要删除吗？', function () {
		    YW.ajax({
		        type: 'POST',
		        url: '${projectName}/c/admin/bank/deleteOrder?id='+id,
		        data:'',
		        mysuccess: function(data){
                    doSearch();
		            alert('删除成功');
		        }
		      });
		  },function(){},'warning');
	}
	
	//1 待确认，2已确认 3已忽略
	function getStatus(code){
		if(code==1){
			return '待确认';
		}else if(code==2){
			return '已确认';
		}else if(code==3){
			return '已忽略';
		}
	}
	
	$(function(){
		Page.Init();
		doSearch();
	});
</script>
<style type="text/css">
#city_wrap select{height:22px;width:90px;margin-top: 5px;margin-bottom: 5px;}
</style>
</head>
<body>
<jsp:include page="../top.jsp"></jsp:include>
<form class="form-inline definewidth m20" name="form1"  method="get" onsubmit="return false;">
    银行名称：<input style="height:18px;width:200px;margin-right:10px;" type="text" name="bankName"/>
    楼盘：<input style="height:18px;width:200px;margin-right:10px;" type="text" name="area"/>
    经纪人号码：<input style="height:18px;width:200px;margin-right:10px;" type="text" name="sellerTel"/>
    状态：<select name="status"><option value="">所有</option><option value="1">待确认</option><option value="2">已确认</option><option value="3">已忽略</option></select>
    <button type="button" class="btn btn-success btn_subnmit" onclick="doSearch();return false;">搜索</button>
</form>

<table class="table table-bordered table-hover definewidth m10">
    <thead>
    <tr>
    	<th >银行名称</th>
        <th >楼盘</th>
        <th style="width:60px">面积</th>
        <th style="width:60px;">总价</th>
        <th style="width:110px;">贷款金额</th>
        <th>经纪人公司</th>
        <th style="width:80px;">经纪人</th>
        <th style="width:100px;">经纪人手机号</th>
        <th style="width:60px;">状态</th>
        <th style="width:120px;">操作</th>
    </tr>
    </thead>
    <tbody>
    	<tr style="display:none" class="repeat">
                <td>$[bankName]</td>
                <td>$[area]</td>
                <td>$[mji]</td>
                <td >$[zjia]</td>
                <td>$[loan]</td>
                <td >$[comp]</td>
                <td >$[sellerName]</td>
                <td >$[sellerTel]</td>
                <td runscript="true">getStatus($[status])</td>
                <td>
                    <c:if test="${me.role eq '管理员' }"><a href="#" onclick="delPost($[id])">删除</a></c:if>
                </td>
            </tr>
    </tbody>
	</table>

	<div class="footer" style="margin-top:5px;margin-left:35px;">
        <div class="maxHW mainCont ymx_page foot_page_box"></div>
    </div>
</body>
</html>
