<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="/css/swiper.min.css">
<link rel="stylesheet" type="text/css" href="/css/mypage_style.css">
<div class="mydetail-form">
<div class="inner">
	<div class="swiper side-menu-div">
	        <div class="swiper-wrapper">
	        	<a href="/mypage/auth/detail" class="swiper-slide active">내정보</a>
	           <a href="/mypage/auth/sellList" class="swiper-slide active">판매내역</a>
	           <a href="/mypage/auth/followlist" class="swiper-slide">모아보기</a>
	           <a href="javascript:" class="swiper-slide">나의후기</a>
	           <a href="/mypage/auth/productlike" class="swiper-slide">관심목록</a>
	           <a href="/mypage/auth/member/updateform" class="swiper-slide">회원수정</a>
	           <a href="/mypage/auth/member/deleteform" class="swiper-slide">회원탈퇴</a>
	        </div>
	</div>

	<div class="writereview-list">
	<h3>내가 작성한 후기</h3>
		<table class="table" id="review">
			<thead>
				<tr>
				 	<th class="rwriter txt">아이디</th>
				 	<th class="rcontent txt">후기 내용</th>
				 	<th class="rwriteday txt">작성일</th>
				 	<th class="rstar txt">별점</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="dto" items="${myrelist}">
					<tr>
						<td class="dtext">${dto.reviewee}</td>
						<td class="dtext">${dto.content}</td>
						<td class="dtext">
						<fmt:formatDate value="${dto.writeday}" pattern="yyyy-MM-dd"/>
						</td>
						<td>
							<div class="star-ratings">
								<c:forEach var="s" begin="1" end="${dto.star}">
									<span class="star-ratings-fill">★</span>
								</c:forEach>
								<c:forEach var="s" begin="1" end="${5-dto.star}">
									<span>★</span>
								</c:forEach>
							</div>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<!-- 페이징 넣기 -->
		<c:if test="${totalCount>0}">
			<div class="paging">
				<!-- 이전 -->
				 <c:if test="${startPage>1}">
					<a href="list?currentPage=${startPage-1}" class="prev"><span>이전</span></a>		 
				 </c:if>
				
				<c:forEach var="pp" begin="${startPage}" end="${endPage}">
					<c:if test="${currentPage==pp}">
						<a href="list?currentPage=${pp}" class="active">${pp}</a>
					</c:if>
					<c:if test="${currentPage!=pp}">
						<a href="list?currentPage=${pp}">${pp}</a>
					</c:if>
				</c:forEach>
				
				<!-- 다음 -->
				<c:if test="${endPage<totalPage}">
					<a href="list?currentPage=${endPage+1}" class="next"><span>다음</span></a>
				</c:if>
			</div>
		</c:if>
	</div>
</div>
</div>

<script type="text/javascript" src="/js/swiper.min.js"></script>
<script type="text/javascript" src="/js/mypage_script.js"></script>