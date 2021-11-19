<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="root" value="<%=request.getContextPath() %>"></c:set>
<footer id="footer">
	<div class="inner">
		<p class="footer-logo">바니마켓 로고</p>
		<div>
			<ul class="link-list">
				<li>
					<a href="${root}/intro/main">회사소개</a>
				</li>
				<li>
					<a href="${root}/term/use">이용약관</a>
				</li>
				<li>
					<a href="${root}/term/privacy">개인정보처리방침</a>
				</li>
				<li>
					<a href="${root}/term/location">위치기반서비스 이용약관</a>
				</li>
				<li>
					<a href="${root}/notice/list">공지사항</a>
				</li>
				<li>
					<a href="${root}/faq/list">자주 묻는 질문</a>
				</li>
			</ul>
			<div class="etc-div">
				<p class="addr-txt">서울 강남구 강남대로94길 20, 삼오빌딩(5층 ~ 9층)</p>
				<p class="copyright">Copyright 2021 Bunny Market. All right reserved</p>
			</div>
		</div>
	</div>
</footer>