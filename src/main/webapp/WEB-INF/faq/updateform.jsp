<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="/css/faq_style.css">

<div class="faq-div">
	<div class="inner"> 
		<form action="update" method="post">
			<div class="group">
				<div class="child tit">
				 	질문 <span class="must">*</span>
				</div>
				<div class="child">
					<input type="text" class="subinput" value="${fdto.question}" required="required">
				</div>
			</div>
			<div class="group">
				답변 <span class="must">*</span>
			</div>
			<div>
				<textarea class="textinput" value="${fdto.answer}" required="required"></textarea>
			</div>
			<button type="submit" class="btn-update">수정하기</button> 
			<button type="button" class="btn-list" onclick="location.href='list'">취소하기</button>
		</form>
	</div>
</div>