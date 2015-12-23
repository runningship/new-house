<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../header.jsp" />
<script type="text/javascript">
		
$(function(){
	$('#cxiang').val('${house.cxiang}');
});

function save(){
    if(checkNotnullInput()==false){
        return;
    }
    var a=$('form[name=form1]').serialize();
    YW.ajax({
        type: 'POST',
        url: '${projectName}/c/admin/house/update',
        data:a,
        mysuccess: function(data){
            alert('修改成功');
            setTimeout(function(){window.location='list.jsp?estateId=${estate.id}'},'1000');
        }
    });
}

function jisuan(){
    var mji = $('#mji').val();
    var djia = $('#djia').val();
    var yufu = $('#yufu').val();
    var shidi = $('#shidi').val();
    var zjia = 0;
    if (mji!=""&&djia!="") {
        zjia = Number.parseFloat(mji)*Number.parseInt(djia);
        if (yufu!=""&&shidi!="") {
            zjia = zjia-Number.parseInt(shidi)+Number.parseInt(yufu);
        };
    };
    $('#totalPrice').val(zjia);
}
</script>
</head>
<body>
<form name="form1" method="post" class="definewidth m20">
	<input type="hidden" name="id"  value="${house.id}"/>
<table class="table table-bordered table-hover m10">
	
    <tr>
        <td class="tableleft">楼栋</td>
        <td><input type="text" name="dhao" value="${house.dhao}"  not-null="true"/></td>
    </tr>
    <tr>
        <td class="tableleft">单元</td>
        <td><input type="text" name="unit" value="${house.unit}"  not-null="true"/></td>
    </tr>
    <tr>
        <td class="tableleft">房间号</td>
        <td><input  style="width:101px;" type="text" name="fhao" not-null="true" value="${house.fhao}"/></td>
    </tr>
    <tr>
        <td class="tableleft">面积</td>
        <td><input type="text" name="mji" id="mji" value="${house.mji}" /></td>
    </tr>
    <!-- <tr>
        <td class="tableleft">主图片</td>
        <td><input id="main_upload"  style="display:none;margin-top:5px;">
            <div id="main_img_container">
            </div>
        </td>
    </tr> -->
    <tr>
        <td class="tableleft">户型</td>
        <td>
            <select  class="sortSelect" name="hxing">
                <option value="" >所有</option>
                <c:forEach items="${hxings}" var="hxing">
                  <option <c:if test="${hxing.name eq house.hxing }">selected="selected"</c:if> value="${hxing.name}">${hxing.name}</option>
                </c:forEach>
            </select>
        </td>
    </tr>
    <tr>
        <td class="tableleft">朝向</td>
        <td>
            <select  class="sortSelect"  id="cxiang" name="cxiang">
                <option value="东" >东</option>
                <option value="西" >西</option>
                <option value="南" >南</option>
                <option value="北" >北</option>
            </select>
        </td>
    </tr>
    <tr>
        <td class="tableleft">单价</td>
        <td><input type="text" name="djia" id="djia" value="${house.djia}" />元/平方</td>
    </tr>
<!--     <tr> -->
<!--         <td class="tableleft">优惠方案</td> -->
<%--         <td><input type="text" name="yufu" id="yufu" value="${house.yufu}"  onblur="jisuan();"/>抵<input type="text" name="shidi" id="shidi" value="${house.shidi}"  onblur="jisuan();"/></td> --%>
<!--     </tr> -->
    <tr>
        <td class="tableleft">优惠方案</td>
        <td><input type="text" name="youhuiPlan" /></td>
    </tr>
    <tr>
        <td class="tableleft">折后总价</td>
        <td><input type="text" name="totalPrice" id="totalPrice" value="${house.totalPrice}"/></td>
    </tr>
    <tr>
        <td class="tableleft">佣金</td>
        <td><input type="text" name="yongjin" value="${house.yongjin}" /></td>
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