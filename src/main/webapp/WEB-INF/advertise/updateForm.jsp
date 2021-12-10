<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="/css/ad_style.css">
<div class="write-form ad-div update">
	<input type="hidden" name="idx" value="${dto.idx}">
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
					<input type="hidden" name="photo" value="${dto.photo}">
					<c:forEach var="photo" items="${photoList}">
						<div class="preview-img">
							<img alt="" src="/photo/${photo}">
							<span class="close"></span>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
		<div class="group">
			<div class="child tit">
				제목 <span class="must">*</span>
			</div>
			<div class="child">
				<input type="text" name="title" class="sub-input" placeholder="글제목" value="${dto.title}">
			</div>
		</div>
		<div class="group">
			<div class="child tit">
				설명 <span class="must">*</span>
			</div>
			<div class="child">
				<textarea name="content" class="text-input" placeholder="설명을 입력해주세요.">${dto.content}</textarea>
			</div>
		</div>
		<div class="btn-wrap">
			<button type="button" class="btn-add ad-update-btn">수정하기</button>
			<button type="button" class="btn-list" onclick="location.href='/advertise/detail?idx=${dto.idx}'">취소하기</button>
		</div>
	</div>
</div>
<script type="text/javascript" src="/js/advertise_script.js"></script>