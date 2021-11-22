<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="login-div">
	<div class="sns-login">
		<a href="kakao-login">카카오 간편로그인</a>
		<a href="naver-login">네이버 간편로그인</a>
	</div>
	<div class="login-form">
		<div>
			<input type="text" name="id" placeholder="ID 입력" />
		</div>
		<div>
			<input type="password" name="pw" placeholder="PASSWORD 입력" />
		</div>
	</div>
</div>
