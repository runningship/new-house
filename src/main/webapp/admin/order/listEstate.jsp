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
	    url: '${projectName}/c/admin/order/listEstateData',
	    data: a,
	    dataType:'json',
	    mysuccess: function(json){
	        buildHtmlWithJsonArray("repeat",json.page.data);
	        Page.setPageInfo(json.page);
	    }
	  });
}

function deleteOrder(id){
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
$(function () {
        var province_reg = remote_ip_info['province'];
        var city_reg = remote_ip_info['city']
        var district_reg = remote_ip_info['district'];
        $("#city_reg").citySelect({
            prov: province_reg, 
            required:false
        });
	Page.Init();
	$('#addnew').click(function(){
			window.location.href="add.jsp";
	 });
	doSearch();
});

function triggerAll(box){
	if(box.checked){
		$('.checkbox').each(function(){
			this.checked=true;
		});
	}else{
		$('.checkbox').each(function(){
			this.checked=false;
		});
	}
}

function deleteAll(){
	var ids= [];
	$('.checkbox').each(function(){
		if(this.checked){
			ids.push($(this).attr('orderId'));
		}
	});
	if(ids.length==0){
		alert('请先选择要删除的数据');
		return;	
	}
	art.dialog.confirm('删除后不可恢复，确定要删除吗？', function () {
	    YW.ajax({
	        type: 'POST',
	        url: '${projectName}/c/admin/order/deleteAll?ids='+ids.join(),
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
#city_reg select{height:22px;width:90px;}
#adminName select{height:30px;width:90px;}
#adminName label{height:30px;width:90px;}
</style>
</head>
<body>
<jsp:include page="../top.jsp"></jsp:include>
<form class="form-inline definewidth m20" name="form1"  method="get" onsubmit="return false;">
    客户姓名<input type="text" name="buyerName" style="width:100px;margin-right:10px;"/>
    客户电话<input type="text" name="buyerTel" style="width:120px;margin-right:10px;height:18px;"/>
    楼盘名称<input type="text" name="estateName" style="width:100px;margin-right:10px;height:18px;"/>
    经纪人电话<input type="text" name="sellerTel" style="width:100px;margin-right:10px;height:18px;"/>
               <div id="city_reg" style="display:inline-block;display: inline;">
<!--                        <span style="font-size:14px; width:50px;pading-right:20px;">区域 </span> -->
                    <select class="prov"  id="province_reg"  name="province"></select> 
                    <select class="city" name="city"></select>
                    <select class="dist"  name="quyu"></select>
                </div>
    <button type="button" class="btn btn-success btn_subnmit" onclick="doSearch();return false;">搜索</button>
</form>

<table class="table table-bordered table-hover definewidth m10">
    <thead>
    <tr>
    	<c:if test="${me.role eq '销售总监' }">
    	<th style="width:50px;">
    		<input type="checkbox" onclick="triggerAll(this)"/> <a href="#" onclick="deleteAll()">删除</a>
    	</th>
    	</c:if>
    	<th>编号</th>
    	<th>楼盘</th>
        <th>客户</th>
        <th style="width:120px;">客户电话</th>
        <th>经纪人</th>
        <th>经纪人电话</th>
        <th>预约时间</th>
        <th>状态</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    	<tr style="display:none" class="repeat">
    			<c:if test="${me.role eq '销售总监' }">
    			<td ><input orderId="$[id]" class="checkbox" type="checkbox" /></td>
    			</c:if>
    			<td>$[id]</td>
                <td>$[estateName]</td>
                <td>$[buyerName]</td>
                <td>$[buyerTel]</td>
                <td>$[sellerName]</td>
                <td>$[sellerTel]</td>
                <td>$[addtime]</td>
                <td>$[status]</td>
                <td>
                    <a href="#" onclick="addTab('edit_yy','查看预约','order/edit.jsp?id=$[id]')">查看</a>
                    <a href="#" onclick="deleteOrder($[id])">删除</a>
                </td>
            </tr>
    </tbody>
	</table>

	<div class="footer" style="margin-top:5px;margin-left:35px;">
        <div class="maxHW mainCont ymx_page foot_page_box"></div>
    </div>
</body>
</html>
