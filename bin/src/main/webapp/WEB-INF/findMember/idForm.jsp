<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="/css/find_member_style.css">
<div class="find-member-div">
	<div class="tab-btn">
		<div class="inner">
			<a href="/find/idform" class="active">아이디찾기</a>
			<a href="/find/pwform">비밀번호 찾기</a>
		</div>
	</div>
	<div class="find-form-div">
		<form action="checkid" method="post">
			<div class="form-div">
				<input type="text" name="user_name" id="user_name" placeholder="이름 입력" required="required"/>
			</div>
			<div class="form-div">
				<input type="password" name="user_hp" id="user_hp" placeholder="휴대전화 번호를 -없이 입력" required="required"/>
			</div>
			<div class="btn-wrap">
				<button type="submit" class="btn-add find-btn">찾기</button>
			</div>
		</form>
	</div>
</div>