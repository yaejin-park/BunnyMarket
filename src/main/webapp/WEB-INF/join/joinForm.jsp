<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="/css/join_style.css">
<div class="join-div">
	<div class="inner">
		<div class="sns-login-div">
			<p class="tit">간편하게 로그인해보세요.</p>
			<div class="sns-login">
				<a href="javascript:" class="google">구글 간편로그인</a>
				<a href="javascript:" class="naver">네이버 간편로그인</a>
				<a href="javascript:" class="kakao">카카오 간편로그인</a>
			</div>
		</div>
		<div class="write-form">
			<form action="insert" method="post" name="join-form" onsubmit="return joinFormCheck(this)">
				<input type="hidden" name="type" value="${joinType}">
				<div class="group">
					<div class="child tit">
						아이디
						<span class="must">*</span>
					</div>
					<div class="child">
						<div class="has-btn-type form-div">
							<input type="text" name="id" placeholder="ID 입력" required="required">
							<button type="button" class="id-check btn-list">중복확인</button>
						</div>
						<p class="info-txt">* 영문자,숫자, _만 입력가능, 최소 3자 이상 입력하세요.</p>
					</div>
				</div>
				<div class="group">
					<div class="child tit">
						비밀번호
						<span class="must">*</span>
					</div>
					<div class="child">
						<div class="form-div">
							<input type="password" name="pw" placeholder="PASSWORD 입력" required="required">
							<p class="pw-msg"></p>
						</div>
						<p class="info-txt">* 영문+숫자+특수문자를 포함, 8자리~20자리 이내 공백없이 입력하세요.</p>
					</div>
				</div>
				<div class="group">
					<div class="child tit">
						비밀번호확인
						<span class="must">*</span>
					</div>
					<div class="child">
						<div class="form-div">
							<input type="password" name="pw2" placeholder="PASSWORD 입력" required="required">
							<p class="pw-check-msg"></p>
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
							<input type="text" name="name" placeholder="이름 입력" required="required">
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
							<input type="text" name="nickname" placeholder="닉네임 입력" required="required">
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
							<input type="text" name="email1" placeholder="E-mail 입력"  required="required">
							<span>@</span>
							<input type="text" name="email2" class="etc-input" placeholder="ex) email.com" required="required">
							<select class="domain">
								<option>선택</option>
								<option value="">직접입력</option>
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
								<option>010</option>
								<option>011</option>
							</select>
							<span>-</span>
							<input type="text" name="hp2" placeholder="1234" maxlength="4">
							<span>-</span>
							<input type="text" name="hp3" placeholder="1234" maxlength="4" >
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
							<input type="hidden" name="addrLocal">
							<div class="has-btn-type form-div">
								<input type="text" name="zonecode" readonly="readonly">
								<button type="button" class="addr-search-btn btn-list" onclick="findAddr()">우편번호 검색</button>
							</div>
							<div class="form-div">
								<input type="text" name="addr1" required="required">
							</div>
							<div class="form-div">
								<input type="text" name="addr2">
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
					<button type="submit" class="btn-add join-btn">회원가입</a>
					<button type="button" class="btn-default">취소</a>
				</div>
			</form>
		</div>
	</div>
</div>

<div class="popup-modal" id="idCheckPop">
	<div class="modal">
		<div class="modal-title">아이디 중복확인</div>
		<div class="modal-content">
			<div class="write-form">
				<p class="info-txt">아이디는 영문자,숫자, _만 입력가능, 최소 3자 이상 입력하세요.</p>
				<div class="has-btn-type form-div">
					<input type="text" name="id" placeholder="ID 입력">
					<button type="button" class="id-check btn-list btn-sm">중복확인</button>
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

<script type="text/javascript" src="/js/join_script.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
