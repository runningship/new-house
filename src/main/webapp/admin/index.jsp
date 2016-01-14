<%@page import="com.youwei.newhouse.cache.ConfigCache"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
 <head>
  <title>中介宝新房通后台管理系统</title>
  <link type="image/x-icon" rel="icon" href="../images/zjb.png">
   <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
   <link href="assets/css/dpl-min.css" rel="stylesheet" type="text/css" />
  <link href="assets/css/bui-min.css" rel="stylesheet" type="text/css" />
   <link href="assets/css/main-min.css" rel="stylesheet" type="text/css" />
   <script type="text/javascript" src="assets/js/jquery-1.8.1.min.js"></script>
  <script type="text/javascript" src="assets/js/bui-min.js"></script>
  <script type="text/javascript" src="assets/js/common/main-min.js"></script>
  <script type="text/javascript" src="assets/js/config-min.js"></script>
  <script type="text/javascript">
  var projectName='${projectName}';
  </script>
 </head>
 <body>
<%
 	Boolean isDebug = request.getSession().getServletContext().getServerInfo().startsWith("jetty");
	request.setAttribute("upload_path" , "http://"+ConfigCache.get("domainName", "localhost")+ "/zjb_newhouse_images");
%>
 <script type="text/javascript">
 var upload_path='${upload_path}';
 </script>
  <div class="header" style="height:0px;">
    
      <div class="dl-title">
       <!--<img src="/chinapost/Public/assets/img/top.png">-->
      </div>
  </div>
   <div class="content">
    <div class="dl-main-nav">
      <div class="dl-inform"><div class="dl-inform-title"><s class="dl-inform-icon dl-up"></s></div></div>
      <ul id="J_Nav"  class="nav-list ks-clear">
        		<li class="nav-item dl-selected"><div class="nav-item-inner nav-home">系统管理</div></li>

      </ul>
      <div style="position:absolute;right:0px;top:8px;" class="dl-log">欢迎您，<span class="dl-log-user">${user.account }</span><a href="./user/logout.jsp" title="退出系统" class="dl-log-quit">[退出]</a>
      </div>
    </div>
    <ul id="J_NavContent" class="dl-tab-conten"> </ul>
   </div>
  
  <script>
     BUI.use('common/main',function(main){
       var config =[
                 {
                     id: '1',
                     menu: [
                         {
                             text: '楼盘管理',
                             items: [
                                 {
                                     id: 'estate_list',
                                     text: '楼盘信息',
                                     href: 'estate/list.jsp'
                                 },{
                                     id: 'estate_add',
                                     text: '添加楼盘',
                                     href: 'estate/add.jsp'
                                 }
                             ]
                         },
                         {
                             text: '用户管理',
                             items: [{
                                     id: 'admin_list',
                                     text: '系统用户',
                                     href: 'user/adminList.jsp'
                                 },{
                                     id: 'password_change',
                                     text: '修改密码',
                                     href: 'user/changePwd.jsp'
                                 }
                             ]
                         },{
                             text: '预约管理',
                             items: [
                                 {
                                     id: 'order_estate_list',
                                     text: '楼盘预约',
                                     href: 'order/listEstate.jsp'
                                 }
                             ]
                         },{
                             text: '配置管理',
                             items: [
                                 {
                                     id: 'lxing_cfg',
                                     text: '建筑类型',
                                     href: 'config/lxingList.jsp'
                                 },{
                                     id: 'wylx_cfg',
                                     text: '物业类型',
                                     href: 'config/wylxList.jsp'
                                 }
                                  ,{
                                      id: 'city_cfg',
                                      text: '城市',
                                      href: 'city/edit.jsp'
                                  }
                                 ,{
                                     id: 'huxing_cfg',
                                     text: '户型',
                                     href: 'huxing/list.jsp'
                                 }
                             ]
                         }
                     ]
                 }
             ];
       new PageUtil.MainPage({
         modulesConfig : config
       });
     });
</script>
 </body>
</html>