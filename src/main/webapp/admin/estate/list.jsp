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
	    url: '${projectName}/c/admin/estate/listData',
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
		        url: '${projectName}/c/admin/estate/delete?id='+id,
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
        $("#city_wrap").citySelect({
            prov: province_reg, 
            required:false
        });
		Page.Init();
		$('#addnew').click(function(){
				window.location.href="add.jsp";
		 });
		doSearch();
	});
	
	function getStatus(status){
		if(status==0){
			return '在售';
		}else if(status==1){
			return '售罄';
		}else if(status==2){
			return '下线';
		}
		return '';
	}
</script>
<style type="text/css">
#city_wrap select{height:22px;width:90px;margin-top: 5px;margin-bottom: 5px;}
</style>
</head>
<body>
<jsp:include page="../top.jsp"></jsp:include>
<form class="form-inline definewidth m20" name="form1"  method="get" onsubmit="return false;">
					<c:if test="${me.role ne '管理员' }"><input type="hidden" name="managerUid" value="${me.id }"/></c:if>
    楼盘名称：<input style="height:18px;width:200px;margin-right:10px;" type="text" name="name"/>
               <div id="city_wrap" style="display:inline-block;display: inline;">
<!--                        <span style="font-size:14px; width:50px;pading-right:20px;">区域 </span> -->
                    <select class="prov"  id="province"  name="province"></select> 
                    <select class="city"  id="city" name="city"></select>
                    <select class="dist"  id="quyu" name="quyu"></select>
                </div>
    <button type="button" class="btn btn-success btn_subnmit" onclick="doSearch();return false;">搜索</button>
</form>

<table class="table table-bordered table-hover definewidth m10">
    <thead>
    <tr>
        <th style="width:30px">序号</th>
    	<th style="width:60px">城市</th>
        <th style="width:60px;">区域</th>
        <th>名称</th>
        <th style="width:60px;">状态</th>
        <th style="width:110px;">建筑类型</th>
        <th>项目地址</th>
        <th style="width:60px;">均价</th>
        <th style="width:60px;">结佣次数</th>
        <th style="width:60px;">总佣金</th>
        <th style="width:120px;">操作</th>
    </tr>
    </thead>
    <tbody>
    	<tr style="display:none" class="repeat">
                <td>$[orderx]</td>
                <td>$[city]</td>
                <td>$[quyu]</td>
                <td>$[name]</td>
                <td runscript="true">getStatus($[status])</td>
                <td >$[lxing]</td>
                <td>$[addr]</td>
                <td >$[junjia]</td>
                <td >$[jieyongCount]</td>
                <td >$[yongjinTotal]元</td>
                <td>
<!--                     <a onclick="addTab('huxing_list','户型','huxing/list.jsp?estateId=$[id]')" href="#">户型</a> -->
                    <a href="edit.jsp?id=$[id]">编辑</a>
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
