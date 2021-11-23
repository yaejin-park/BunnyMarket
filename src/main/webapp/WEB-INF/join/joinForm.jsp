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
			<form action="insert" method="post">
				<div class="group">
					<div class="child tit">
						아이디
						<span class="must">*</span>
					</div>
					<div class="child">
						<div class="has-btn-type form-div">
							<input type="text" name="id" placeholder="ID 입력" >
							<button type="button" class="nick-check btn-list">중복확인</button>
						</div>
						<p class="info-txt">* 영문자,숫자, _만 입력가능, 최소 3 이상 입력하세요.</p>
					</div>
				</div>
				<div class="group">
					<div class="child tit">
						비밀번호
						<span class="must">*</span>
					</div>
					<div class="child">
						<div class="form-div">
							<input type="password" name="pw" placeholder="PASSWORD 입력" >
						</div>
					</div>
				</div>
				<div class="group">
					<div class="child tit">
						비밀번호확인
						<span class="must">*</span>
					</div>
					<div class="child">
						<div class="form-div">
							<input type="password" name="pw2" placeholder="PASSWORD 입력" >
						</div>
						<p class="pw-msg"></p>
					</div>
				</div>
				<div class="group">
					<div class="child tit">
						이름
						<span class="must">*</span>
					</div>
					<div class="child">
						<div class="form-div">
							<input type="text" name="name" placeholder="이름 입력" >
						</div>
						<div class="info-txt">
							<p>* 공백없이 한글만 입력 가능</p>
						</div>
					</div>
				</div>
				<div class="group">
					<div class="child tit">
						닉네임
					</div>
					<div class="child">
						<div class="has-btn-type form-div">
							<input type="text" name="nickname" placeholder="닉네임 입력" >
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
						<div class="has-btn-type form-div">
							<input type="text" name="email" placeholder="E-mail 입력" >
							<button type="button" class="email-check btn-list">E-mail 인증</button>
						</div>
						<div class="email-certify">
							<p class="txt">인증번호를 입력해주세요.</p>
							<input type="text" name="email-certify" placeholder="인증번호 입력">
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
							<div class="has-btn-type form-div addr-num">
								<input type="text">
								<span> - </span>
								<input type="text">
								<button type="button" class="addr-search-btn btn-list">우편번호 검색</button>
							</div>
							<div class="form-div">
								<input type="text" name="addr1">
							</div>
							<div class="form-div">
								<input type="text" name="addr2">
							</div>
						</div>
					</div>
				</div>
				
				<div class="term-div">
					<div class="all-check">
						<input type="checkbox" id="termAllCheck">
						<label for="termAllCheck">전체 동의</label>
					</div>
					<div class="acco-div">
						<div class="acco-btn">
							<input type="checkbox" id="termCheck1">
							<label for="termCheck1">이용약관 동의 <span>(필수)</span></label>
						</div>
						<div class="acco-con">
							<%-- <jsp:include page=""></jsp:include> --%>
						</div>
					</div>
					<div class="acco-div">
						<div class="acco-btn">
							<input type="checkbox" id="termCheck2">
							<label for="termCheck2">개인정보처리방침 동의<span>(필수)</span></label>
						</div>
						<div class="acco-con">
							<%-- <jsp:include page=""></jsp:include> --%>
						</div>
					</div>
					<div class="acco-div">
						<div class="acco-btn">
							<input type="checkbox" id="termCheck3">
							<label for="termCheck3">위치기반서비스약관 동의<span>(필수)</span></label>
						</div>
						<div class="acco-con">
							<%-- <jsp:include page=""></jsp:include> --%>
						</div>
					</div>
				</div>
				
				<div class="btn-wrap">
					<a href="javascript:" class="btn-add">회원가입</a>
					<a href="javascript:" class="btn-default">취소</a>
				</div>
			</form>
		</div>
	</div>
</div>
