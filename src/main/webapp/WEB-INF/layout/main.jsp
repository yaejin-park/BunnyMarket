<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="/css/swiper.min.css">
<link rel="stylesheet" href="/css/main_style.css">
<c:set var="root" value="<%=request.getContextPath() %>"></c:set>
<section class="main-vis">
	<div class="swiper-wrapper">
		<a href="/join/main" class="swiper-slide">
			<img alt="" src="/image/main-vis1.jpg" class="pc-img">
			<img alt="" src="/image/main-vis1-m.jpg" class="mobile-img">
		</a>
		<a href="/event/detail?idx=27&currentPage=1" class="swiper-slide">
			<img alt="" src="/image/main-vis2.jpg" class="pc-img">
			<img alt="" src="/image/main-vis2-m.jpg" class="mobile-img">
		</a>
		<a href="/event/detail?idx=28&currentPage=1" class="swiper-slide">
			<img alt="" src="/image/main-vis3.jpg" class="pc-img">
			<img alt="" src="/image/main-vis3-m.jpg" class="mobile-img">
		</a>
	</div>
	<div class="swiper-pagination"></div>
</section>

<div class="product-div">
	<div class="inner">
		<p class="title">동네거래</p>
		<c:if test="${productCnt == 0}">
			<div class="nodata">
				<p class="icon">
					<img alt="" src="/image/nodata-icon.png">
				</p>
				<p>등록된 데이터가 없습니다.</p>
			</div>
		</c:if>
		<c:if test="${productCnt > 0}">
			<ul class="product-list">
				<c:forEach var="productDto" items="${productList}">
					<c:set var="thumbName" value="${fn:split(productDto.uploadfile,',')[0]}" />
					<li>
						<a href="/product/detail?idx=${productDto.idx}">
							<div class="img-div">
								<img alt="" src="/photo/${thumbName}">
							</div>
							<div class="txt-div">
								<p class="txt">${productDto.title}</p>
								<p class="tit price">
									<fmt:formatNumber type="number" value="${productDto.price}"></fmt:formatNumber> 원
								</p>
								<div class="etc">
									<p class="chat">${productDto.chatcount}</p>
									<p class="like">${productDto.likecount}</p>	
								</div>
							</div>
						</a>
					</li>
				</c:forEach>
			</ul>
			<a href="/product/list" class="more-btn">더보기</a>
		</c:if>
	</div>
</div>

<script type="text/javascript" src="/js/swiper.min.js"></script>
<script type="text/javascript" src="/js/main_script.js"></script>
