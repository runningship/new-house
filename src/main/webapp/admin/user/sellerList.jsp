<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head> 
<jsp:include page="../header.jsp" />
<script type="text/javascript" src="../../js/city/jquery.cityselect.js"></script>
<script type="text/javascript" src="http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js"></script>
<script type="text/javascript">
var Ids=[];
var ids=""; 
function doSearch(){
	var a=$('form[name=form1]').serialize();
	YW.ajax({
	    type: 'get',
	    url: '${projectName}/c/admin/user/listData?type=seller',
	    data: a,
	    dataType:'json',
	    mysuccess: function(json){
	        buildHtmlWithJsonArray("repeat",json.page.data);
	        Page.setPageInfo(json.page);
	    }
	  });
}

function saveJinJ(adminId){
    YW.ajax({
      type: 'POST',
      url: '${projectName}/c/admin/user/setAdminForSeller?sellerIds='+ids+'&adminId='+adminId,
      data:'',
      mysuccess: function(data){
        doSearch();
        alert('保存成功');
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

  function edi(id){
      art.dialog.open("${projectName}/admin/user/sellerEdit.jsp?id="+id,{
        id:'edit_seller',
        title:  '修改经纪人',
        width:  440,
        height: 400
      })
  }

function jiancha(a,id){
  if (a.checked) {
    Ids.push(id);
    if (Ids.length==15) {
      $('.all').prop('checked',true);
    };
  }else {
    $('.all').prop('checked',false);
    for(var i=0;i<Ids.length ;i++){
      if (Ids[i]==id) {
        Ids.splice(i,1);
      };
    }
  }
}

function SelectAll(a){
  if (a.checked) {
    $('.ids').prop('checked',true);
    $('.ids').each(function(i){ 
      if ($(this).val()!='$[id]') {
        Ids[i-1] = $(this).val(); 
      }
    })
  }else {
    $('.ids').prop('checked',false);
    Ids=[];
  }
}

  function openJinJ(){
    ids = Ids.toString();
    if (ids=="") {
      alert('请勾选所要修改的经纪人');
      return;
    };
    art.dialog.open("${projectName}/admin/user/adminChange.jsp",{
      id:'edit_admin',
      title:  '修改经纪服务人员',
      width:  200,
      height: 150,
    })
  }

	function toggleShenhe(id){
		YW.ajax({
	        type: 'POST',
	        url: '${projectName}/c/admin/user/toggleShenHe?id='+id,
	        data:'',
	        mysuccess: function(data){
	            alert('操作成功');
	            doSearch();
	        }
	      });
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
		doSearch();
	});
</script>
<style type="text/css">
#city_reg select{height:22px;width:90px;}
#adminName select{height:30px;width:90px;}
#adminName span{height:30px;width:90px;}
</style>
</head>
<body>
<form class="form-inline definewidth m20" name="form1"  method="get" onsubmit="return false;">
               <div id="city_reg" style="display:inline-block;display: inline;">
<!--                		<span style="font-size:14px; width:50px;pading-right:20px;">区域 </span> -->
			  		<select class="prov"  id="province_reg"  name="province"></select> 
			    	<select class="city" name="city"></select>
			    	<select class="dist"  name="quyu"></select>
		    	</div>
    	<c:if test="${me.role ne '市场专员' }">
		      <div style="display:inline-block;margin-left:20px;display: inline;" id="adminName">
		        <span>经纪专员</span>
		        <select style="height:22px;" name="adminId" >
		          <option value="">所有</option>
		        <c:forEach items="${admins}" var="admin">
		          <option <c:if test="${admin.account==seller.adminName}"> select="selected" </c:if> value="${admin.id}"> ${admin.account}</option>
		        </c:forEach>
		        </select>
		      </div>
      </c:if>
      公司名称<input type="text" name="compName" style="width:150px;margin-right:10px;height:18px;" />
     门店名称<input type="text" name="deptName" style="width:150px;margin-right:10px;height:18px;"/>
    <button type="button" class="btn btn-success btn_subnmit" onclick="doSearch();return false;">搜索</button>
    <c:if test="${me.role ne '市场专员' }">
	  <button type="button" class="btn btn-success jinji" onclick="openJinJ();return false;">修改经纪专员</button>
	  </c:if>
    <div>共有公司${compCount }家，门店${deptCount }家</div>
</form>

<table class="table table-bordered table-hover definewidth m10">
    <thead>
    <tr>
      <th style="width:50px;color:blue"><input type="checkbox" class="all" onclick="SelectAll(this)">全选</th>
    	<th style="width:60px;">经纪人ID</th>
        <th style="width:100px;">电话号码</th>
        <th style="width:80px;">真实姓名</th>
        <th style="width:50px;">城市</th>
        <th style="width:60px;">区域</th>
        <th >所属公司</th>
        <th >所属门店</th>
        <th style="width:55px;">经纪专员</th>
        <th style="width:50px;">状态</th>
        <th style="width:70px;">操作</th>
    </tr>
    </thead>
    <tbody>
    	<tr style="display:none" class="repeat">
          <td><input type="checkbox" class="ids" name="ids" onclick="jiancha(this,$[id])" value="$[id]"></td>
                <td>$[id]</td>
                <td>$[tel]</td>
                <td>$[name]</td>
                <td>$[city]</td>
                <td>$[quyu]</td>
                <td>$[compName]</td>
                <td>$[deptName]</td>
                <td>
                	<d href="#" show="$[valid]==1">$[adminName]</d>
<!--                 	<d href="#" show="$[valid]==0">未分配</d> -->
                </td>
                <td>
                	<c:if test="${me.role eq '销售总监' }">
                	<a href="#"  show="$[valid]==1" onclick="toggleShenhe($[id])">已审核</a>
                	<a href="#"  show="$[valid]==0" onclick="toggleShenhe($[id])">未审核</a>
                	</c:if>
                	<c:if test="${me.role eq '市场专员' }">
                	<span show="$[valid]==1" >已审核</span>
                	<span show="$[valid]==0">未审核</span>
                	</c:if>
                </td>
                
               	
                	<td>
                	<a href="#" onclick="edi($[id]);">编辑</a>
                	<c:if test="${me.role eq '销售总监' }">
                    <a href="#" onclick="del($[id])">删除</a>
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
