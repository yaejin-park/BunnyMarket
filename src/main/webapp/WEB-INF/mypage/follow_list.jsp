<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<link rel="stylesheet" type="text/css" href="/css/swiper.min.css">
<link rel="stylesheet" type="text/css" href="/css/mypage_style.css">
<link rel="stylesheet" type="text/css" href="/css/ad_style.css">
<div class="mydetail-form follow-div">
	<div class="inner">
		<div class="swiper side-menu-div">
	         <div class="swiper-wrapper">
	            <a href="/mypage/auth/detail" class="swiper-slide">내상점</a>
	            <a href="/mypage/auth/sellList" class="swiper-slide">판매내역</a>
	            <a href="/mypage/auth/followlist" class="swiper-slide active">모아보기</a>
	            <a href="/mypage/auth/reviewList" class="swiper-slide">나의후기</a>
	            <a href="/mypage/auth/productlike" class="swiper-slide">관심목록</a>
	            <a href="/mypage/auth/member/updateform" class="swiper-slide">회원수정</a>
	            <a href="/mypage/auth/member/deleteform" class="swiper-slide">회원탈퇴</a>
	         </div>
	      </div>
		<div class="myfollow-list">
			<c:if test="${totalCount>0}">
				<ul class="follow-product-list">
					<c:forEach var="list" items="${followList}">
						<li class="follow-li">
							<a href="/product/detail?idx=${list.idx}&currentPage=${currentPage}&key=list">
								<span></span>
								<div class="pimg img-div">
									<img alt="thumnail" src="/photo/${fn:split(list.uploadfile,',')[0]}">
								</div>
								<div class="product-profile-info">
									<span class="profile">
										<c:if test="${list.profile =='no'}">
												<img alt="프로필이미지" src="/image/profile-icon.png" class="profileImg">
										</c:if>
										<c:if test="${list.profile !='no'}">
											<img alt="프로필이미지" src="/photo/${list.profile}" class="profileImg">
										</c:if>
									</span>
									${list.nickname}
								</div>
								<div class="product-info-div">
									<p class="product-info category">${list.category}</p>
									<p class="product-info title">${list.title}</p>
									<p class="product-info price"><fmt:formatNumber value="${list.price}" type="number"/>원</p>
								</div>
							</a>
						</li>
					</c:forEach>
				</ul>
			</c:if>	
		</div>
		
		<!-- paging -->
		<c:if test="${totalCount>0}">
			<div class="paging">	
				<!-- 이전 -->
				<c:if test="${startPage>1}">
					<a href="followlist?currentPage=${startPage-1}" class="prev"><span>이전</span></a>
				</c:if>
				<c:forEach var="pp" begin="${startPage}" end="${endPage}">
					<c:if test="${currentPage==pp}">
						<a href="followlist?currentPage=${pp}" class="active">${pp}</a>
					</c:if>			
					<c:if test="${currentPage!=pp}">
						<a href="followlist?currentPage=${pp}">${pp}</a>
					</c:if>	
				</c:forEach>
				
				<!-- 다음 -->
				<c:if test="${endPage<totalPage}">
					<a href="followlist?currentPage=${endPage+1}" class="next"><span>다음</span></a>
				</c:if>
			</div>
		</c:if>
	</div>
</div>
<script type="text/javascript" src="/js/mypage_script.js"></script>