<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="/css/community_style.css">
<div class="write-form commu-div">
	<div class="inner">
	<form action="insert" method="post" enctype="multipart/form-data">
			<div class="group">
				<div class="child tit">
					이미지<span class="must">*</span>
				</div>
				<div class="child img-upload">
					<div class="form-group upload-img">
						<label for="chooseFile"> 
						<img src="/image/imageadd.jpg">
						</label> 
						<input type="file" id="chooseFile" name="photo-upload" class="img-input" multiple="multiple"/>
					</div>
					<div class="preview-area"></div>
				</div>
			</div>
			<div class="group">
				<div class="child tit">
					제목<span class="must">*</span>
				</div>
				<div class="child">
					<input type="text" name="title" class="sub-input"
						required="required" placeholder="글제목" maxlength="30">
				</div>
			</div>
			<div class="group">
				<div class="child tit">
					내용<span class="must">*</span>
				</div>
				<div class="child">
					<textarea class="text-input" name="content" required="required"
						placeholder="설명을 입력해주세요(500자미만)" maxlength="500"></textarea>
				</div>
			</div>
			<div class="btn-wrap">
				<button type="button" class="btn-add event-add-btn">글쓰기</button>
				<button type="button" class="btn-list"
					onclick="location.href='list'">목록</button>
			</div>
	</form>
	</div>
</div>


<script type="text/javascript" src="/js/community_script.js"></script>















