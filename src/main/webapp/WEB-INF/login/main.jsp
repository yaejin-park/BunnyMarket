<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="/css/login_style.css">
<div class="login-div">
	<div class="sns-login">
		<a href="javascript:" class="google">구글 간편로그인</a>
		<a href="javascript:" class="naver">네이버 간편로그인</a>
		<a href="javascript:" class="kakao">카카오 간편로그인</a>
	</div>
	<div class="login-form">
		<div class="form-div">
			<input type="text" name="id" placeholder="ID 입력" />
		</div>
		<div class="form-div">
			<input type="password" name="pw" placeholder="PASSWORD 입력" />
		</div>
		<div class="form-div">
			<div class="check-box">
				<input type="checkbox" name="saveid" id="saveId"/>
				<label for="saveId">아이디 저장</label>
			</div>
			<div class="find">
				<a href="javascript:" class="id-find">아이디</a>
				<a href="javascript:" class="pw-find">비밀번호 찾기</a>
			</div>
		</div>
	</div>
	<div class="btn-wrap">
		<a href="javascript:" class="btn-add">로그인</a>
		<a href="javascript:" class="btn-list">회원가입</a>
	</div>
</div>