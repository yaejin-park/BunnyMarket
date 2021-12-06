<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="/css/find_member_style.css">
<div class="find-member-div">
	<div class="tab-btn">
		<div class="inner">
			<a href="/find/idform">아이디찾기</a>
			<a href="/find/pwform" class="active">비밀번호 찾기</a>
		</div>
	</div>
	<div class="find-form-div">
		<div class="form-div">
			<input type="text" name="user_id" id="user_id" placeholder="가입된 아이디 입력" required="required"/>
		</div>
		<div class="form-div">
			<input type="text" name="user_name" id="user_name" placeholder="이름 입력" required="required"/>
		</div>
		<div class="email-div">
			<div class="form-div">
				<input type="text" name="user_email1" placeholder="E-mail 입력" required="required"/>
				<span>@</span>
			</div>
			<div class="has-btn-type form-div">
				<select name="user_email_choose">
					<option>선택</option>
					<option value="">직접입력</option>
					<option value="naver.com">naver</option>
					<option value="gmail.com">google</option>
					<option value="nate.com">nate</option>
					<option value="daum.net">daum</option>
				</select>
				<button type="button" class="btn-list btn-sm email-send-btn">E-mail 전송</button>
			</div>
			<div class="form-div">
				<input type="text" name="user_email2" placeholder="ex)email.com" required="required"/>
			</div>
		</div>
		<div class="email-certify form-div">
			<input type="text" name="email_certify" placeholder="인증번호 입력" required="required" />
			<button type="button" class="btn-list btn-sm email-check-btn">E-mail 인증</button>
			<p class="msg"></p>
		</div>
		
		<div class="btn-wrap">
			<button type="button" class="btn-add find-pw-btn">찾기</button>
		</div>
	</div>
</div>
<div class="popup-modal" id="findPwPop">
	<div class="modal">
		<div class="modal-title">비밀번호 결과</div>
		<div class="modal-content">
			 <p class="tit">임시 비밀번호</p>
			 <p>로그인 후 비밀번호를 변경해주세요.</p>
			 <p class="result"></p>
			 <div class="btn-wrap">
			 	<a href="/login/main" class="btn-list">로그인하러 가기</a>
			 </div>
		</div>
		<button type="button" class="modal-close">닫기</button>
	</div>
</div>
<script type="text/javascript" src="/js/findMember_script.js"></script>