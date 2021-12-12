<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" type="text/css" href="/css/swiper.min.css">
<link rel="stylesheet" type="text/css" href="/css/productlike_style.css">
<div class="mylike-form">
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
		<div class="my-like">
		<h3><b>관심목록</b></h3>
			<table class="table">
				<tr>
					<th class="like-th"></th>
					<th>상품정보</th>
					<th>진행상태</th>
				</tr>
					<c:if test="${list.size()!=0}">
					<c:forEach items="${list}" var="one">
						<tr class="like-tr">
							<td>
								<c:set var="thumbName" value="${fn:split(one.uploadfile,',')[0]}" />
								<div class="oneList child" onclick="location.href='../../../product/detail?idx=${one.idx}&currentPage=${currentPage}&key=list'">
									<div class="thumbnailDiv">
										<img alt="thumbnail" src="../../../photo/${thumbName}" class="thumbnail">
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
		<!-- 페이징 -->
	<div>
		<div class="paging">
			<c:if test="${startPage>1}">
				<a href="list?currentPage=${startPage-1}" class="prev"><span>이전</span></a>
			</c:if>
			<c:forEach var="i" begin="${startPage}" end="${endPage}" >
				<a href="list?currentPage=${i}"  ${currentPage == i ? 'class="active"' : ''} >${i}</a>
			</c:forEach>
			
			<c:if test="${endPage<totalPage}">
				<a href="list?currentPage=${endPage+1}" class="next"><span>다음</span></a>
			</c:if>
		</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="/js/swiper.min.js"></script>
<script type="text/javascript" src="/js/mypage_script.js"></script>
