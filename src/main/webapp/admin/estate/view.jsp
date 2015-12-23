<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../header.jsp" />
<script type="text/javascript" src="../../js/city/jquery.cityselect.js"></script>
<script type="text/javascript" src="http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js"></script>
<script type="text/javascript">

$(function(){
	
	getImgList('${estate.uuid}' ,'main','' , true);
	getImgList('${estate.uuid}' ,'xiaoguo' ,'' ,true);
	getImgList('${estate.uuid}' ,'guihua' ,'' , true);
	getImgList('${estate.uuid}' ,'shijing','' , true);
	
	$('#tehui').val(${estate.tehui});
	$('#tuijian').val(${estate.tuijian});
	
	var myprovince = remote_ip_info['province'];
	var mycity = remote_ip_info['city']
	var mydistrict = remote_ip_info['district'];
	$("#city_1").citySelect({
		prov: '${estate.province}', 
    	city: '${estate.city}',
    	dist: '${estate.quyu}'
	});
});

function save(){
    if(checkNotnullInput()==false){
        infoAlert('请检查 楼盘名称、联系电话、楼盘地址是否未填！');
        return;
    }
    var a=$('form[name=form1]').serialize();
    YW.ajax({
        type: 'POST',
        url: '${projectName}/c/admin/estate/update',
        data:a,
        mysuccess: function(data){
            infoAlert('修改成功');
        }
    });
}

</script>
</head>
<body>
<style type="text/css">
#city_1 select{height:25px;width:120px;margin-top: 5px;margin-bottom: 5px;}
</style>
<form name="form1" method="post" class="definewidth m20">
	<input type="hidden" name="id"  value="${estate.id}"/>
<table class="table table-bordered table-hover m10">
	
    <tr>
        <td class="tableleft">楼盘名称</td>
        <td><input type="text" name="name" value="${estate.name }" not-null="true"/></td>
        <td class="tableleft">售楼部地址</td>
        <td><input type="text" name="shouloubu" value="${estate.shouloubu }" not-null="true"/></td>
        <td class="tableleft">联系电话</td>
        <td><input type="text" name="tel" value="${estate.tel }" style="width:90%;" not-null="true"/></td>
    </tr>
    <tr>
        <td class="tableleft">开发商</td>
        <td><input type="text" name="developer" value="${estate.developer }"/></td>
        <td class="tableleft">项目地址</td>
        <td><input type="text" name="addr" value="${estate.addr }" not-null="true"/></td>
        <td class="tableleft">公摊</td>
        <td><input type="text" name="gongtan" value="${estate.gongtan }" style="width:90%;"/>%</td>
    </tr>
    <tr><td class="tableleft">代理商</td>
        <td><input type="text" name="daili" value="${estate.daili }"/></td>
        <td class="tableleft">销售许可证</td>
        <td><input type="text" name="xukezheng" value="${estate.xukezheng }"/></td>
        <td class="tableleft">容积率</td>
        <td><input type="text" name="rongji" value="${estate.rongji }" style="width:90%;"/></td>
    </tr>
    <tr>
        <td class="tableleft">物业公司</td>
        <td><input type="text" name="wyComp" value="${estate.wyComp }"/></td>
        <td class="tableleft">物业费</td>
        <td><input type="text" name="wyfee" value="${estate.wyfee }"/></td>
        <td class="tableleft">绿化率</td>
        <td><input type="text" name="lvhua" value="${estate.lvhua }" style="width:90%;"/>%</td>
    </tr>
    <tr id="tr_conts" >
        <td class="tableleft">开盘时间</td>
        <td><input type="text" value="<fmt:formatDate value="${estate.opentime}" pattern="yyyy-MM-dd"/>" class="form-control input-sm input-left" name="opentime" id="opentime" onFocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy-MM-dd'})" ></td>
        <td class="tableleft">交房日期</td>
        <td><input value="<fmt:formatDate value="${estate.jiaofangDate}" pattern="yyyy-MM-dd"/>"  type="text" class="form-control input-sm input-left" name="jiaofangDate" id="jiaofangDate" onFocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy-MM-dd'})" ></td>
        <td class="tableleft">付款方式</td>
        <td><input type="text" name="fukuang" value="${estate.fukuang }"/></td>
    </tr>
    <tr>
        <td class="tableleft">产权归属</td>
        <td><input type="text" name="guishu" value="${estate.guishu }"/></td>
        <td class="tableleft">产权土地年限</td>
        <td><input type="text" name="chanquan" value="${estate.chanquan }"/></td>
        <td class="tableleft">公积金贷款</td>
        <td><input type="text" name="gongjijin" value="${estate.gongjijin }" placeholder="例如：市直公积金或省直公积金"/></td>
    </tr>
    <tr>
        <td class="tableleft">建筑面积</td>
        <td><input type="text" name="jzmj" value="${estate.jzmj }"/></td>
        <td class="tableleft">规划面积</td>
        <td><input type="text" name="ghmj" value="${estate.ghmj }"/></td>
        <td class="tableleft">装修</td>
        <td><select  class="sortSelect" name="zxiu">
                <option value="" >所有</option>
                <c:forEach items="${zxius}" var="zxiu">
                  <option <c:if test="${zxiu.value eq estate.zxiu }">selected="selected"</c:if> value="${zxiu.value}">${zxiu.value}</option>
                </c:forEach>
            </select></td>
    </tr>
    <tr>
        <td class="tableleft">规划户数</td>
        <td><input type="text" name="hushu" value="${estate.hushu }"/></td>
        <td class="tableleft">车位数</td>
        <td><input type="text" name="chewei" value="${estate.chewei }"/></td>
        <td class="tableleft">楼盘特色</td>
        <td><textarea name="tese" style="width:99%;height:100%">${estate.tese }</textarea></td>
    </tr>
    <tr>
        <td class="tableleft">参考均价</td>
        <td><input type="text" name="junjia" value="${estate.junjia }"/>元/平方</td>
        <td class="tableleft">特惠价</td>
        <td><input type="text" name="tejia" value="${estate.tejia }"></td>
        <td class="tableleft">优惠截止时间</td>
        <td colspan="5"><input value="<fmt:formatDate value="${estate.youhuiEndtime}" pattern="yyyy-MM-dd"/>"  type="text" class="form-control input-sm input-left" name="youhuiEndtime" id="youhuiEndtime" onFocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy-MM-dd'})" ></td>
    </tr>
    <tr>
        <td class="tableleft">推荐</td>
        <td><select name="tuijian" id="tuijian">
            <option value="0">否</option>
            <option value="1">是</option>
        </select></td>
        <td class="tableleft">特惠</td>
        <td><select name="tehui"  id="tehui">
            <option value="0">否</option>
            <option value="1">是</option>
        </select></td>
        <td class="tableleft">即将推出</td>
        <td><input type="text" name="jjtc" value="${estate.jjtc }" style="width:99%;" /></td>
    </tr>
    <tr>
        <td class="tableleft">经纬度</td>
        <td><input type="text" name="jingdu" placeholder="经度" value="${estate.jingdu }" style="width:45%"/>  /  <input type="text" name="weidu" placeholder="纬度" value="${estate.weidu }" style="width:45%"/></td>
        
<!--         <td class="tableleft">优惠方案</td> -->
<%--         <td><input type="text" name="yufu" value="${estate.yufu }" style="width:45%"/>抵<input type="text" name="shidi" value="${estate.shidi }" style="width:45%"/></td> --%>
        
        <td class="tableleft">优惠方案</td>
		<td><input type="text" name="youhuiPlan" value="${estate.youhuiPlan }" /></td>
		
        <td class="tableleft">主力户型</td>
        <td><input type="text" name="mainHuxing" value="${estate.mainHuxing }"/></td>
    </tr>
    <tr>
        <td class="tableleft">区域</td>
        <td>
            <div id="city_1" style="display:inline-block;">
                <select class="prov"  id="province"  name="province"></select> 
                <select class="city" id="city" name="city"></select>
                <select class="dist" id="dist"  name="quyu"></select>
            </div>
        </td>
        <td class="tableleft">项目经理</td>
        <td><input type="text" name="manager" value="${estate.manager }" /></td>
        <td class="tableleft">排序</td>
        <td><input type="text" name="orderx" value="${estate.orderx }" /></td>
    </tr>
    <c:if test="${me.role eq '销售总监' }">
    <tr>
        <td class="tableleft">佣金</td>
        <td ><input type="text" name="yongjin" value="${estate.yongjin}"/></td>
    </tr>
    </c:if>
    <tr>
        <td class="tableleft">项目介绍</td>
        <td colspan="5"><textarea name="jieshao" style="width:99%;height:100%" >${estate.jieshao }</textarea></td>
    </tr>
    <tr>
        <td class="tableleft">建筑类型</td>
        <td colspan="5">
            <c:forEach items="${lxings}" var="lxing">
              <input <c:if test="${myLxings.contains(lxing.value)}">checked="checked"</c:if> value="${lxing.value}" name="lxing" type="checkbox"/>${lxing.value}
            </c:forEach>
       </td>
    </tr>
    <tr>
        <td class="tableleft">物业类型</td>
        <td colspan="5">
            <c:forEach items="${wylxs}" var="wylx">
               <input  <c:if test="${fn:contains(estate.wylx, wylx.value)}">checked="checked"</c:if> value="${wylx.value}"  name="wylx" type="checkbox"/>${wylx.value}
             </c:forEach>
            </td>
    </tr>
    <tr>
        <td class="tableleft">主图片<em style="color:red">*</em></td>
        <td colspan="5">
            <div id="main_img_container">
            </div>
        </td>
    </tr>
    <tr>
        <td class="tableleft">规划图</td>
        <td colspan="5">
        	<div id="guihua_img_container">
        	</div>
        </td>
    </tr>
     <tr>
        <td class="tableleft">效果图</td>
        <td colspan="5">
        	<div id="xiaoguo_img_container">
        	</div>
        </td>
    </tr>
    <tr>
        <td class="tableleft">实景图</td>
        <td colspan="5">
        	<div id="shijing_img_container">
        	</div>
        </td>
    </tr>
    <tr>
        <td class="tableleft"></td>
        <td>
            <button class="btn btn-primary" type="button" onclick="window.location='list.jsp'">返回</button>
        </td>
    </tr>
</table>
</form>
</body>
</html>