<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="/css/notice.css">

<form action="update" method="post" enctype="multipart/form-data">
	<input type="hidden"  name="idx" value="${dto.idx}">
	<input type="hidden" name="currentPage" value="${currentPage}">





	<div class="inner" id="inner">
	
		<div class="btn-wrap">
		<button type="button" onclick="history.back()" class="btn-default nbtn" id="back" >이전</button>
		<button type="submit" class="btn-add nbtn" onclick="location.href='content?idx=${dto.idx}&currnetPage=${currentPage}&key=list'">저장</button>
		</div>
		<table>

			<thead>
				<tr>
					<th><label>제목</label> <input type="text" required="required"
						value="${dto.title}" name="title"></th>
				</tr>
			</thead>


			<tbody>
				<tr>
					<td><label>내용</label> 
					<textarea required="required" name="content" class="text-input">${dto.content}</textarea></td>
				</tr>
			</tbody>


		</table>
	</div>
</form>

<script type="text/javascript" src="/js/notice_script.js"></script>
