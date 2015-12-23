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
	    url: '${projectName}/c/admin/house/listData?estateId=${estateId}',
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
	        url: '${projectName}/c/admin/house/delete?id='+id,
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

</script>
</head>
<body>
<form class="form-inline definewidth m20" name="form1"  method="get" onsubmit="return false;">
    <button type="button" style="display:none" class="btn btn-success btn_subnmit" onclick="doSearch();return false;">搜索</button>
    <button type="button"  onclick="addTab('house_add','添加房源','house/add.jsp?estateId=${estateId}')" class="btn btn-success ">添加房源</button>
</form>

<table class="table table-bordered table-hover definewidth m10">
    <thead>
    <tr>
        <th>楼栋</th>
        <th>单元</th>
    	<th>房间号</th>
        <th>面积</th>
        <th>房型</th>
        <th>朝向</th>
        <th>单价</th>
        <th>折扣</th>
        <th>折扣后总价</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    	<tr style="display:none" class="repeat">
    			<td>$[dhao]</td>
                <td>$[unit]</td>
                <td>$[fhao]</td>
                <td>$[mji]</td>
                <td>$[hxing]</td>
                <td>$[cxiang]</td>
                <td>$[djia]</td>
                <td>$[yufu]抵$[shidi]</td>
                <td>$[totalPrice]</td>
                <td><a href="edit.jsp?id=$[id]">编辑</a>
                    <a href="#" onclick="delPost($[id])">删除</a>
                </td>
            </tr>
    </tbody>
	</table>

	<div class="footer" style="margin-top:5px;margin-left:35px;">
        <div class="maxHW mainCont ymx_page foot_page_box"></div>
    </div>
</body>
</html>
