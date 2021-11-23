<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="/css/notice.css">

<form action="update" method="post" enctype="multipart/form-data">

	<div class="notice">
			<button type="button" onclick="location.href='writeform'">목록</button>
			<button type="submit">저장</button>
		
		<table class="writeform">
			<tr>
				<th>
					<input type="text" placeholder="제목을 입력하세요" required="required">
				</th>
			</tr>
			<tr>
				<td>
					<textarea required="required" placeholder="내용을 입력하세요"></textarea>
				</td>
			</tr>
		</table>
	</div>
	</form>

