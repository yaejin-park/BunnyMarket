<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="/css/communitywf_style.css">
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<div class="inner">
	<form action="insert" method="post" enctype="multipart/form-data">
		<div class="group">
			<div class="child">
				이미지<span class="star">*</span>
			</div>
				<div class="child img-div">
					<label for="chooseFile">
						<img src="/image/imageadd.jpg">
					</label>
				</div>
				<input type="file" class="chooseFile" accept="image/*" onchange="loadFile(this)">
			</div>
		<div class="group">
			<div class="child">
			제목<span class="star">*</span>
			</div>
			<div class="child">
				<input type="text" required="required" placeholder="제목 입력" maxlength="20">
			</div>
			
			<div class="child">
			내용<span class="star">*</span>
			</div>
			<div class="child">
				<textarea placeholder="내용을 입력하세요" maxlength="500"/>
			</div>
		</div>
	</form>
</div>

