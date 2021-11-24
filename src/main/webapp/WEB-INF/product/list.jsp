<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" type="text/css" href="/css/product_style.css">
<div class="inner">
	<div class="all">
		<div class="group category"></div>
		
		<div class="group">
			<c:forEach items="${list}" var="one">
				<c:set var="thumbName" value="${fn:split(one.uploadfile,',')[0]}" />
				<div class="oneList child">
					<div class="fix">
						<img alt="thubnail" src="../photo/${thumbName}" style="">
					</div>
					<div class="shortTit">${one.title}</div>
					<div class="tit child">
					<fmt:formatNumber type="number" value="${one.price}"/>원</div>
					<div class="tit-sm more">대화 ${one.chatcount}&nbsp;&nbsp;&nbsp;찜 ${one.goodcount}</div>
				</div>
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