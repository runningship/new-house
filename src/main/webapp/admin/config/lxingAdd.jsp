<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title></title>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="${projectName }/Css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="${projectName }/Css/bootstrap-responsive.css" />
    <link rel="stylesheet" type="text/css" href="${projectName }/Css/style.css" />
    <script type="text/javascript" src="${projectName }/js/jquery.js"></script>
    <script type="text/javascript" src="${projectName }/js/bootstrap.js"></script>
    <script type="text/javascript" src="${projectName }/js/artDialog/jquery.artDialog.source.js?skin=default"></script>
    <script type="text/javascript" src="${projectName }/js/artDialog/plugins/iframeTools.source.js"></script>
    <script type="text/javascript" src="${projectName }/js/buildHtml.js"></script>
    <script type="text/javascript" src="${projectName}/js/uploadify/jquery.uploadify.js"></script>
	<script type="text/javascript">
$(function(){
});

function save(){
    var a=$('form[name=form1]').serialize();
    YW.ajax({
        type: 'POST',
        url: '${projectName}/c/admin/config/doSave',
        data:a,
        mysuccess: function(data){
        	infoAlert('添加成功');
            window.location='lxingList.jsp';
        }
    });
}

</script>
</head>
<body>
<form name="form1" method="post" class="definewidth m20">
	<input type="hidden"  name="type" value="lxing"/>
<table class="table table-bordered table-hover m10">
    <tr>
        <td class="tableleft">名称</td>
        <td><input type="text" name="value"/></td>
    </tr>
    
     <tr>
        <td class="tableleft"></td>
        <td>
            <button class="btn btn-primary" type="button" onclick="save();return false;">保存</button>
        </td>
    </tr>
</table>
</form>
</body>
</html>