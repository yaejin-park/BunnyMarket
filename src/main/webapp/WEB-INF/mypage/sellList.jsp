<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" type="text/css" href="/css/swiper.min.css">
<link rel="stylesheet" type="text/css" href="/css/mypage_style.css">
<div class="mydetail-form">
	<div class="inner">
		<div class="swiper side-menu-div">
	        <div class="swiper-wrapper">
	           <a href="/mypage/auth/sellList" class="swiper-slide active">판매내역</a>
	           <a href="/mypage/auth/followlist" class="swiper-slide">모아보기</a>
	           <a href="javascript:" class="swiper-slide">나의후기</a>
	           <a href="/mypage/auth/productlike" class="swiper-slide">관심목록</a>
	           <a href="/mypage/auth/member/updateform" class="swiper-slide">회원수정</a>
	           <a href="/mypage/auth/member/deleteform" class="swiper-slide">회원탈퇴</a>
	        </div>
	    </div>
		<div class="sell-list">
				<div class="sell-list-condition">
					<p class="sell-info tit">판매 정보</p>
					<select id="sell-status">
						<option value="전체">전체</option>
						<option value="판매중">판매중</option>
						<option value="예약중">예약중</option>
						<option value="판매완료">판매완료</option>
					</select>
				</div>
				
				<div class="myselling-list">
					<table class="table">
						<thead>
							<tr>
								<th class="pimg">상품이미지</th>
								<th class="pinfo">상품정보</th>
								<th class="psellstatus">판매상태</th>
							</tr>
						</thead>
						<tbody class="sell-list-tbody" id="sell-list-tbody">
						</tbody>
					</table>
					
					<!-- 페이징 넣기 -->
					<c:if test="${totalCount>0}">
						<div class="paging">
							<!-- 이전 -->
							 <c:if test="${startPage>1}">
								<a href="sellList?currentPage=${startPage-1}" class="prev"><span>이전</span></a>		 
							 </c:if>
							
							<c:forEach var="pp" begin="${startPage}" end="${endPage}">
								<c:if test="${currentPage==pp}">
									<a href="sellList?currentPage=${pp}" class="active">${pp}</a>
								</c:if>
								<c:if test="${currentPage!=pp}">
									<a href="sellList?currentPage=${pp}">${pp}</a>
								</c:if>
							</c:forEach>
							
							<!-- 다음 -->
							<c:if test="${endPage<totalPage}">
								<a href="sellList?currentPage=${endPage+1}" class="next"><span>다음</span></a>
							</c:if>
						</div>
					</c:if>
					
				</div>
		</div>
	</div>
	
</div>

<script type="text/javascript" src="/js/swiper.min.js"></script>
<script type="text/javascript" src="/js/mypage_script.js"></script>
