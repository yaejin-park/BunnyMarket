<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="/css/swiper.min.css">
<link rel="stylesheet" type="text/css" href="/css/mypage_style.css">
<div class="mydetail-form">
	<div class="inner">
		<div class="swiper side-menu-div">
			<div class="swiper-wrapper">
				<a href="./sellList" class="swiper-slide">판매내역</a>
				<b><a href="./followlist" class="swiper-slide">모아보기</a></b>
				<a href="./productlike/list" class="swiper-slide">나의후기</a>
				<a href="./productlike/list" class="swiper-slide">관심목록</a>
				<a href="./member/updateform" class="swiper-slide">회원수정</a>
				<a href="./member/deleteform" class="swiper-slide">회원탈퇴</a>
			</div>
		</div>
		<div class="my-follow">
		<h3><b>모아보기</b></h3>
			<table class="table">
				<tr>
					<th>팔로워(나를팔로잉한사람) 0</th>
					<th>팔로우(내가팔로잉한사람) 0</th>
				</tr>
				<tr>
					<c:if test="${fcount==0}">
					<td colspan="2">
							<div class="nodata">
								<p class="icon">
									<img alt="" src="/image/nodata-icon.png">
								</p>
								<p>팔로우 내역이 없습니다.</p>
							</div>
						</td>
						</c:if>
					<c:if test="${fcount>0}">	
					<td>
					    <ul class="re-list">
					    	<c:forEach var="follow" items="${flist}">
					    		<c:if test="true">
					    			<div>팔로잉</div>
					    		</c:if>
					    	</c:forEach>
					    </ul>
					</td>
					</c:if>
				</tr>
			</table>
		</div>
	</div>
</div>