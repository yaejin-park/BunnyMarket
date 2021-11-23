<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="/css/community_style.css">
<div class="inner">
	
	<div class="commu-list">
		<ul>
		<c:if test="${totalCount==0}">
			<div class="nodata">
				<p class="icon">
					<img alt="" src="/image/nodata-icon.png">
				</p>
				<p>등록된 글이 없습니다</p>
			</div>
		</c:if>
		
		<c:if test="${totalCount>0}">
			<div class="yesdata">
			<c:forEach var="a" items="${commulist}">
				<li>
					<a href="detail?idx=${a.idx}&currentPage=${currentPage}&key=list">
						<div class="image">
							<img src="../photo/${a.photo[0]}">
						</div>
						<div class="text-div">
							<p class="tit">${a.title}</p>
							<p class="txt">${a.content}</p>
							<p class="date">
							<fmt:formatDate value="${a.writeday}" pattern="yy.MM.dd"/>
							</p>
						</div>
					</a>
				</li>
			</c:forEach>
			</div>
		</c:if>
		
		<div class="top-div btn-wrap">
		 	<button type="button" class="btn-add"
					onclick="location.href='writeform'">글쓰기</button>
		</div>
		
		
		</ul>
	</div>
</div>

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

<script type="text/javascript">
	
	function firstimg(){
		var fimg = document.getElementByid("img[0]").src;
	}

</script>
