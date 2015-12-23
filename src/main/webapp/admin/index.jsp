<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
 <head>
  <title>房金宝后台管理系统</title>
  <link type="image/x-icon" rel="icon" href="../images/fjb.png">
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
 	if(isDebug){
 		request.setAttribute("upload_path" , "../../upload/");
 	}else{
 		request.setAttribute("upload_path" , "/upload/");
 	}
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
                         // {
                         //     text: '房源管理',
                         //     items: [
                         //         {
                         //             id: '4',
                         //             text: '房源信息',
                         //             href: 'house/list.jsp'
                         //         },{
                         //             id: '2',
                         //             text: '添加房源',
                         //             href: 'house/list.jsp'
                         //         }
                         //     ]
                         // },
                         {
                             text: '用户管理',
                             items: [
                                 {
                                     id: 'seller_list',
                                     text: '经纪人',
                                     href: 'user/sellerList.jsp'
                                 },{
                                     id: 'sellermen_list',
                                     text: '销房员',
                                     href: 'user/sellermenList.jsp'
                                 },{
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
                                     id: 'order_house_list',
                                     text: '房源预约',
                                     href: 'order/listHouse.jsp'
                                 },{
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
//                                ,{
//                                      id: 'quyu_cfg',
//                                      text: '区域',
//                                      href: 'config/quyuList.jsp'
//                                  }
                                 ,{
                                     id: 'huxing_cfg',
                                     text: '户型',
                                     href: 'huxing/list.jsp'
                                 }
                             ]
                         },{
                             text: '服务',
                             items: [
                                 {
                                     id: 'about_jinbao',
                                     text: '关于房金宝',
                                     href: 'article/edit.jsp?pageName=about'
                                 },{
                                     id: 'contaction_ways',
                                     text: '联系我们',
                                     href: 'article/edit.jsp?pageName=contactUs'
                                 },{
                                      id: 'service_tab',
                                      text: '服务申明',
                                      href: 'article/edit.jsp?pageName=shenming'
                                  },{
                                      id: 'service_rule',
                                      text: '活动规则',
                                      href: 'article/edit.jsp?pageName=rule'
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