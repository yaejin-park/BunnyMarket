<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="/css/faq_style.css">
<div class="faq-div">
	<div class="inner"> 
		<select class="category" value="${dto.category}">
			<option value="">선택</option>
			<option value="전체">전체</option>
			<option value="주문관련">주문관련</option>
			<option value="교환/반품">교환/반품</option>
			<option value="배송관련">배송관련</option>
		</select> 
		<form action="update" method="post">
			<input type="hidden" name="idx" value="${dto.idx}">
			<input type="hidden" name="currentPage" value="${currentPage}">
				<div class="group">
					<div class="child tit">
					 	질문 <span class="must">*</span>
					</div>
					<div class="child">
						<input type="text" class="subinput" value="${dto.question}" required="required">
					</div>
				</div>
				<div class="child tit">
					답변 <span class="must">*</span>
				</div>
				<div>
					<textarea class="textinput" required="required">${dto.answer}</textarea>
				</div>
				<div class="btn-wrap">
					<button type="submit" class="btn-update">수정하기</button> 
					<button type="button" class="btn-list" onclick="location.href='list'">취소하기</button>
				</div>
		</form>
	</div>
</div>