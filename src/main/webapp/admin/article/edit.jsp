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
    
     <script type="text/javascript" charset="utf-8" src="${projectName}/js/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${projectName}/js/ueditor1_4_3/ueditor.all.js"> </script>
<script type="text/javascript" charset="utf-8" src="${projectName}/js/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
    <script type="text/javascript" src="../../js/city/jquery.cityselect.js"></script>
	<script type="text/javascript" src="http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js"></script>
<script type="text/javascript">

function save(){
	var a=$('form[name=form1]').serialize();
	YW.ajax({
	    type: 'post',
	    url: '${projectName}/c/admin/article/update',
	   	data:a,
	    dataType:'json',
	    mysuccess: function(json){
	    	alert('修改成功');
	    }
	  });
}

$(function(){
	var ue = UE.getEditor('editor');
	ue.addListener( 'ready', function( editor ) {
		ue.setContent('${conts}');
 	 });
});
</script>
</head>
<body>
<jsp:include page="../top.jsp"></jsp:include>
<form name="form1">
<input name="pageName" value="${pageName }" type="hidden" />
<table class="table table-bordered table-hover definewidth m10">
    <tr>
        <td class="tableleft">正文</td>
        <td>
        	<span id="editor" type="text/plain" name="conts"  style="width:99%;height:600px;"></span>
        </td>
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
