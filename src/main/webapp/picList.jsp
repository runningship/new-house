<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<jsp:include page="header.jsp" />
<link rel="stylesheet" type="text/css" href="style/piclist.css" />
<script type="text/javascript">
function filterImg(type,obj){
  $('.current').attr('class','tabs-item');
  $(obj).attr('class','tabs-item current');
	$('#keyFilterList li').hide();
	$('li[key="'+type+'"]').show();
  if (type=='all') {
    $('#keyFilterList li').show();
  };
}

function showImg(obj){
  var url = $(obj).attr('src');
  $('#bigImg').attr('src',url);
  var left = ($(document).width()-$('#bigImg').width())/2 ;
  var height = $(document).scrollTop()-(window.screen.height)/8 ;
  $('#bigImg').attr('style','position: absolute;z-index:999;margin-top:'+height+'px;left:'+left+'px;width:50%;');
  var a=0;
}

$(function () {
  var type = getParam('type');
  filterImg(type,$('#'+type+''));
});

</script>
</head>

<body>
<jsp:include page="top.jsp"></jsp:include>
<jsp:include page="nav.jsp"></jsp:include>

<div class="warp">

     <div class="main">
          
          
          
          
          <div class="section-inner house-photo-list">
  <!-- 楼盘单页公共头部 -->
  <div class="section-hd">
    <!-- 面包屑 -->
<div class="breadcrumbs-wrap">
    <div class="breadcrumb">
        <a href="index.jsp">房金宝</a>
        <span class="arrow">&gt;</span>
        <a href="info.jsp?estateId=${estate.id }">${estate.name }</a>

                <span class="arrow">&gt;</span>
        <a href="#">相册列表</a>
        
        <span></span>
    </div>
</div>
<!-- /面包屑 -->
    <!-- 标题 -->
<div class="house-title clearfix">
  <h1 class="house-name">
    <a href="info.jsp?estateId=${estate.id }"><em>[${estate.quyu }]</em>
    ${estate.name }</a>
    <small>&nbsp;&nbsp;/&nbsp;
    参考均价<em>${estate.junjia }</em>元/平米
    </small></h1>
  
</div>
<!-- /标题 -->

  </div>
  <!-- /楼盘单页公共头部 -->

  <div class="section-bd">

    <div class="content">
      
      <div id="keyFilterTabs" class="tabs">
        <a tabkey="all" id="all" href="#" onclick="filterImg('all',this);" class="tabs-item current">所有图片(${all })</a><span class="sep">|</span>
      <c:forEach items="${fenleiList}" var="fenlei">
            <c:choose>
              <c:when test="${fenlei.name==\"huxing\" }">
              <a tabkey="${fenlei.name}" id="${fenlei.name}" onclick="filterImg('${fenlei.name}',this);" href="#" class="tabs-item ">户型图(${fenlei.total})</a><span class="sep">|</span>
              </c:when>
              <c:when test="${fenlei.name==\"xiaoguo\" }">
              <a tabkey="${fenlei.name}" id="${fenlei.name}" onclick="filterImg('${fenlei.name}',this);" href="#" class="tabs-item ">效果图(${fenlei.total})</a><span class="sep">|</span>
              </c:when>
              <c:when test="${fenlei.name==\"guihua\" }">
              <a tabkey="${fenlei.name}" id="${fenlei.name}" onclick="filterImg('${fenlei.name}',this);" href="#" class="tabs-item ">规划图(${fenlei.total})</a><span class="sep">|</span>
              </c:when>
              <c:when test="${fenlei.name==\"shijing\" }">
              <a tabkey="${fenlei.name}" id="${fenlei.name}" onclick="filterImg('${fenlei.name}',this);" href="#" class="tabs-item ">实景图(${fenlei.total})</a><span class="sep">|</span>
              </c:when>
            </c:choose>
        </c:forEach>
      </div>

            <img src="#" onclick="$('#bigImg').attr('style','display:none;width:50%');" id="bigImg" style="display:none;width:50%"/>
      <div class="photo-list-wrap">
        <ul id="keyFilterList" class="photo-list">
          <c:forEach items="${images}" var="image">
          <li key="${image.type}" class="list-item">
            <img alt="" onclick="showImg(this);return false;" src="${upload_path}/${image.path}">
            <c:choose>
              <c:when test="${image.type==\"main\" }">
                <p class="title">主图片</p>
              </c:when>
            	<c:when test="${image.type==\"huxing\" }">
            		<p class="title">户型图</p>
            	</c:when>
            	<c:when test="${image.type==\"xiaoguo\" }">
            		<p class="title">效果图</p>
            	</c:when>
              <c:when test="${image.type==\"guihua\" }">
                <p class="title">规划图</p>
              </c:when>
              <c:when test="${image.type==\"shijing\" }">
                <p class="title">实景图</p>
              </c:when>
            </c:choose>
          </li>
          </c:forEach>
        </ul>
      </div>
    </div>
  </div>
</div>
        
     
     </div>

</div>

<jsp:include page="foot.jsp"></jsp:include>


</body>
</html>
