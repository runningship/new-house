<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

               <div class="tit fl"><h3>限时特惠推荐</h3></div>
               <ul class="con fl">
                <c:forEach items="${youhuiList}" var="youhui">
                  <li>
                    <a href="info.jsp?estateId=${youhui.id}">
                       <span class="img fl">
							           <img src="${upload_path}/${youhui.img}" />
					             </span>
                    </a>
                       <span class="name fl">
                             <p><a href="info.jsp?estateId=${youhui.id}"><em>[${youhui.quyu}]</em>${youhui.name}</a></p>
                             <p class="col">原价：<del>${youhui.junjia}元/㎡</del></p>
                             <p class="col3">优惠价：<b>${youhui.youhuiPlan}</b>元/㎡</p>
                       </span>
                   </li>
                </c:forEach>
               </ul>
               
               <div class="tit fl"><h3>微信公众账号</h3></div>
               <div class="con fl erweima">
                   
                   <img src="images/ewm.png" />
                   
               </div>
          