<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="/css/login_style.css">
<meta name="google-signin-client_id" content="1022410013339-9831cpvsfdoqrhke57gqr9h1qmapandt.apps.googleusercontent.com">
<div class="login-div">
	<div class="sns-login">
		<a href="javascript:" class="google">
			<p class="g-signin2" data-onsuccess="onSignIn">구글 간편로그인</p>
			<button type="button" onclick="signOut();">Logout</button>
		</a>
		<a href="javascript:" class="naver">네이버 간편로그인</a>
		<a href="javascript:" class="kakao">카카오 간편로그인</a>
	</div>
	<div class="login-form">
		<form action="/login/action" id="loginFrm" name="loginFrm" method="post">
			<div class="form-div">
				<input type="text" name="username" id="username" placeholder="ID 입력" required="required"/>
			</div>
			<div class="form-div">
				<input type="password" name="password" id="password" placeholder="PASSWORD 입력" required="required"/>
			</div>
			<div class="form-div">
				<div class="check-box">
					<input type="checkbox" name="remember-me" id="rememberMe" />
					<label for="rememberMe">아이디 저장</label>
				</div>
				<div class="find">
					<a href="/find/idform" class="id-find">아이디</a>
					<a href="/find/pwform" class="pw-find">비밀번호 찾기</a>
				</div>
			</div>
			<div class="btn-wrap">
				<a href="javascript:loginFrmSubmit();" class="btn-add login-btn">로그인</a>
				<a href="/join/main" class="btn-list join-btn">회원가입</a>
			</div>
		</form>
	</div>
</div>
<c:if test="${error!=null}">
	<script type="text/javascript">
		alert("회원정보가 일치하지 않습니다.");
	</script>
</c:if>
<script type="text/javascript" src="http://apis.google.com/js/platform.js" async defer></script>
<script src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.0/jquery.validate.js"></script>
<script type="text/javascript" src="/js/login_script.js"></script>
