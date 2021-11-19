<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="/css/notice.css">
<link rel="stylesheet" href="/css/main.css">



	<div class="inner">
		<c:if test="${dto.type==admin}"> 
			<button type="button" onclick="" >글작성</button>
			<button type="button" onclick="" >글삭제</button>
		</c:if>
			
		
		
		<table>
			<tr>
				<c:choose>
					<c:when test="${dto.type==admin}">
						<th class="no"> <input type="checkbox"></th>
					</c:when>
					<c:otherwise>
						<th class="no">번호</th>
					</c:otherwise>
				</c:choose>
					<th class="title">제목</th>
					<th class="content">내용</th>
					<th class="writeday">작성일</th>
					<th class="readcount">조회수</th>
			</tr>
				
					<c:if test="${totalCount==0}">
						<tr>
							<td colspan="5">작성글이 없습니다</td>
						</tr>
					</c:if>
					<c:if test="${totalList>0}">
						<tr>
							<c:choose>
								<c:when test="${dto.type==admin}">
									<td><input type="checkbox" name="delete"></td>
								</c:when>
								<c:otherwise>
									<td>{dto.idx}</td>
								</c:otherwise>
							</c:choose>
					<td>
				<a href="content?num=${dto.idx}&currentPage=${currentPage}&key=list" style="color: black;">
					${dto.title} </a>
					 </td>
					<td>${dto.content}</td>
					<td><fmt:formatDate value="${dto.writeday}" pattern="yy.MM.dd"/></td>
					<td>${dto.read_count}</td>
			</tr>
					</c:if>
		</table>
		
				<div>
				
				
				</div>
				<div class="modal">
					<b>총$("input:checkbox[name='delete']:checked").length개의 게시글을 삭제하시겠습니까?</b>
					<button>Yes</button> <button>No</button>	
				</div>
		</div>
		
				

	

