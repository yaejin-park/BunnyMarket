<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" type="text/css" href="/css/swiper.min.css">
<link rel="stylesheet" type="text/css" href="/css/mypage_style.css">
<link rel="stylesheet" type="text/css" href="/css/product_style.css">
<div class="mydetail-form">
	<div class="inner">
		<div class="swiper side-menu-div">
			<div class="swiper-wrapper">
				<a href="" class="swiper-slide">팔로우</a>
				<a href="./selllist" class="swiper-slide">판매내역</a>
				<a href="./productlike/list" class="swiper-slide">관심목록</a>
				<a href="" class="swiper-slide">나의후기</a>
				<a href="./member/updateform" class="swiper-slide">회원수정</a>
				<a href="./member/deleteform" class="swiper-slide">회원탈퇴</a>
			</div>
		</div>
		<div class="my-page">
			<!-- 프로필 이미지 선택 -->
			<div class="profile-update">
				<div class="profile-img">
					<!-- 프로필 이미지 있을때 -->
					<c:if test="true">
						<img alt="프로필이미지" src="/image/profile-icon.png">
					</c:if>
					<!-- 프로필 이미지 없을때 -->
					<c:if test="false">
						<img alt="프로필이미지" src="/image/profile-icon.png">
					</c:if>
				</div>
			</div>			
			<div class="my-info">
				<b>[${nick}]회원님 안녕하세요.</b>
			</div>
			<div class="my-info-update">
				<button type="button" class="btn-update" onclick="location.href='../auth/profileupdateform'">프로필변경</button>
			</div>
		</div>
		<div class="my-sales">
		<h3><b>관심목록</b></h3>
			<table class="table">
				<tr>
					<th>상품정보</th>
					<th>진행상태</th>
				</tr>
					<c:if test="${list.size()!=0}">
					<c:forEach items="${list}" var="one">
						<tr>
							<td>
								<c:set var="thumbName" value="${fn:split(one.uploadfile,',')[0]}" />
								<div class="oneList child" onclick="location.href='detail?idx=${one.idx}&currentPage=${currentPage}&key=list'">
									<div class="thumbnailDiv">
										<img alt="thumbnail" src="../../../photo/${thumbName}"class="thumbnail">
									</div>
								</div>
							</td>
							<td>
								<div class="info-div">
									<div class="tit">
									<div class="shortTit">${one.title}</div>
										<fmt:formatNumber type="number" value="${one.price}"/>원
									</div>
								</div>
							</td>
							<td>${one.sellstatus}</td>
						</tr>
					</c:forEach>
					</c:if>
			</table>
		</div>
	</div>
</div>
<script type="text/javascript" src="/js/swiper.min.js"></script>
<script type="text/javascript" src="/js/mypage_script.js"></script>
