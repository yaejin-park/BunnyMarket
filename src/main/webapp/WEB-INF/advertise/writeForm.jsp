<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<link rel="stylesheet" type="text/css" href="/css/ad_style.css">
<div class="write-form ad-div">
	<div class="inner">
		<div class="group">
			<div class="child tit">
				이미지 <span class="must">*</span>
			</div>
			<div class="child img-upload">
				<div class="form-group upload-img">
					<label for="chooseFile"> 
						<img src="/image/write-upload-icon.JPG" alt="이미지 등록">
					</label>
					<input type="file" id="chooseFile" name="photoupload" class="img-input" multiple="multiple"/>
				</div>
				<div class="preview-area">
					<c:forEach var="photo" items="${dto.photo}">
						<img src="/photo/${photo}" alt="">
					</c:forEach>
				</div>
			</div>
		</div>
		<div class="group">
			<div class="child tit">
				제목 <span class="must">*</span>
			</div>
			<div class="child">
				<input type="text" name="title" class="sub-input" placeholder="글제목">
			</div>
		</div>
		<div class="group">
			<div class="child tit">
				설명 <span class="must">*</span>
			</div>
			<div class="child">
				<textarea name="content" class="text-input" placeholder="설명을 입력해주세요."></textarea>
			</div>
		</div>
		<div class="btn-wrap">
			<button type="button" class="btn-add ad-add-btn" value="${dto.idx}">글쓰기</button>
			<button type="button" class="btn-list" onclick="location.href='/advertise/list'">취소하기</button>
		</div>
	</div>
</div>
<script type="text/javascript" src="/js/advertise_script.js"></script>