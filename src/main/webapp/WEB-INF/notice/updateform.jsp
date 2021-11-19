<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<form action="update" method="post" enctype="multipart/form-data">

	<div class="notice">
			<button type="button" onclick="">목록</button>
		<div class="tempsave">
			<button type="submit">임시저장</button>
			<button type="button" onclick=""></button>
		</div>
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

