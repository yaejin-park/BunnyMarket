<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="/css/swiper.min.css">
<link rel="stylesheet" type="text/css" href="/css/mypage_style.css">
<div class="mydetail-form">
	<div class="inner">
		<div class="tit">
			팔로워 ${fcount}
		</div>
		<div>
			<c:if test="${followerList==0}">
				<div class="nodata">
					<p class="icon">
						<img alt="" src="/image/nodata-icon.png">
					</p>
					<p>팔로우한 사용자가 없습니다.</p>
				</div>
			</c:if>
			<c:if test="${followerList>0}">
			    <ul class="re-list">
			    	<c:forEach var="follow" items="${followerList}">
			    		<c:if test="true">
			    			<div>팔로워 ${follow.followee}</div>
			    		</c:if>
			    	</c:forEach>
			    </ul>
			</c:if>
		</div>
	</div>
</div>