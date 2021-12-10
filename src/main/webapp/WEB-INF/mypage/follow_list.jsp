<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="/css/swiper.min.css">
<link rel="stylesheet" type="text/css" href="/css/mypage_style.css">
<div class="mydetail-form">
	<div class="inner">
		<div class="swiper side-menu-div">
			<div class="swiper-wrapper">
				<a href="./selllist" class="swiper-slide">판매내역</a>
				<b><a href="./followlist" class="swiper-slide">모아보기</a></b>
				<a href="" class="swiper-slide">관심목록</a>
				<a href="./productlike/list" class="swiper-slide">나의후기</a>
				<a href="./updateform" class="swiper-slide">회원수정</a>
				<a href="./unregister" class="swiper-slide">회원탈퇴</a>
			</div>
		</div>
		<div class="my-page">
			<!-- 프로필 이미지 선택 -->
			<div class="profile-update">
				<div class="profile-update">
					<div class="profile-img">
						<c:if test="${profile =='no'}">
							<img alt="프로필이미지" src="/image/profile-icon.png">
						</c:if>
						<c:if test="${profile !='no'}">
							<img alt="프로필이미지" src="/photo/${profile}">
						</c:if>
					</div>
				</div>
			</div>			
			<div class="my-info">
				<b>${nick}</b> 회원님 안녕하세요.
			</div>
		</div>
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