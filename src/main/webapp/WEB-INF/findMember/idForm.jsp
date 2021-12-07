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
		<div class="form-div">
			<input type="text" name="user_name" id="user_name" placeholder="이름 입력" />
		</div>
		<div class="form-div">
			<input type="text" name="user_hp" id="user_hp" placeholder="휴대전화 번호를 -포함해서 입력" />
		</div>
		<div class="btn-wrap">
			<button type="button" class="btn-add find-id-btn">찾기</button>
		</div>
	</div>
</div>
<div class="popup-modal" id="findIdPop">
	<div class="modal">
		<div class="modal-title">아이디 결과</div>
		<div class="modal-content">
			 <p class="tit">아이디</p>
			 <p class="result"></p>
		</div>
		<button type="button" class="modal-close">닫기</button>
	</div>
</div>
<script type="text/javascript" src="/js/findMember_script.js"></script>