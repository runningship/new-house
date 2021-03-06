<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../header.jsp" />
<script type="text/javascript">
function doSearch(){
	var a=$('form[name=form1]').serialize();
	YW.ajax({
	    type: 'get',
	    url: '${projectName}/c/admin/user/listData?type=admin',
	    data: a,
	    dataType:'json',
	    mysuccess: function(json){
	        buildHtmlWithJsonArray("repeat",json.page.data);
	        Page.setPageInfo(json.page);
	    }
	  });
}
	function del(id){
		art.dialog.confirm('删除后不可恢复，确定要删除吗？', function () {
		    YW.ajax({
		        type: 'POST',
		        url: '${projectName}/c/admin/user/delete?id='+id,
		        data:'',
		        mysuccess: function(data){
                    doSearch();
		            alert('删除成功');
		        }
		      });
		  },function(){},'warning');
	}

	$(function () {
		Page.Init();
		doSearch();
	});
	
	function setUserValidation(a,id){
		YW.ajax({
	        type: 'POST',
	        url: '${projectName}/c/admin/user/toggleUserValidation?id='+id,
	        data:'',
	        mysuccess: function(data){
	        	if(data.valid){
	        		$(a).text('审').css('color', '#0088cc');
	        	}else{
	        		$(a).text('未').css('color', 'red');
	        	}
	        }
	   });
	}

function getValidationText(valid){
	if(valid){
		return "审";
	}else{
		return "未";
	}
}
</script>
<style type="text/css">
.valid_0{color:red}
</style>
</head>
<body>
<form class="form-inline definewidth m20" name="form1"  method="get" onsubmit="return false;">
    	<button onclick="window.location.href='adminAdd.jsp'" type="button"  class="btn btn-success ">添加</button>
</form>

<table class="table table-bordered table-hover definewidth m10">
    <thead>
    <tr>
    	<th>姓名</th>
        <th>手机号码</th>
        <th>职位</th>
        <th>固定号码</th>
        <th>邮箱</th>
        <c:if test="${me.role eq '管理员' }">
        <th>操作</th>
        </c:if>
    </tr>
    </thead>
    <tbody>
    	<tr style="display:none" class="repeat">
    			<td>$[name]</td>
    			<td>$[tel]</td>
                <td>$[role]</td>
                <td>$[landlineTel]</td>
                <td>$[email]</td>
                <c:if test="${me.role eq '管理员' }">
                <td>
                    <a href="adminEdit.jsp?id=$[id]">编辑</a>
                    <a class="valid_$[valid]" href="javascript:void(0)" onclick="setUserValidation(this,$[id]);" runscript="true">getValidationText($[valid])</a>
                    <a href="#" onclick="del($[id])">删除</a>
                </td>
                </c:if>
            </tr>
    </tbody>
	</table>

	<div class="footer" style="margin-top:5px;margin-left:35px;">
        <div class="maxHW mainCont ymx_page foot_page_box"></div>
    </div>
</body>
</html>
