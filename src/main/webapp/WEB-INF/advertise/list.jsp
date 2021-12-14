<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<link rel="stylesheet" type="text/css" href="/css/ad_style.css">
<div class="inner">
	<sec:authorize access="isAuthenticated()">
		<div class="top-div add-btn-wrap">
			<button type="button" class="btn-add" onclick="location.href='./auth/insertform'">글쓰기</button>
		</div>
	</sec:authorize>
	
	<c:if test="${totalCount==0}">
		<div class="nodata">
			<p class="icon">
				<img alt="" src="/image/nodata-icon.png">
			</p>
			<p>등록된 데이터가 없습니다.</p>
		</div>		
	</c:if>
	<c:if test="${totalCount>0}">
		<ul class="event-list ad-list">
			<c:forEach var="addto" items="${list}">
				<li>
					<a href="detail?idx=${addto.idx}&currentPage=${currentPage}&key=list">
						<span></span>
						<div class="img-div">
							<img alt="thumnail" src="../photo/${fn:split(addto.photo,',')[0]}">
						</div>
						<div class="txt-div">
							<p class="list-tit">${addto.title}</p>
							<p class="date">
								<fmt:formatDate value="${addto.writeday}" pattern="yy.MM.dd"/>
							</p>
							<div class="ect">
								<p class="read-count">조회수${addto.readcount}</p>
							</div>
						</div>
					</a>
				</li>
			</c:forEach>
		</ul>
	</c:if>	
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
<script type="text/javascript" src="/js/event_script.js"></script>
<script type="text/javascript" src="/js/advertise_script.js"></script>
