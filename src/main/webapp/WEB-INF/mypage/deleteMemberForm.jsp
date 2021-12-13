<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="/css/swiper.min.css">
<link rel="stylesheet" type="text/css" href="/css/mypage_style.css">

<div class="mydetail-form">
	<div class="inner">
		<div class="swiper side-menu-div">
			<div class="swiper-wrapper">
				<a href="/mypage/auth/detail" class="swiper-slide">내정보</a>
				<a href="/mypage/auth/sellList" class="swiper-slide">판매내역</a>
				<a href="/mypage/auth/followlist" class="swiper-slide">모아보기</a>
				<a href="javascript:" class="swiper-slide">나의후기</a>
				<a href="/mypage/auth/productlike" class="swiper-slide">관심목록</a>
				<a href="/mypage/auth/member/updateform" class="swiper-slide">회원수정</a>
				<a href="/mypage/auth/member/deleteform" class="swiper-slide active">회원탈퇴</a>
			</div>
		</div>
		
		<div class="unregister-form">
			<div class="unregi-image">
				<img alt="" src="/image/unregister.png">
			</div>
			<div class="unregi-message">
				<span class="unregi-msg1">
				[${userNickName}]님, 정말 탈퇴를 원하시나요?
				</span>
				<span class="unregi-msg2">
				계정을 삭제하면 게시글, 채팅, 관심상품 등 모든활동 정보가 삭제됩니다.
				</span>
			</div>
			<div class="unregi-question">
				<span class="unregi-ques">
				[${userNickName}]님, 계정을 탈퇴하려는 이유가 궁금해요.
				</span>
				<select name='unregi-reason' class="unregi-reason">
		 				<option selected="selected">----- 선택해주세요 -----</option>
						<option>너무 많이 이용해요.</option>
						<option>사고싶은 물품이 없어요.</option>
						<option>물건이 너무 안팔려요.</option>
						<option>비매너 사용자를 만났어요.</option>
						<option>새계정을 만들고 싶어요.</option>
						<option>[기타]</option>
				</select>
				<div class="btn">
				<button type="button" id="go-unregi" class="btn-add">탈퇴하기</button>
				<button type="button" id="unregi-cancel" class="btn-list"
				onclick="history.back()">취소</button>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="/js/swiper.min.js"></script>
<script type="text/javascript" src="/js/mypage_script.js"></script>