<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="/css/join_style.css">
<div class="join-intro">
	<div class="title-div">
		<p class="tit"><span>바니마켓</span> 에 오신것을 환영합니다!</p>
		<p class="txt">바니마켓 회원 가입 하신 후<br/> 바니마켓의 다양한 서비스를 누리세요!</p>
		<a href="./addForm?type=general" class="btn-list join-btn">회원가입</a>
		<a href="javascript:" class="admin-btn" onclick="popOpen('#adminPop')">관리자이신가요?</a>
	</div>
</div>

<div class="popup-modal" id="adminPop">
	<div class="modal">
		<div class="modal-title">관리자 코드입력</div>
		<div class="modal-content">
			<p class="txt">관리자만 접근가능합니다.<br/> 코드를 입력해주세요.</p>
			<div class="admin-code">
				<input type="text" name="admin-code" placeholder="관리자 코드 입력">	
			</div>
			<div class="btn-wrap">
				<a href="javascript:" class="btn-add admin-code-btn">확인</a>
			</div>
		</div>
		<button type="button" class="modal-close">닫기</button>
	</div>
</div>

<script type="text/javascript" src="/js/join_script.js"></script>