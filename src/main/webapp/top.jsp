<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.youwei.newhouse.entity.User" %>
<script type="text/javascript" src="js/city/jquery.cityselect.js"></script>
<script type="text/javascript" src="http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js"></script>

<div class="warp top">
     
     <div class="main">
           
            <div id="city_1" style="display:inline-block;">
		  		<select class="prov"  id="province" ></select> 
		    	<select class="city" id="city" ></select>
		    </div>
     	<%
			User user = (User)request.getSession().getAttribute("user");
	     	if(user!=null){
	     		request.setAttribute("seller" , user);
	     	}
	     	String city = (String)request.getSession().getAttribute("session_city");
	     	if(city!=null && !"undefined".equals(city)){
	     		request.setAttribute("session_city" , city);
	     	}
	     	String province = (String)request.getSession().getAttribute("session_province");
	     	if(province!=null && !"undefined".equals(province)){
	     		request.setAttribute("session_province" , province);
	     	}
	     	Boolean isDebug = request.getSession().getServletContext().getServerInfo().startsWith("jetty");
	     	if(isDebug){
	     		request.setAttribute("upload_path" , "upload/");
	     	}else{
	     		request.setAttribute("upload_path" , "/upload/");
	     	}
     	%>
     	<c:if test="${session_city !=null }">
     		<script type="text/javascript">$(function(){sessionCity='${session_city}'; sessionProvince='${session_province}';});</script>
     	</c:if>
   		<c:if test="${seller !=null }">
   			<span class="fr topFr"><a href="sellerIndex.jsp">${seller.name }</a><a href="logout.jsp">退出</a></span>
   		</c:if>
   		<c:if test="${seller ==null }">
       		<span class="fr topFr"><a href="login.jsp">经纪人登录</a><a href="register.jsp">注册</a></span>
   		</c:if>
     </div>

</div>

<div class="warp">
     
     <div class="main">
      
          <div class="fl"><a href="index.jsp"><img src="images/logo.jpg" /></a></div>
          
          <div class="search-wrap fr">
                <div id="searchBar" class="search-bar">
                                
                    
                    <form action="houses.jsp" method="post">
                    <div class="search-menu">
                      <!-- <div class="search-tab">
                        <a val="1" href="javascript:;" class="tab-item current">新房</a>
                        <a val="2" href="javascript:;" class="tab-item">二手房</a>
                      </div>
                      <i></i>
 -->                    </div>
                        <input type="text"  style="margin-left:3px;" placeholder="楼盘名称 " value="${searchText }"  id="searchText" class="search-input"  name="searchText"/>
                        <input type="hidden"  value="${selectedQuyu }"  id="quyu_input"  class="search-input"  name="quyu"/>
                        <input type="hidden" value="${selectedLxing }"  id="lxing_input" class="search-input"  name="lxing"/>
                        <input type="hidden" value="${jiageStart }"  id="jiageStart_input" class="search-input"  name="jiageStart"/>
                        <input type="hidden" value="${jiageEnd }"  id="jiageEnd_input" class="search-input"  name="jiageEnd"/>
                        <input type="submit" class="search-btn"  value="搜索" />
                    </form>
                </div>
            </div>
          
          
      
     </div>

</div>

<script type="text/javascript">
var mycity;
var sessionCity;
var sessionProvince;
$(function(){
	var myprovince = remote_ip_info['province'];
	mycity = remote_ip_info['city']
	var mydistrict = remote_ip_info['district'];
	if(sessionProvince && sessionCity){
		$("#city_1").citySelect({
			prov : sessionProvince, 
	    	city : sessionCity,
	    	cityChange:changeCity
		});
	}else{
		$("#city_1").citySelect({
			prov:myprovince, 
	    	city:mycity,
	    	cityChange:changeCity
		});
		alert('正在为您切换到'+myprovince+'省'+mycity+'市...');
		setTimeout(changeCity,2000);
	}
});

function changeCity(){
	YW.ajax({
        type: 'POST',
        url: '${projectName}/c/setCity',
        data:'province='+$('#province').val()+'&city='+$('#city').val(),
        mysuccess: function(data){
        	if(window.location.pathname.indexOf('sale.jsp')>-1
                    || window.location.pathname.indexOf('index.jsp')>-1
                    || window.location.pathname.indexOf('houses.jsp')>-1
                    || window.location.pathname.indexOf('houseMap.jsp')>-1
                    || window.location.pathname.indexOf('estateYongJin.jsp')>-1
                    || window.location.pathname.indexOf('sellerIndex.jsp')>-1
                    || window.location.pathname.indexOf('estateOrder.jsp')>-1
                    || window.location.pathname.indexOf('houseOrder.jsp')>-1){
                    window.location.reload();
             }else{
               window.location='/fjb/index.jsp';
             }
        }
    });
}
</script>