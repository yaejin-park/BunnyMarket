<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 <link rel="stylesheet" type="text/css" href="/css/notice.css">

	<div class="inner">
		<button type="button" class="btn-default" onclick="location.href='list'">목록</button>
		<button class="btn-update">수정</button>
		<button class="btn-delete" onclick="location.href='delete?idx=${dto.idx}&currentPage=${currentPage}'">삭제</button>
		<br><br>
		
			<table class="table">
		
			<thead>
				<tr>	
					<th>타이틀&nbsp;&nbsp;${dto.title}</th>
					<th>작성일&nbsp;&nbsp;<fmt:formatDate value="${dto.writeday}" pattern="yy.MM.dd"/></th>
					<th>조회수&nbsp;&nbsp;${dto.readcount}</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>${dto.content}</td>
				</tr>
			</tbody>
			
	
			
		
		
		</table>
			
	</div>
