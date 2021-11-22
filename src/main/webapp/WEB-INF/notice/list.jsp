<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="/css/notice.css">




	<div class="inner">
		<c:if test="${dto.type==admin}"> 
			<button class="btn-add" type="button" onclick="" >글쓰기</button>
			<button class="btn-delete" type="button" onclick="" >글삭제</button>
		</c:if>
			
		
		
		<table class="ntable">
			<tr>
				<c:choose>
					<c:when test="${dto.type==admin}">
						<th class="num"> <input type="checkbox"></th>
					</c:when>
					<c:otherwise>
						<th class="num">번호</th>
					</c:otherwise>
				</c:choose>
					<th class="title">제목</th>
					<th class="writeday">작성일</th>
					<th class="readcount">조회수</th>
			</tr>
				
					<c:if test="${totalCount==0}">
						<tr>
							<td colspan="4">작성글이 없습니다</td>
						</tr>
					</c:if>
					<c:if test="${totalList>0}">
						<c:forEach var="n" items="${list}">
						<tr>
							<c:choose>
								<c:when test="${list.type==admin}">
									<td><input type="checkbox" name="delete"></td>
								</c:when>
								<c:otherwise>
									<td>{list.idx}</td>
								</c:otherwise>
							</c:choose>
					<td>
				<a href="content?num=${list.idx}&currentPage=${currentPage}&key=notice" style="color: black;">
					${list.title} </a>
					 </td>
					<td><fmt:formatDate value="${list.writeday}" pattern="yy.MM.dd"/></td>
					<td>${list.read_count}</td>
			</tr>
						</c:forEach>
					</c:if>
		</table>
		<!-- 페이징 -->
			<c:if test="${totalCount>0}">
				<div class="paging">
					<ul>
						<!-- 이전 -->
						<c:if test="${startPage>1}">
							<li><a href="list?currentPage=${startPage-1}"></a></li>
						</c:if>
						
						<c:forEach var="p" begin="${startPage}" end="${endPage}">
							<c:if test="${currentPage==p}"> 
						<!-- 선택한 페이지 -->
								<li><a href="list?currentPage=${p}">${p}</a>
							</c:if>
							<c:if test="${currentPage!=p}">
								<li><a href="list?currentPage=${p}">${p}</a>
							</c:if>
						</c:forEach>
						
						<!-- 다음 -->
						<c:if test="${endPage<totalPage}">
							<li><a href="list?currentPage=${endPage+1}"></a></li>
						</c:if>
					
					
					
					
					</ul>
				</div>
			
			
			</c:if>
		
				
		</div>
		
		<div id="modal">
			<div class="modal_content">
				<h6>총n개의 개시글을 삭제 하시겠습니까?</h6>
					<button type="submit">네</button>
					<button type="button" >아니요</button>
			<div class="layer"></div>
				
			
			
			</div>
		</div>
				

	

