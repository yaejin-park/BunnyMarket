<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" type="text/css" href="/css/product_style.css">
<c:set var="category">디지털기기,의류,뷰티,인테리어,스포츠,문화생활,기타</c:set>

<div class="inner">
	<div class="all">
		<div class="group category-div">
			<a class="category" href="list?category=전체">전체 ></a>
			<c:forTokens items="${category}" delims="," var="category">
				<a class="category" href="list?start=${start}&perpage=${perpage }&category=${category}">${category}</a>
			</c:forTokens>
		</div>
	<div class="btn-wrap write-btn-div">
		<button type="button" class="btn-add" onclick="location.href='insertForm?currentPage='+${currentPage}">글쓰기</button>
	</div>
	<div class="group">
		<c:forEach items="${list}" var="one">
			<c:set var="thumbName" value="${fn:split(one.uploadfile,',')[0]}" />
			<a href='detail?idx=${one.idx}&currentPage=${currentPage}'>
			<div class="oneList child">
				<div class="thumbnailDiv">
					<img alt="thumbnail" src="../photo/${thumbName}"class="thumbnail">
				</div>
				<div class="info-div">
					<div class="shortTit">${one.title}</div>
					<div>
						<div class="tit">
							<fmt:formatNumber type="number" value="${one.price}"/>원
						</div>
						<div class="info-sm">  
							<span class="chat icon-sm">${one.chatcount}</span>
							<span class="dibs icon-sm">${one.goodcount}</span>
						</div>
					</div>
				</div>
			</div>
			</a>
		</c:forEach>
	</div>

	<!-- 페이징 -->
	<div>
		<div class="paging">
			<a href="javascript:" class="prev"><span>이전</span></a>
			
			<a href="javascript:" class="active">1</a>
			<a href="javascript:">2</a>
			<a href="javascript:">3</a>
			<a href="javascript:">4</a>
			<a href="javascript:">5</a>
			<a href="javascript:" class="next"><span>다음</span></a>
		</div>
		</div>
	</div>
</div>

<script>

</script>
