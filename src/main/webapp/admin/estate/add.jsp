<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../header.jsp" />
<script type="text/javascript" src="../../js/city/jquery.cityselect.js"></script>
<script type="text/javascript" src="http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js"></script>
<script type="text/javascript">
$(function(){
	setTimeout(function(){
		initUploadHouseImage('shijing_upload' , 'shijing' , '${estateUUID}');
		initUploadHouseImage('huxing_upload' , 'huxing' , '${estateUUID}');
		initUploadHouseImage('tuijian_upload' , 'tuijian' , '${estateUUID}');
		initUploadHouseImage('main_upload' , 'main' , '${estateUUID}');
	},100);
	
	var myprovince = remote_ip_info['province'];
	var mycity = remote_ip_info['city']
	var mydistrict = remote_ip_info['district'];
	$("#city_1").citySelect({
		prov:myprovince, 
    	city:mycity,
    	dist: mydistrict
	});
});


function save(){
    if(checkNotnullInput()==false){
        infoAlert('您有必填项未填写！');
        return;
    }
    var a=$('form[name=form1]').serialize();
    YW.ajax({
        type: 'POST',
        url: '${projectName}/c/admin/estate/doSave',
        data:a,
        mysuccess: function(data){
            infoAlert('添加成功');
        }
    });
}

function changeQuYu(city){
    $('#quyu option').css('display','none');
    $('#quyu option[city='+city+']').css('display','block');
    var first = $('#quyu option[city='+city+']').first();
    if(first){
    	$('#quyu').val(first.text());
    }
}

</script>
</head>
<body>
<style type="text/css">
#city_1 select{height:25px;width:120px;margin-top: 5px;margin-bottom: 5px;}
.notNull{vertical-align: sub;display:inline-block;color:red;}
input{width:90%;}
</style>
<form name="form1" method="post" class="definewidth m20">
	<input type="hidden" name="uuid"  value="${estateUUID }"/>
	<input type="hidden" name="managerUid"  value="${me.id }"/>
<table class="table table-bordered table-hover m10">
	
    <tr>
        <td class="tableleft">楼盘名称<div class="notNull">*</div></td>
        <td style="width:26%"><input type="text" name="name" not-null="true"/></td>
        <td class="tableleft">参考均价</td>
        <td style="width:26%"><input type="text" name="junjia"/>元/平方</td>
        <td class="tableleft">联系电话 <div class="notNull">*</div></td>
        <td style="width:26%"><input type="text" name="tel"  not-null="true" /></td>
    </tr>
    <tr>
        <td class="tableleft">物业费</td>
        <td><input type="text" name="wyfee"/></td>
        <td class="tableleft">绿化率</td>
        <td><input type="text" name="lvhua" />%</td>
        <td class="tableleft">产权归属</td>
        <td><input type="text" name="guishu"/></td>
    </tr>
    <tr id="tr_conts" >
    	<td class="tableleft">开发商<div class="notNull">*</div></td>
        <td><input type="text" name="developer" not-null="true"/></td>
        <td class="tableleft">开盘时间<div class="notNull">*</div></td>
        <td><input type="text" class="form-control input-sm input-left"  not-null="true" name="opentime" id="opentime" onFocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy-MM-dd'})" ></td>
        <td class="tableleft">交房日期</td>
        <td><input type="text" class="form-control input-sm input-left" name="jiaofangDate" id="jiaofangDate" onFocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy-MM-dd'})" ></td>
    </tr>
    <tr>
        <td class="tableleft">生活配套</td>
        <td><textarea name="shenghuo" style="width:90%;height:100%"></textarea></td>
        <td class="tableleft">学区配套</td>
        <td><textarea name="xuequ" style="width:90%;height:100%"></textarea></td>
        <td class="tableleft">交通配套</td>
        <td><textarea name="jiaotong" style="width:90%;height:100%"></textarea></td>
    </tr>
    <tr>
    	<td class="tableleft">佣金<div class="notNull">*</div></td>
        <td ><input type="text" name="yongjin" not-null="true"/></td>
        <td class="tableleft">主力户型<div class="notNull">*</div></td>
        <td><input type="text" not-null="true" name="mainHuxing"/></td>
        <td class="tableleft">排序</td>
        <td><input type="text" name="orderx"/></td>
    </tr>
    <tr>
        <td class="tableleft">项目地址<div class="notNull">*</div></td>
        <td><input type="text" name="addr" not-null="true"/></td>
        <td class="tableleft">公摊</td>
        <td><input type="text" name="gongtan" />%</td>
        <td class="tableleft">推荐</td>
        <td><select name="tuijian">
            <option value="0">否</option>
            <option value="1">是</option>
        </select><span style="color:#aaa;">选择是必须上传推荐图片</span></td>
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
        <td class="tableleft">楼盘特色</td>
        <td><textarea name="tese" style="width:90%;height:100%"></textarea></td>
    </tr>
    <tr>
    
    </tr>
    <tr>
        <td class="tableleft">建筑类型</td>
        <td colspan="5">
            <c:forEach items="${lxings}" var="lxing">
              <input value="${lxing.value}" name="lxing" type="checkbox"/>${lxing.value}
            </c:forEach>
       </td>
    </tr>
    <tr>
        <td class="tableleft">物业类型</td>
        <td colspan="5">
             <c:forEach items="${wylxs}" var="wylx">
               <input value="${wylx.value}"  name="wylx" type="checkbox"/>${wylx.value}
             </c:forEach>
        </td>
    </tr>
    <tr>
        <td class="tableleft">主图片<em style="color:red">*</em></td>
        <td colspan="5"><input id="main_upload"  style="display:none;margin-top:5px;">
            <div id="main_img_container">
            </div>
        </td>
    </tr>
    <tr>
        <td class="tableleft">户型图</td>
        <td colspan="5"><input id="huxing_upload"  style="display:none;margin-top:5px;">
        	<div id="huxing_img_container">
        	</div>
        </td>
    </tr>
     <tr>
        <td class="tableleft">推荐图</td>
        <td colspan="5"><input id="tuijian_upload"  style="display:none;margin-top:5px;">
        	<div id="tuijian_img_container">
        	</div>
        </td>
    </tr>
    <tr>
        <td class="tableleft">实景图</td>
        <td colspan="5"><input id="shijing_upload"  style="display:none;margin-top:5px;">
        	<div id="shijing_img_container">
        	</div>
        </td>
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