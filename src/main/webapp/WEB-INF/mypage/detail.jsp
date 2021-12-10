<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="/css/swiper.min.css">
<link rel="stylesheet" type="text/css" href="/css/mypage_style.css">
<div class="mydetail-form">
	<div class="inner">
		<div class="swiper side-menu-div">
			<div class="swiper-wrapper">
				<b><a href="./sellList" class="swiper-slide">판매내역</a></b>
				<a href="./followlist" class="swiper-slide">모아보기</a>
				<a href="./productlike/list" class="swiper-slide">나의후기</a>
				<a href="./productlike/list" class="swiper-slide">관심목록</a>
				<a href="./member/updateform" class="swiper-slide">회원수정</a>
				<a href="./member/deleteform" class="swiper-slide">회원탈퇴</a>
			</div>
		</div>
		<div class="my-page">
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
			<div class="my-info">
				<b>[${nick}]회원님 안녕하세요.</b>
			</div>
			<div class="my-info-update">
				<button type="button" class="btn-update" onclick="location.href='profileupdateform'">프로필변경</button>
			</div>
		</div>
		<div class="my-sales">
		<h3><b>판매내역</b></h3>
			<table class="table">
				<tr>
					<th>상품정보</th>
					<th>진행상태</th>
				<tr>
				<tr>
					<td>이미지</td>
					<td>상품정보</td>
					<td>진행상태</td>
				</tr>
				<tr>
					<td>이미지</td>
					<td>상품정보</td>
					<td>진행상태</td>
				</tr>
				<tr>
					<td>이미지</td>
					<td>상품정보</td>
					<td>진행상태</td>
				</tr>
			</table>
		</div>
	</div>
</div>
<script type="text/javascript" src="/js/swiper.min.js"></script>
<script type="text/javascript" src="/js/mypage_script.js"></script>