<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"  %>
<c:set var="root" value="<%=request.getContextPath() %>"></c:set>
<header id="header">
	<div class="util">
		<div class="inner">
			<sec:authorize access="isAnonymous()">
				<a href="${root}/login/main" class="login-btn">로그인</a>
				<a href="${root}/join/main" class="join-btn">회원가입</a>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				<a href="${root}/mypage/detail" class="mypage-btn">마이페이지</a>
				<a href="${root}/logout" class="logout-btn">로그아웃</a>
			</sec:authorize>
		</div>
	</div>
	<div class="header-div">
		<div class="inner">
			<h1 class="logo">
				<a href="/">바니마켓 로고</a>
			</h1> 
			<nav class="menu">
				<button type="button" class="menu-btn">
					<strong>메뉴 열기</strong>
					<span></span>
					<span></span>
					<span></span>
				</button>
				<ul class="gnb">
					<li>
						<a href="javascript:" class="one-depth">기업정보</a>
						<ul class="two-depth">
							<a href="${root}/intro/main">소개</a>
						</ul>
					</li>
					<li>
						<a href="javascript:" class="one-depth">동네이야기</a>
						<ul class="two-depth">
							<a href="${root}/product/list">동네거래</a>
							<a href="${root}/community/list">동네생활</a>
							<a href="${root}/advertise/list">동네소식</a>
							<a href="${root}/event/list">동네행사</a>
						</ul>
					</li>
					<li>
						<a href="javascript:" class="one-depth">기타</a>
						<ul class="two-depth">
							<a href="${root}/notice/list">공지사항</a>
							<a href="${root}/faq/list">자주 묻는 질문</a>
							<a href="${root}/term/use">이용약관</a>
							<a href="${root}/term/privacy">개인정보처리방침</a>
						</ul>
					</li>
				</ul>
			</nav>
			<div class="local-div">
				<sec:authorize access="isAnonymous()">
					<button type="button" onclick="location.href='/local/auth/add'" class="local-btn">내 동네 설정</button>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">
					<button type="button" class="local-btn">${localArr[0]}</button>
					<ul class="local-option">
						<c:forEach var="local" items="${localArr}">
							<li>
								<span>${local}</span>
							</li>
						</c:forEach>
						<li>
							<a href="/local/auth/add" class="set-btn">내 동네 설정하기</a>
						</li>
					</ul>
				</sec:authorize>
			</div>
		</div>
	</div>
</header>