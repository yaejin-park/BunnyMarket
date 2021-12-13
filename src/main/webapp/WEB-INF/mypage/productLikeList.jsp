<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" type="text/css" href="/css/swiper.min.css">
<link rel="stylesheet" type="text/css" href="/css/mypage_style.css">
<div class="mydetail-form mylike-form">
	<div class="inner">
		<div class="swiper side-menu-div">
			<div class="swiper-wrapper">
				<a href="/mypage/auth/detail" class="swiper-slide">내정보</a>
				<a href="/mypage/auth/sellList" class="swiper-slide">판매내역</a>
				<a href="/mypage/auth/followlist" class="swiper-slide">모아보기</a>
				<a href="javascript:" class="swiper-slide">나의후기</a>
				<a href="/mypage/auth/productlike" class="swiper-slide active">관심목록</a>
				<a href="/mypage/auth/member/updateform" class="swiper-slide">회원수정</a>
				<a href="/mypage/auth/member/deleteform" class="swiper-slide">회원탈퇴</a>
			</div>
		</div>
		<div class="my-like">
			<p class="tit">관심목록</p>
			<table class="table">
				<tr>
					<th class="image">상품</th>
					<th class="title">상품명</th>
					<th class="price">금액</th>
					<th class="status">진행상태</th>
				</tr>
					<c:if test="${list.size()!=0}">
					<c:forEach items="${list}" var="one">
						<tr>
							<td align="center" class="thumnail">
								<c:set var="thumbName" value="${fn:split(one.uploadfile,',')[0]}" />
								<a href="/product/detail?idx=${one.idx}&currentPage=${currentPage}&key=list">
									<img alt="thumbnail" src="/photo/${thumbName}">
								</a>
							</td>
							<td>
								<div class="tit">${one.title}</div>
							</td>
							<td align="center">
								<fmt:formatNumber type="number" value="${one.price}"/>원
							</td>
							<td align="center">
								${one.sellstatus}
							</td>
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
