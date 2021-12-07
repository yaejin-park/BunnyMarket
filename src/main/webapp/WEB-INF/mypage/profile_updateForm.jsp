<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="/css/mypage_style.css">
<div class="myprofile-form">
	<div class="inner">
		<div class="my-page">
			<!-- 프로필 이미지 선택 -->
			<div class="profile-update">
				<label for="select-img">
					<div class="profile-img">
						<!-- 프로필 이미지 있을때 -->
						<c:if test="true">
							<img alt="프로필이미지" src="/image/profile-icon.png">
						</c:if>
						<!-- 프로필 이미지 없을때 -->
						<c:if test="false">
							<img alt="프로필이미지" src="/image/profile-icon.png">
						</c:if>
					</div>
				</label>
				<input type="file" id="select-img" name="profile-upload" class="profile-input">
			</div>			
			<div class="my-info">
				<input type="text" class="profile-name">
			</div>
			<div class="my-info-update">
				<button type="button" class="btn-update">변경하기</button>
				<button type="button" class="btn-list" onclick="location.href='detail'">취소</button>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="/js/mypage_script.js"></script>