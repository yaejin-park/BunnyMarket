<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" type="text/css" href="/css/product_style.css">

<div class="inner">
	<c:if test="${list.size()==0}">
		<div class="nodata">
			<p class="icon">
				<img alt="" src="/image/nodata-icon.png">
			</p>
			<p>등록된 데이터가 존재하지 않습니다.</p>
		</div>
	</c:if>
		
	<div class="group">
		<c:if test="${list.size()!=0}">
		<c:forEach items="${list}" var="one">
			<c:set var="thumbName" value="${fn:split(one.uploadfile,',')[0]}" />
			<div class="oneList child" onclick="location.href='detail?idx=${one.idx}&currentPage=${currentPage}'">
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
							<div class="info-Div">
								<div class="child">
									<img class="icon-sm" alt="chat-icon" src="/image/chat-icon.png">
								</div>
								<div class="countDiv info-Div">${one.readcount}</div>
							</div>
							<div class="info-Div">
								<div class="info-Div">
									<img class="icon-sm" alt="chat-icon" src="/image/heart-icon.png">
								</div>
								<div class="countDiv info-Div">${one.likecount}</div>
							</div>
							<!-- 실패 -->
							<%-- <div class="chat icon-sm">&nbsp;&nbsp;${one.readcount}</div>
							<div class="dibs icon-sm">&nbsp;&nbsp;${one.likecount}</div> --%>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</c:if>
	</div>
</div>
