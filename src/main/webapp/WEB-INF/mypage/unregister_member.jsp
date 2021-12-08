<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="/css/mypage_style.css">
<div class="unregister-form">
	<div class="inner">
		<div class="unregi-image">
			<img alt="" src="/image/unregister.png">
		</div>
		<div class="unregi-message">
			<span class="unregi-msg1">
			[닉네임]님, 정말 탈퇴를 원하시나요?
			</span>
			<span class="unregi-msg2">
			계정을 삭제하면 게시글,채팅,관심상품 등 모든활동 정보가
			삭제됩니다.계정 삭제 후 7일간 다시 가입할수 없어요.
			</span>
		</div>
		<div class="unregi-question">
			<span class="unregi-ques">
			[닉네임]님, 계정을 탈퇴하려는 이유가 궁금해요.
			</span>
			<select name='unregi-reason' class="unregi-reason">
  				<option value='' selected="selected">----- 선택해주세요 -----</option>
 				<option value='reason1'>너무 많이 이용해요.</option>
 				<option value='reason2'>사고싶은 물품이 없어요.</option>
 				<option value='reason3'>물건이 너무 안팔려요.</option>
 				<option value='reason4'>비매너 사용자를 만났어요.</option>
 				<option value='reason5'>새계정을 만들고 싶어요.</option>
 				<option value='reason6'>[기타]</option>
			</select>
			<div class="btn">
			<button type="button" id="go-unregi" class="btn-add">탈퇴하기</button>
			<button type="button" id="unregi-cancel" class="btn-list"
			onclick="location.href='mypage'">취소</button>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="/js/mypage_script.js"></script>