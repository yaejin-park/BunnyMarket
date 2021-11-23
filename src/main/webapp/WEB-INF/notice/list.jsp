<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" type="text/css" href="/css/notice.css">
<script type="text/javascript" src="/js/notice_script.js"></script>
<div class="inner">
	<!-- 관리자가 로그인 했을 떄만 버튼 나타남 -->
	<!--<c:if test="${dto.type==admin}">-->
		<button class="btn-add" type="button"
			onclick="location.href='writeform'">글쓰기</button>
		<button class="btn-delete" type="button" id="delete">글삭제</button>
		<br>
		<br>
	<!--</c:if>-->

	<table class="table">
		<thead>
			<tr>
				<!-- 관리자가 로그인 했을 떄만 체크박스로 변경 -->
					<c:choose>
						<c:when test="${dto.type==admin}">	
							<th class="num"><input type="checkbox" value="selectall" onclick="selectAll(this)"></th>
						</c:when>
						<c:otherwise>
							<th class="num">번호</th>
						</c:otherwise>
					</c:choose>		
			
				<th class="title">제목</th>
				<th class="writeday">작성일</th>
				<th class="readcount">조회수</th>
			</tr>
		</thead>
		
		<!-- 작성글 없을 떄 -->
		<c:if test="${totalCount==0}">
		
				<tbody>
					<div class="nodata">
						<p class="icon">
							<img alt="" src="/image/nodata-icon.png">
						</p>
							<p>등록된 데이터가 없습니다.</p>
					</div>
				</tbody>
			
		</c:if>
		
		 <c:if test="${totalCount>0}">
		
			<c:forEach var="n" items="${list}">
				<tbody>
				    <%--  <tr>
					   <c:choose>
						<c:when test="${n.type==admin}">
							<td><input type="checkbox" name="delete"></td>
						</c:when>
						<c:otherwise>
							<td>{n.idx}</td>
						</c:otherwise>
					</c:choose> 
					
				
				</tr>
			 --%>
					<tr>
						<td><input type="checkbox" name="del" id="${n.idx}"></td>
						<td> <a href="content?idx=${n.idx}&currentPage=${currentPage}&key=list"
						>${n.title}</a> </td>
						<td><fmt:formatDate value="${n.writeday}" pattern="yy.MM.dd" /></td>
						<td>${n.readcount}</td>
					</tr> 
		
	
				</tbody>
			</c:forEach>
		</c:if> 
		</table>
		</div>
		
		<div class="inner">

	<div class="btn-div">

	<c:if test="${totalCount>0}">
		<div class="paging">
			<a href="javascript:" class="prev"><span>이전</span></a>
			<ul>
			

				<c:forEach var="p" begin="${startPage}" end="${endPage}">
					<c:if test="${currentPage==p}">
						<!-- 선택한 페이지 -->
						<li><a href="list?currentPage=${p}">${p}</a>
					</c:if>
					<c:if test="${currentPage!=p}">
						<li><a href="list?currentPage=${p}">${p}</a>
					</c:if>
				</c:forEach>

	
				
				




			</ul>
			<a href="javascript:" class="next"><span>다음</span></a>
		</div>


	</c:if>
	</div>
	</div>











