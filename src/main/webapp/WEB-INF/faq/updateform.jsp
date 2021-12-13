<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<link rel="stylesheet" type="text/css" href="/css/faq_style.css">
<div class="faq-div">
	<div class="inner"> 
		<form class="faq-form-div" action="update" method="post">
			<select class="category" name="category">
				<option value="">선택</option>
				<option value="sale" <c:if test="${dto.category eq 'sale'}">selected</c:if>>구매/판매</option>
				<option value="manner" <c:if test="${dto.category eq 'manner'}">selected</c:if>>거래매너</option>
				<option value="other" <c:if test="${dto.category eq 'other'}">selected</c:if>>기타</option>
			</select> 
			<input type="hidden" name="idx" value="${dto.idx}">
			<input type="hidden" name="currentPage" value="${currentPage}">
				<div class="group">
					<div class="child tit">
					 	질문 <span class="must">*</span>
					</div>
					<div class="child">
						<input type="text" name="question" value="${dto.question}" required="required">
					</div>
				</div>
				<div class="child tit">
					답변 <span class="must">*</span>
				</div>
				<div>
					<textarea name="answer" required="required">${dto.answer}</textarea>
				</div>
				<div class="btn-wrap">
					<button type="submit" class="btn-update" id="btn">수정하기</button> 
					<button type="button" class="btn-list" onclick="location.href='list'" id="btn">취소하기</button>
				</div>
			</form>
		</div>
</div>