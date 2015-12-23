<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../header.jsp" />
<script type="text/javascript">
var estateId;
function doSearch(){
	var a=$('form[name=form1]').serialize();
	YW.ajax({
	    type: 'get',
	    url: '${projectName}/c/admin/huxing/listData?estateId='+estateId,
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
		        url: '${projectName}/c/admin/huxing/delete?id='+id,
		        data:'',
		        mysuccess: function(data){
                    //doSearch();
		            alert('删除成功');
		            window.location.reload();
		        }
		      });
		  },function(){},'warning');
	}
	$(function () {
		Page.Init();
		$('#addnew').click(function(){
				window.location.href="add.jsp";
		 });
	    estateId = getParam('estateId');
	    if (estateId!="") {
	        $('.Search').attr('style','display:none');
	    };
		doSearch();
	});
	
</script>
</head>
<body>
<jsp:include page="../top.jsp"></jsp:include>
<form class="form-inline definewidth m20" name="form1"  method="get" onsubmit="return false;">
    <a class="Search">楼盘名称：<input type="text" name="name"/>
    <button type="button" class="btn btn-success btn_subnmit" onclick="doSearch();return false;">搜索</button></a>
    <c:if test="${estateId!=null}"><button type="button"  onclick="window.location.href='add.jsp?estateId=${estateId}'" class="btn btn-success ">添加户型</button></c:if>
</form>

<table class="table table-bordered table-hover definewidth m10">
    <thead>
    <tr>
    	<th>编号</th>
        <th>名称</th>
        <th>所属楼盘</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    	<tr style="display:none" class="repeat">
    			<td>$[id]</td>
                <td>$[name]</td>
                <td>$[estateName]</td>
                <td>
                	<c:if test="${me.role eq '销售总监' }">
                    <a href="edit.jsp?id=$[id]">编辑</a>
                    <a href="#" onclick="delPost($[id])">删除</a>
                    </c:if>
                </td>
            </tr>
    </tbody>
	</table>

	<div class="footer" style="margin-top:5px;margin-left:35px;">
        <div class="maxHW mainCont ymx_page foot_page_box"></div>
    </div>
</body>
</html>
