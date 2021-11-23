<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<link rel="stylesheet" type="text/css" href="/css/communitywf_style.css">
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>

<div class="inner">
	<form action="insert" method="post" enctype="multipart/form-data">
		<div class="group">
			<div class="child tit">
				이미지<span class="must">*</span>
			</div>
			<div class="child">
				<label for="chooseFile">
					<img src="/image/imageadd.jpg">
				</label>
				<input type="file" class="imgInput" name="upload" id="chooseFile" accept="image/*" onchange="loadFile(event)" 
				multiple="multiple" hidden="hidden">
				<div class="previewarea"></div>
			</div>
		</div>
		<div class="group">
			<div class="child tit">
				제목<span class="must">*</span>
			</div>
			<div class="child">
				<input type="text" name="title" class="subinput" required="required" placeholder="제목 입력" maxlength="20">
			</div>
		</div>
		<div class="group">
			<div class="child tit">
				내용<span class="must">*</span>
			</div>
			<div class="child">
				<textarea class="textinput" name="content" required="required" placeholder="내용을 입력하세요" ></textarea>
			</div>
		</div>
		<div class="write-btn">
			<button type="submit" class="btn-add">글쓰기</button>
			<button type="button" class="btn-list"
			onclick="location.href='list'">목록</button>
		</div>
	</form>
</div>











