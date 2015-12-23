<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../header.jsp" />
<script type="text/javascript">

$(function(){
	setTimeout(function(){
		initUploadHouseImage('huxing_upload' , 'huxing' , '${estate.uuid}' ,'${huxing.uuid}');
	},100);
	getImgList('${estate.uuid}' ,'huxing' , '${huxing.uuid}');
});

function save(){
  if(checkNotnullInput()==false){
      return;
  }
    var a=$('form[name=form1]').serialize();
    YW.ajax({
        type: 'POST',
        url: '${projectName}/c/admin/huxing/update',
        data:a,
        mysuccess: function(data){
            alert('添加成功');
        }
    });
}

</script>
</head>
<body>
<form name="form1" method="post" class="definewidth m20">
<input type="hidden" name="estateId" id="estateId" value="${estateId}"/>
<table class="table table-bordered table-hover m10">
	
    <tr> 
        <td class="tableleft">户型</td>
        <td><input type="text" name="name"  value="${huxing.name }" not-null="true"></td>
    </tr>
    <tr>
        <td class="tableleft">图片</td>
        <td><input id="huxing_upload"  style="display:none;margin-top:5px;">
        	<div id="huxing_img_container">
        	</div>
        </td>
    </tr>
    <tr>
        <td class="tableleft"></td>
        <td>
            <button class="btn btn-primary" type="button" onclick="save();return false;">保存</button>
            <button class="btn btn-primary" type="button" onclick="window.location='list.jsp?estateId=${estate.id}'">返回</button>
        </td>
    </tr>
</table>
</form>
</body>
</html>