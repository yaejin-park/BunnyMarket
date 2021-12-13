<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="/css/notice_style.css">
<div class="inner" id="form">

	<form action="insert" method="post" enctype="multipart/form-data">


		<table class="insert-table">
			<tr>
				<th><label>제목</label><br> <input type="text"
					required="required" placeholder="제목을 입력하세요" name="title"
					class="title">
					<div class="file-div">


						<input multiple="multiple" type="file" name="upload" class="file">
					</div></th>
			</tr>


			<tr>

				<td><label>내용</label><br> <textarea required="required"
						placeholder="내용을 입력하세요" name="content" class="content"></textarea>
				</td>
			</tr>
		</table>
		<div class="btn-wrap">
			<button type="button" onclick="location.href='list'" class="btn-list" id="btn">목록</button>
			<button type="submit" class="btn-add" id="btn">저장</button>

		</div>
	</form>
</div>

<script type="text/javascript" src="/js/notice_script.js"></script>



