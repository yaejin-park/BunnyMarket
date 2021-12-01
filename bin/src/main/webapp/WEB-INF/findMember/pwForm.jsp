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
		<form action="checkid" method="post">
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
					<select name="user_email2">
						<option>선택</option>
						<option value="etc">직접입력</option>
						<option value="naver.com">naver</option>
						<option value="gmail.com">google</option>
						<option value="nate.com">nate</option>
						<option value="daum.net">daum</option>
					</select>
					<button type="button" class="btn-list btn-sm">E-mail 전송</button>
				</div>
				<div class="form-div">
					<input type="text" name="user_email2" placeholder="ex)email.com" required="required"/>
				</div>
			</div>
			<div class="email-certify form-div">
				<input type="text" name="email_certify" placeholder="인증번호 입력" required="required" />
				<button type="button" class="btn-list btn-sm">E-mail 인증</button>
			</div>
			<div class="btn-wrap">
				<button type="submit" class="btn-add find-btn">찾기</button>
			</div>
		</form>
	</div>
</div>