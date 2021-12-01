<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="path" value="${requestScope['javax.servlet.forward.servlet_path']}" />
<c:set var="menuTitle" value="${fn:split(path,'/')}" />
<div class="sub-body">
	<div class="inner">
		<div class="title-area">
			<h2>${menuTitle[0]=="intro"?"소개":menuTitle[0]=="product"?"동네거래":menuTitle[0]=="advertise"?"동네소식":menuTitle[0]=="community"?"동네생활":menuTitle[0]=="event"?"동네행사":menuTitle[0]=="notice"?"공지사항":menuTitle[0]=="faq"?"자주 묻는 질문":menuTitle[0]=="event"?"동네행사":menuTitle[0]=="login"?"로그인":menuTitle[0]=="join"?"회원가입":"이용약관"}</h2>
		</div>
		
		<div class="search-area">
			<input type="text" name="search" placeholder="검색어 입력">
			<button type="button" class="search-btn">검색</button>
		</div>
	</div>
</div>