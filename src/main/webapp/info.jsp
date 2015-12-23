<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <script type="text/javascript" src="${projectName}/js/pagination.js"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=27b3c4a5846aeb5fed6a7a0b71731ba2"></script>
<jsp:include page="header.jsp" />
</head>
<body onload="zdyLayer(),showN('公交')">
<img id="view_big_pic" onclick="hiddenPic()" style="display:none;position:absolute;z-index:9999;width:600px;height:400px;" />
<jsp:include page="top.jsp"></jsp:include>
<jsp:include page="nav.jsp"></jsp:include>
<script type="text/javascript">
function doSearch(){
    var a=$('form[name=form1]').serialize();
    YW.ajax({
        type: 'get',
        url: '${projectName}/c/admin/house/listData?estateId=${estate.id}',
        data: a,
        dataType:'json',
        mysuccess: function(json){
            buildHtmlWithJsonArray("repeat",json.page.data);
            Page.setPageInfo(json.page);
        }
      });
}

$(function () {
    Page.Init();
    doSearch();
});

function showPic(pic){
	var x,y;
	x = event.clientX;
	y = event.clientY;
	var xx = $('#view_big_pic');
	xx.attr('src','${upload_path}'+$(pic).attr('src'));
	xx.css('display','block');
	xx.css('top',y);
	xx.css('left',x);
}
function hiddenPic(){
	$('#view_big_pic').css('display','none');
}

function order_success(){
	var info = $('#success_info');
	var left = ($(document).width()-info.width())/2 ;
    var height = $(document).scrollTop()+(window.screen.height-info.height())/2 ;
	info.css({top:height,left:left});
	info.css('display','');
	
	setTimeout(function(){
		info.css('display','none');	
	},2000);
	//alert(11);
}
</script>

<div class="warp">

     <div class="main">
          
          
          <div class="fl main-info">
                                <div class="clearfix">
                    <!-- 楼盘描述 -->
                    <div class="photos-info">
                        <div class="photos-text">
                            <h1>[${estate.quyu}]  ${estate.name }</h1>
                            <h2>
                                ${estate.tese }
                            </h2>
                            <div class="bd">

                                <p class="price"><span>平均价格：</span><em>${estate.junjia }</em>元/平米 
                                	<c:if test="${estate.yufu != null && estate.shidi !=null}"></c:if>
                                </p>
                                <p class="yh_price">
                                	<c:if test="${estate.youhuiPlan != null}"><span>独家优惠：</span><em>${estate.youhuiPlan}</em></c:if>
<%--                                 	<em>${estate.yufu}</em><span>享</span><em>${estate.shidi }</em> --%>
                                </p>
                                <p style="margin-bottom:23px;color:grey;font-size:15px;"><em style="color:red;font-size:22px;"></em><img src="images/tel_400.jpg" /></p>
                                
                                <a class="btn-main " onclick="openNewWin('estate_order', '预约看房 ','yykf.jsp?estateId=${estate.id}', '400px');" id="booking" href="javascript:;">预约看房</a>

                                <a class="btn-sub  " href="#online-choose-room">在线选房 (${leftCount})</a>



                                <p class="tips-info">
                                    (在线剩余${leftCount}套 <c:if test="${minTotalPrice !=null}">，总价${minTotalPrice}起</c:if>)
                                </p>

                             </div>
                         </div>
                    </div>
                    <!-- /楼盘描述 -->

                    <!-- 相册 -->
                    <div class="photos">
                                                <a class="pic" target="_blank" href="picList.jsp?estateId=${estate.id }&type=all">
                            <img style="width:100%;height:100%" alt="楼盘图片" src="${upload_path}/${main_img }">
                        </a>
                                                <!-- 列表分页 -->
                        <div role="thumb" class="thumb">
                            <c:if test="${huxing_img !=null }">
                            <a role="thumbItem" class="thumb-item  " href="picList.jsp?estateId=${estate.id }&type=huxing">
                                <img alt="" src="${upload_path}/${huxing_img }">
                                <p class="cover-layer">户型图</p>
                                <span class="photo-frame"></span>
                            </a>
                            </c:if>
                            <c:if test="${xiaoguo_img !=null}">
	                            <a role="thumbItem" class="thumb-item  " href="picList.jsp?estateId=${estate.id }&type=xiaoguo">
	                                <img alt="" src="${upload_path}/${xiaoguo_img }">
	                                <p class="cover-layer">效果图</p>
	                                <span class="photo-frame"></span>
	                            </a>
                            </c:if>
                            
                            <c:if test="${shijing_img !=null}">
                            	<a role="thumbItem" class="thumb-item  " href="picList.jsp?estateId=${estate.id }&type=shijing">
	                                <img alt="" src="${upload_path}/${shijing_img }">
	                                <p class="cover-layer">实景图</p>
	                                <span class="photo-frame"></span>
	                            </a>
                            </c:if>
                            
                            <c:if test="${guihua_img !=null }">
	                            <a role="thumbItem" class="thumb-item  last" href="picList.jsp?estateId=${estate.id }&type==guihua">
	                                <img alt="" src="${upload_path}/${guihua_img }">
	                                <p class="cover-layer">规划图</p>
	                                <span class="photo-frame"></span>
	                            </a>
                            </c:if>
                          </div>


                        <!-- /列表分页 -->
                    </div>
                    <!-- /相册 -->
                </div>


<div style="width:100%; display:inline-block; float:left; margin-top:25px;">

</div>


                <!-- 分享模块 -->
                
                <div id="online-choose-room" class="sct screen-nd clearfix">
            <!-- 在线选房 -->
                    <h3 class="hd">在线选房<span>以下房源真实在售</span></h3>
                    <div class="fl online-order">
                        <div class="choose-room">
                            
                            <div role="contents" class="bd">
                                <form class="form-inline definewidth m20" name="form1"  method="get" onsubmit="doSearch();return false;">
                                <input type="hidden" name="pageSize" value="5"/>
                                <table cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th style="border-left: 1px solid #e8e8e8;">楼栋</th>
                                            <th>面积</th>
                                            <th>户型</th>
                                            <th>单价</th>
                                            <c:if test="${seller!=null}"><th>佣金</th></c:if>
                                            <th>折扣</th>
                                            <th>折后总价</th>
                                            <th>状态/操作</th>
                                        </tr>
                                    </thead>
                                        <tr style="display:none" class="repeat">
                                            <td title="楼栋">$[dhao]</td>
                                            <td title="面积">$[mji]</td>
                                            <td onmouseout="hiddenPic();"><a href="#" src="$[hxingImg]"  onclick="showPic(this);" style="text-decoration:underline" >$[hxing]</a></td>
                                            <td title="单价">$[djia]</td>
                                            <c:if test="${seller!=null}"><th>$[yongjin]</th></c:if>
                                            <td title="折扣">$[youhuiPlan]</td>
                                            <td title="折后总价">$[totalPrice]</td>
                                            <td><a onclick="openNewWin('house_order','预约看房','yykf.jsp?estateId=${estate.id}&hid=$[id]' ,'400px');" href="javascript:;" class="btn-choose btn-order ">预约此房</a>
                                            </td>
                                     </tr>
    
                                </table>
                                <div class="footer" style="margin-top:5px;margin-left:35px;">
							        <div class="maxHW mainCont ymx_page foot_page_box"></div>
							    </div>
                        	</form>
                            </div>
                        
                        </div>
                     </div>

                </div>
                <c:if test="${estate.jjtc!=null}">
                    <div class="sct screen-rd">
                        <h3 class="hd">即将推出</h3>
                        <span>${estate.jjtc}</span>
                    </div>
                </c:if>
                <div class="sct screen-rd">
                    <h3 class="hd">基本信息</h3>
                    <table cellspacing="0" class="table-text">
                        <tbody><tr>
                            <th>参考均价</th>
                            <td style="width:35%;">${estate.junjia}<c:if test="${estate.junjia!=null}" >元/平米</c:if></td>
                            <th>咨询电话</th>
                            <td>${estate.tel }</td>
                        </tr>
                        <tr>
                            <th>主力户型</th>
                            <td style="width:35%;">${estate.mainHuxing}</td>
                            <th>开盘时间</th>
                            <td><fmt:formatDate value="${estate.opentime}" pattern="yyyy-MM-dd"/></td>
                        </tr>
                        <tr>
                            <th>装修情况</th>
                            <td>${estate.zxiu }</td>
                            <th>区域/板块</th>
                            <td>${estate.quyu}</td>
                        </tr>
                        <tr>
                            <th>项目地址</th>
                            <td>${estate.addr}</td>
                            <th>售楼地址</th>
                            <td>${estate.shouloubu}</td>
                        </tr>
                        <tr>
                            <th>开发商</th>
                            <td>${estate.developer}</td>
                            <th>代理商</th>
                            <td>${estate.daili}</td>
                        </tr>
                        <tr>
                            <th>销售许可证</th>
                            <td>${estate.xukezheng}</td>
                            <th>付款方式</th>
                            <td>${estate.fukuang}</td>
                        </tr>
                        <tr>
                            <th>公积金贷款</th>
                            <td>${estate.gongjijin}</td>
                            <th>交房时间</th>
                            <td><fmt:formatDate value="${estate.jiaofangDate}" pattern="yyyy-MM-dd"/></td>
                        </tr>
                    </tbody></table>
                    <h3 class="hd">建筑信息</h3>
                    <table cellspacing="0" class="table-text">
                        <tbody><tr>
                            <th>土地使用年限</th>
                            <td style="width:35%;">${estate.chanquan}<c:if test="${estate.chanquan!=null}" >年</c:if></td>
                            <th>规划户数</th>
                            <td>${estate.hushu}<c:if test="${estate.hushu!=null}" >户</c:if></td>
                        </tr>
                        <tr>
                            <th>产证归属</th>
                            <td>${estate.guishu }</td>
                            <th>建筑面积</th>
                            <td>${estate.jzmj }<c:if test="${estate.jzmj!=null}" ></c:if></td>
                        </tr>
                        <tr>
                            <th>规划面积</th>
                            <td>${estate.ghmj}<c:if test="${estate.ghmj!=null}" ></c:if></td>
                            <th>公摊面积</th>
                            <td>${estate.gongtan}<c:if test="${estate.gongtan!=null}" >%</c:if></td>
                        </tr>
                        <tr>
                            <th>建筑类型</th>
                            <td>${estate.lxing}</td>
                            <th>项目特色</th>
                            <td>${estate.tese }</td>
                        </tr>
                    </tbody></table>
                    <h3 class="hd">物业类型</h3>
                    <table cellspacing="0" class="table-text">
                        <tbody><tr>
                            <th>物业类型</th>
                            <td style="width:35%;">${estate.wylx }</td>
                            <th>容积率</th>
                            <td>${estate.rongji }</td>
                        </tr>
                        <tr>
                            <th>物业费</th>
                            <td>${estate.wyfee }<c:if test="${estate.wyfee!=null}" ></c:if></td>
                            <th>绿化率</th>
                            <td>${estate.lvhua }<c:if test="${estate.lvhua!=null}" >%</c:if></td>
                        </tr>
                        <tr>
                            <th>物业公司</th>
                            <td>${estate.wyComp }</td>
                            <th>车位数</th>
                            <td>${estate.chewei }</td>
                        </tr>
                    </tbody></table>
                    <h3 class="hd">楼盘介绍</h3>
                    <table cellspacing="0" class="table-text">
                        <tbody><tr>
                            <th>项目介绍</th>
                            <td style="width:89%;">${estate.jieshao}</td>
                        </tr>
                    </tbody></table>
                </div>
                
                <div class="screen-sur">
                
                     <h3 class="hd">周边配套</h3>
                     
                     <div class="panel-bd">
                     
                          <div id="mapTags" class="surround-hd">
                              <a onClick="showN('公交')" href="javascript:;" class="facility selected">公交</a>
                              <a onClick="showN('地铁')" rel="subway" href="javascript:;" class="facility">地铁</a>
                              <a onClick="showN('教育设施')" rel="education" href="javascript:;" class="facility">教育设施</a>
                              <a onClick="showN('医院')" rel="hospital" href="javascript:;" class="facility">医院</a>
                              <a onClick="showN('银行')" rel="bank" href="javascript:;" class="facility">银行</a>
                              <a onClick="showN('休闲娱乐')" rel="fun" href="javascript:;" class="facility">休闲娱乐</a>
                              <a onClick="showN('购物')" rel="shopping" href="javascript:;" class="facility">购物</a>
                              <a onClick="showN('餐饮')" rel="catering" href="javascript:;" class="facility">餐饮</a>
                              <a onClick="showN('运动健身')" rel="sport" href="javascript:;" class="facility">运动健身</a>
                          </div>
                     
                     </div>
                     
                     <div class="surround-bd" style="margin-top:20px;">
                          
                          <div id="allmap" style="width:690px; height:340px; float:left;"></div>
                          <div id="r-result" style="width:300px; height:340px; float:right; overflow:hidden; overflow-y:auto;"></div>

                     
                     
                     </div>
                </div>

            </div>
          

     </div>

</div>
<img id="success_info" src="images/success_info.png" style="display:none;position:absolute;border:1px solid #999"/>
<jsp:include page="foot.jsp"></jsp:include>

</body>
</html>


<script type="text/javascript">
var point = new BMap.Point(${estate.jingdu}, ${estate.weidu});
	// 百度地图API功能
	var map = new BMap.Map("allmap");    // 创建Map实例
	//var points = new BMap.Point(117.309, 31.837);
	map.centerAndZoom(point, 15);  // 初始化地图,设置中心点坐标和地图级别
	//map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
	map.setCurrentCity("${session_city}");          // 设置地图显示的城市 此项是必须设置的
	map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
	//map.centerAndZoom("合肥",16);


//添加比例尺	
	var top_left_control = new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT});// 左上角，添加比例尺
	var top_left_navigation = new BMap.NavigationControl();  //左上角，添加默认缩放平移控件
	function add_control(){
		map.addControl(top_left_control);        
		map.addControl(top_left_navigation);      
	}
	
	add_control();//添加比例尺

// 创建地址解析器实例
var myGeo = new BMap.Geocoder();
// 将地址解析结果显示在地图上,并调整地图视野
// myGeo.getPoint("凤麟大道与泉阳路", function(p){
// 	if (p) {
// 		point = p;
// 		//map.addOverlay(new BMap.Marker(point));
// 	}else{
// 		//alert("您选择地址没有解析到结果!");
// 	}
// 	map.centerAndZoom(point, 16);
// }, "${session_city}");
	
	
//点附近的公交站牌
    function showN(n){
	
	    map.clearOverlays(); 
		zdyLayer();
		var local = new BMap.LocalSearch(map, {
			renderOptions:{map: map, panel: "r-result"}
		});
		var pStart = new BMap.Point(point.lng-0.01, point.lat-0.01);
		var pEnd = new BMap.Point(point.lng+0.01, point.lat+0.01);
		var bs = new BMap.Bounds(pStart,pEnd);   //自己规定范围
		local.searchInBounds(n, bs);
	//	conBlock(n)
	
		var polygon = new BMap.Polygon([
			new BMap.Point(pStart.lng,pStart.lat),
			new BMap.Point(pEnd.lng,pStart.lat),
			new BMap.Point(pEnd.lng,pEnd.lat),
			new BMap.Point(pStart.lng,pEnd.lat)
			]);
	
	$('#mapTags a').each(function(index,obj){
		if($(obj).text()==n){
			$(obj).addClass('selected');
		}else{
			$(obj).removeClass('selected');
		}
	});
}
	//map.addOverlay(polygon);//此处显示区域
	
	

	
	
	// 复杂的自定义覆盖物
	function zdyLayer(){
		function ComplexCustomOverlay(point, text, mouseoverText){
		  this._point = point;
		  this._text = text;
		  this._overText = mouseoverText;
		}
		ComplexCustomOverlay.prototype = new BMap.Overlay();
		ComplexCustomOverlay.prototype.initialize = function(mp){
		  this._mp = mp;
		  var div = this._div = document.createElement("div");
		  div.style.position = "absolute";
		  div.style.zIndex = BMap.Overlay.getZIndex(this._point.lat);
		  div.style.backgroundColor = "#EE5D5B";
		  div.style.border = "1px solid #BC3B3A";
		  div.style.color = "white";
		  div.style.height = "18px";
		  div.style.padding = "2px";
		  div.style.lineHeight = "18px";
		  div.style.whiteSpace = "nowrap";
		  div.style.MozUserSelect = "none";
		  div.style.fontSize = "12px"
		  var span = this._span = document.createElement("span");
		  div.appendChild(span);
		  span.appendChild(document.createTextNode(this._text));      
		  var that = this;
	
		  var arrow = this._arrow = document.createElement("div");
		  arrow.style.background = "url(http://map.baidu.com/fwmap/upload/r/map/fwmap/static/house/images/label.png) no-repeat";
		  arrow.style.position = "absolute";
		  arrow.style.width = "11px";
		  arrow.style.height = "10px";
		  arrow.style.top = "22px";
		  arrow.style.left = "10px";
		  arrow.style.overflow = "hidden";
		  div.appendChild(arrow);
		 
		  div.onmouseover = function(){
			this.style.backgroundColor = "#6BADCA";
			this.style.borderColor = "#0000ff";
			this.getElementsByTagName("span")[0].innerHTML = that._overText;
			arrow.style.backgroundPosition = "0px -20px";
		  }
	
		  div.onmouseout = function(){
			this.style.backgroundColor = "#EE5D5B";
			this.style.borderColor = "#BC3B3A";
			this.getElementsByTagName("span")[0].innerHTML = that._text;
			arrow.style.backgroundPosition = "0px 0px";
		  }
	
		  map.getPanes().labelPane.appendChild(div);
		  
		  return div;
		}
		ComplexCustomOverlay.prototype.draw = function(){
		  var mp = this._mp;
		  var pixel = mp.pointToOverlayPixel(this._point);
		  this._div.style.left = pixel.x - parseInt(this._arrow.style.left) + "px";
		  this._div.style.top  = pixel.y - 30 + "px";
		}
		//var txt = "绿地赢海国际大厦", mouseoverTxt = txt + " " + parseInt(Math.random() * 1000,10) + "套" ;
			
		//var myCompOverlay = new ComplexCustomOverlay(points, "绿地赢海国际大厦",mouseoverTxt);
	
		//map.addOverlay(myCompOverlay);
	}
	
	
	
	
	
</script>
