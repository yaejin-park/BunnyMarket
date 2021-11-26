<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" type="text/css" href="/css/notice_style.css">

<div class="inner">
	<input type="hidden" name="idx" value="${dto.idx}" id="idx"> <input
		type="hidden" name="currentPage" value="${currentPage}"
		id="currentPage">
	


	<table class="table" id="ctable">

		<thead>
			<tr>
				<th>제목&nbsp;&nbsp;${dto.title}</th>
				<th>작성일&nbsp;&nbsp;<fmt:formatDate value="${dto.writeday}"
						pattern="yy.MM.dd" /></th>
				<th>조회수&nbsp;&nbsp;${dto.readcount}</th>
			</tr>
		</thead>
		<tbody class="content">

			<tr>
				<td class="contenttxt" colspan="3">${dto.content}</td>
			</tr>
		</tbody>





	</table>
	<div class="btn-wrap">
		<button type="button" class="btn-list" onclick="location.href='list'">목록</button>
		<button class="btn-update"
			onclick="location.href='updateform?idx=${dto.idx}&currentPage=${currentPage}'">수정</button>
		<button class="btn-delete" id="delete2">삭제</button>
	</div>

</div>
<script type="text/javascript" src="/js/notice_script.js"></script>