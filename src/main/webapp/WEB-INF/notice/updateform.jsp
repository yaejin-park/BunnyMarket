<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="/css/notice_style.css">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<form action="update" method="post" enctype="multipart/form-data">
	<input type="hidden" name="idx" value="${dto.idx}"> <input
		type="hidden" name="currentPage" value="${currentPage}">





	<div class="inner" id="form">


		<table class="update-table">

			<thead>
				<tr>
					<th><label>제목</label> <input type="text" name="title"
						required="required" value="${dto.title}" class="title">
						<div class="filebox">
							<input type="file" id="ex_file" name="upload" class="file"
								multiple="multiple">



						</div></th>
				</tr>
			</thead>


			<tbody>
				<tr>
					<td><label>내용</label> <textarea required="required"
							name="content" class="content">${dto.content}</textarea></td>


				</tr>
			</tbody>


		</table>
	</div>
	<div class="btn-wrap">
		<button type="button" onclick="history.back()" class="btn-default" >이전</button>
		<button type="submit" class="btn-add"
			onclick="location.href='content?idx=${dto.idx}&currnetPage=${currentPage}&key=list'" >저장</button>
	</div>
</form>

<script type="text/javascript" src="/js/notice_script.js"></script>
