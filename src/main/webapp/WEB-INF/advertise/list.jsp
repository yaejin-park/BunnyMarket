<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="/css/ad_style.css">
<div class="event-div">
	<%-- <p>${title} / ${totalcount}개</p> --%>
	<div class="inner">
		<div class="nodata">
			<c:if test="${totalCount==0}">
				<p class="icon">
					<img alt="" src="/image/nodata-icon.png">
				</p>
				<p>등록된 데이터가 없습니다.</p>		
			</c:if>
		</div>
		<ul class="event-list">
			<c:if test="${totalCount>0}">
				<c:forEach var="addto" items="${list}">
					<li>
						<a href="detail?idx=${addto.idx}&currentPage=${currentPage}&key=list">
							<div class="img-div">
								<img alt="thumbnail" src="../photo/${thumnail[0]}">		
							</div>
							<div class="txt-div">
								<p class="tit">${addto.title}</p>
								<p class="writer">작성자</p>
								<p class="date"><fmt:formatDate value="${addto.writeday}" pattern="yy.MM.dd"/></p>
								<div class="etc">
									<p class="good-count">12</p>
									<p class="read-count">6</p>
								</div>
							</div>
						</a>
					</li>
				</c:forEach>
			</c:if>
		</ul>		
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
<script type="text/javascript" src="/js/event_script.js"></script>
