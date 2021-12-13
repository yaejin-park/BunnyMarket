<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" type="text/css" href="/css/swiper.min.css">
<link rel="stylesheet" type="text/css" href="/css/mypage_style.css">
<link rel="stylesheet" type="text/css" href="/css/join_style.css">
<div class="mydetail-form join-div update-member">
	<div class="inner">
		<div class="swiper side-menu-div">
			<div class="swiper-wrapper">
				<a href="/mypage/auth/detail" class="swiper-slide">내정보</a>
				<a href="/mypage/auth/sellList" class="swiper-slide">판매내역</a>
				<a href="/mypage/auth/followlist" class="swiper-slide">모아보기</a>
				<a href="javascript:" class="swiper-slide">나의후기</a>
				<a href="/mypage/auth/productlike" class="swiper-slide">관심목록</a>
				<a href="/mypage/auth/member/updateform" class="swiper-slide active">회원수정</a>
				<a href="/mypage/auth/member/deleteform" class="swiper-slide">회원탈퇴</a>
			</div>
		</div>
		<div class="write-form">
			<form action="update" method="post" name="update-form" onsubmit="return updateFormCheck(this)">
				<div class="group">
					<div class="child tit">
						아이디
						<span class="must">*</span>
					</div>
					<div class="child">
						<div class="form-div">
							<input type="text" name="id" placeholder="ID 입력" value="${dto.id}" readonly="readonly">
						</div>
					</div>
				</div>
				<div class="group">
					<div class="child tit">
						비밀번호
						<span class="must">*</span>
					</div>
					<div class="child">
						<div class="form-div">
							<button type="button" class="btn-list" onclick="popOpen('#pwCheckPop')">변경</button>
						</div>
					</div>
				</div>
				<div class="group">
					<div class="child tit">
						이름
						<span class="must">*</span>
					</div>
					<div class="child">
						<div class="form-div">
							<input type="text" name="name" placeholder="이름 입력" value="${dto.name}" readonly="readonly">
						</div>
						<div class="info-txt">
							<p>* 공백없이 한글만 입력 가능</p>
						</div>
					</div>
				</div>
				<div class="group">
					<div class="child tit">
						닉네임
						<span class="must">*</span>
					</div>
					<div class="child">
						<div class="has-btn-type form-div">
							<input type="text" name="nickname" placeholder="닉네임 입력" required="required" value="${dto.nickname}">
							<button type="button" class="nick-check btn-list">중복확인</button>
						</div>
						<div class="info-txt">
							<p>* 공백없이 한글, 영문, 숫자만 입력 가능 (한글 2자,영문 4자 이상)</p>
						</div>
					</div>
				</div>
				<div class="group">
					<div class="child tit">
						E-mail
						<span class="must">*</span>
					</div>
					<div class="child">
						<div class="email-div form-div">
							<input type="text" name="email1" placeholder="E-mail 입력"  required="required" value="${fn:split(dto.email,'@')[0]}">
							<span>@</span>
							<input type="text" name="email2" class="etc-input" placeholder="ex) email.com" required="required" value="${fn:split(dto.email,'@')[1]}">
							<select class="domain">
								<option>선택</option>
								<option value="" value="">직접입력</option>
								<option value="naver.com">naver</option>
								<option value="gmail.com">google</option>
								<option value="nate.com">nate</option>
								<option value="daum.net">daum</option>
							</select>
							<button type="button" class="email-check btn-list">E-mail 인증</button>
						</div>
						<div class="email-certify">
							<p class="txt">인증번호를 입력해주세요.</p>
							<div class="has-btn-div form-div">
								<input type="text" name="email-certify" placeholder="인증번호 입력" required="required">
								<button type="button" class="email-certify-btn btn-list btn-sm">인증</button>
								<p class="email-msg"></p>
							</div>
						</div>
					</div>
				</div>
				<div class="group">
					<div class="child tit">
						핸드폰 번호
					</div>
					<div class="child">
						<div class="hp-div">
							<select name="hp1">
								<option>선택</option>
								<option ${fn:split(dto.hp,'-')[0]=='010'?'selected':''}>010</option>
								<option ${fn:split(dto.hp,'-')[0]=='011'?'selected':''}>011</option>
							</select>
							<span>-</span>
							<input type="text" name="hp2" placeholder="1234" maxlength="4" value="${fn:split(dto.hp,'-')[1]}">
							<span>-</span>
							<input type="text" name="hp3" placeholder="1234" maxlength="4" value="${fn:split(dto.hp,'-')[2]}">
						</div>
					</div>
				</div>
				<div class="group">
					<div class="child tit">
						주소
						<span class="must">*</span>
					</div>
					<div class="child">
						<div class="addr-div">
							<input type="hidden" name="addrLocal" value="${fn:split(dto.local,',')[0]}">
							<div class="has-btn-type form-div">
								<input type="text" name="zonecode" readonly="readonly" value="${dto.zonecode}">
								<button type="button" class="addr-search-btn btn-list" onclick="findAddr()">우편번호 검색</button>
							</div>
							<div class="form-div">
								<input type="text" name="addr1" required="required" value="${fn:split(dto.addr,',')[0]}">
							</div>
							<div class="form-div">
								<input type="text" name="addr2" value="${fn:split(dto.addr,',')[1]}">
							</div>
						</div>
					</div>
				</div>
				
				<div class="term-area">
					<div class="all-check">
						<input type="checkbox" id="termAllCheck">
						<label for="termAllCheck">전체 동의</label>
					</div>
					<div class="acco-div">
						<div class="acco-btn">
							<input type="checkbox" id="termCheck1">
							<label for="termCheck1">이용약관 동의<span>(필수)</span></label>
						</div>
						<div class="acco-con">
							<jsp:include page="../term/use.jsp"></jsp:include>
						</div>
					</div>
					<div class="acco-div">
						<div class="acco-btn">
							<input type="checkbox" id="termCheck2">
							<label for="termCheck2">개인정보처리방침 동의<span>(필수)</span></label>
						</div>
						<div class="acco-con">
							<jsp:include page="../term/privacy.jsp"></jsp:include>
						</div>
					</div>
					<div class="acco-div">
						<div class="acco-btn">
							<input type="checkbox" id="termCheck3">
							<label for="termCheck3">위치기반서비스약관 동의<span>(필수)</span></label>
						</div>
						<div class="acco-con">
							<jsp:include page="../term/location.jsp"></jsp:include>
						</div>
					</div>
				</div>
				
				<div class="btn-wrap">
					<button type="submit" class="btn-add">회원수정</a>
					<button type="button" class="btn-default">취소</a>
				</div>
			</form>
		</div>
	</div>
</div>

<div class="popup-modal" id="pwCheckPop">
	<div class="modal">
		<div class="modal-title">비밀번호 확인</div>
		<div class="modal-content">
			<div class="write-form">
				<p class="info-txt">비밀번호 변경을 위한 비밀번호 확인입니다. 비밀번호를 입력해주세요.</p>
				<div class="has-btn-type form-div">
					<input type="password" name="password" placeholder="비밀번호 입력">
				</div>
				<div class="btn-wrap">
					<button type="button" class="pw-check-btn btn-add">비밀번호 확인</button>
				</div>
			</div>
		</div>
		<button type="button" class="modal-close">닫기</button>
	</div>
</div>

<div class="popup-modal" id="pwChangePop">
	<div class="modal">
		<div class="modal-title">비밀번호 변경</div>
		<div class="modal-content">
			<div class="write-form">
				<p class="info-txt">* 영문+숫자+특수문자를 포함, 8자리~20자리 이내 공백없이 입력하세요.</p>
				<div class="form-div">
					<input type="password" name="pw" placeholder="PASSWORD 입력" required="required">
					<input type="password" name="pw2" placeholder="PASSWORD 입력" required="required">
					<p class="pw-check-msg"></p>
				</div>
				<div class="btn-wrap">
					<button type="button" class="use-btn btn-add">변경하기</button>
				</div>
			</div>
		</div>
		<button type="button" class="modal-close">닫기</button>
	</div>
</div>

<div class="popup-modal" id="nickCheckPop">
	<div class="modal">
		<div class="modal-title">닉네임 중복확인</div>
		<div class="modal-content">
			<div class="write-form">
				<p class="info-txt">닉네임은 공백없이 한글,영문,숫자만 입력 가능,<br/> 한글 2자, 영문 4자 이상 입력하세요.</p>
				<div class="has-btn-type form-div">
					<input type="text" name="nickname" placeholder="닉네임 입력">
					<button type="button" class="nick-check btn-list btn-sm">중복확인</button>
				</div>
				<div class="result-div">
					<p class="result-msg"></p>
					<button type="button" class="use-btn btn-add">사용하기</button>
				</div>
			</div>
		</div>
		<button type="button" class="modal-close">닫기</button>
	</div>
</div>

<script type="text/javascript" src="/js/swiper.min.js"></script>
<script type="text/javascript" src="/js/mypage_script.js"></script>
<script type="text/javascript" src="/js/join_script.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
