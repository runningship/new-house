<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="${projectName}/Css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="${projectName}/Css/bootstrap-responsive.css" />
    <link rel="stylesheet" type="text/css" href="${projectName}/Css/style.css" />
    <script type="text/javascript" src="${projectName}/js/jquery.js"></script>
    <script type="text/javascript" src="${projectName}/js/bootstrap.js"></script>
    
	<script type="text/javascript" src="${projectName}/js/artDialog/jquery.artDialog.source.js?skin=default"></script>
	<script type="text/javascript" src="${projectName}/js/artDialog/plugins/iframeTools.source.js"></script>
	<script type="text/javascript" src="${projectName}/js/buildHtml.js"></script>
    
    <script type="text/javascript" src="../../js/city/jquery.cityselect.js"></script>
	<script type="text/javascript" src="http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js"></script>
<script type="text/javascript">
function getCityInfo(){
	var a=$('form[name=form1]').serialize();
	YW.ajax({
	    type: 'post',
	    url: '${projectName}/c/admin/city/get?',
	    data:a,
	    dataType:'json',
	    mysuccess: function(json){
	    	if(json.city){
	    		$('#jingdu').val(json.city.jingdu);
	    		$('#weidu').val(json.city.weidu);
	    	}else{
	    		$('#jingdu').val('');
	    		$('#weidu').val('');
	    	}
	    }
	  });
}

function save(){
	var a=$('form[name=form1]').serialize();
	YW.ajax({
	    type: 'post',
	    url: '${projectName}/c/admin/city/saveOrUpdate?',
	   	data:a,
	    dataType:'json',
	    mysuccess: function(json){
	    	alert('修改成功');
	    }
	  });
}

$(function () {
	var myprovince = remote_ip_info['province'];
	var mycity = remote_ip_info['city']
	var mydistrict = remote_ip_info['district'];
	$("#city_1").citySelect({
		prov:myprovince, 
    	city:mycity,
    	dist: mydistrict,
    	cityChange:getCityInfo,
    	initCallback:getCityInfo
	});
});
</script>
</head>
<body>
<jsp:include page="../top.jsp"></jsp:include>
<form name="form1">
<table class="table table-bordered table-hover definewidth m10">
   	<tr >
   	<td class="tableleft">城市</td>
		<td>
			<div id="city_1" style="display:inline-block;">
		  		<select class="prov"  id="province"  name="province"></select> 
		    	<select class="city" id="city" name="name"></select>
		    </div>
		</td>
    </tr>
    <tr>
        <td class="tableleft">经度</td>
        <td><input type="text" id="jingdu" name="jingdu"  value="${city.jingdu }" not-null="true"/></td>
    </tr>
    <tr>
        <td class="tableleft">纬度</td>
        <td><input type="text" id="weidu" name="weidu"  value="${city.weidu }" not-null="true"/></td>
    </tr>
    <tr>
        <td class="tableleft"></td>
        <td>
        	<c:if test="${me.role eq '销售总监' }">
            <button class="btn btn-primary" type="button" onclick="save();return false;">保存</button>
            </c:if>
        </td>
    </tr>
</table>
</form>
</body>
</html>
