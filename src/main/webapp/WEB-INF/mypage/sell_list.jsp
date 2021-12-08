<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="/css/mypage_style.css">

<div class="sell-list">
	<div class="inner">
		<div class="sell-condition">
			<input type="button" id="button" name="button"
			value="판매중" class="btn-list selling">
			<input type="button" id="button" name="button"
			value="예약중" class="btn-list reserving">
			<input type="button" id="button" name="button"
			value="판매완료" class="btn-list soldout">
		</div>
		<div class="myselling-list">
			<!-- 등록된 상품이 있을경우 -->
			<c:if test="${totalCount>0}">
			<table class="table">
				<thead>
					<tr>
						<th>카테고리</th>
						<th>상품이미지</th>
						<th>상품 정보</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="pd" items="${list}" varStatus="status">
						<tr>
							<td><c:out value="${pd.uploadfile[0]}"/></td>
							<td>
							<c:out value="${pd.category}"/>
							<c:out value="${pd.title}"/>
							<c:out value="${pd.price}"/>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			</c:if>
			
			<!-- 등록된 판매상품이 없으면 -->
			<c:if test="${recount==0}">
				<div class="nodata">
					<p class="icon">
						<img alt="" src="/image/nodata-icon.png">
					</p>
					<p>등록된 상품이 없습니다.</p>
				</div>
			</c:if>
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
	</div>
</div>

<script type="text/javascript" src="/js/mypage_script.js">

</script>
