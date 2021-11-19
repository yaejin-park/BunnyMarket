<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="/css/ad_style.css">
<div class="inner">
	<form method="post" enctype="multipart/form-data">
		<div class="group">
			<div class="imgupload">
				<label for="selectImg"> 
				<img class="uploadImg" src="../image/write-upload-icon.JPG">
				</label>
			</div>
			<input type="file" id="selectImg" name="selectImg" accept="image/*"
				onchange="loadFile(this)" style="visibility: hidden;">
		</div>
	</form>
		
	<div class="group">
		<div class="child">
			제목<span class="must">*</span> 
		</div>
		<div class="child">
			<input type="text" placeholder="글제목">
		</div>
	</div>
	<div class="group">
		<div class="child">
			설명<span class="must">*</span>
		</div>
		<div class="child">
			<textarea></textarea>		
		</div>
	</div>
</div>