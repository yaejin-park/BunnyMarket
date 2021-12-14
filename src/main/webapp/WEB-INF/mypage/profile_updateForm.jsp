<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="/css/mypage_style.css">
<div class="myprofile-form profile-div">
<form action="profileupdate" method="post" enctype="multipart/form-data">
	<div class="inner">
		<div class="my-page">
			<div class="profile-update">
				<label for="select-img">
					<div class="profile-img">
						<c:if test="${profile =='no'}">
							<img alt="프로필이미지" src="/image/profile-icon.png">
						</c:if>
						<c:if test="${profile !='no'}">
							<img alt="프로필이미지" src="/photo/${profile}">
						</c:if>
					</div>
				</label>
				<input type="file" id="select-img" name="profile" class="profile-input"/>
			</div>
			<div class="preview-area"></div>
			<div class="my-info-div">
				<div class="my-info">
					<input type="text" name="nickname" class="profile-name" value="${userNickName}">
				</div>
				<div class="profile-msg">
					<p>프로필 사진과 닉네임을 입력해주세요.</p>
				</div>
				<div class="my-info-update">
					<button type="submit" class="btn-update profile-btn">변경하기</button>
					<button type="button" class="btn-list" onclick="location.href='detail'">취소</button>
				</div>
			</div>
		</div>
	</div>
</form>
</div>
<script type="text/javascript" src="/js/mypage_script.js"></script>