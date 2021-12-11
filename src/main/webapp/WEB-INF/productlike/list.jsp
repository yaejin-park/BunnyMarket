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
