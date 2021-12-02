<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="/css/faq_style.css">

<div class="faq-div">
	<div class="inner">
		<select class="category">
			<option value="">선택</option>
			<option value="all">전체</option>
			<option value="order">주문관련</option>
			<option value="calcle">교환/반품</option>
			<option value="delivery">배송관련</option>
		</select> 
		<form class="faq-form-div" action="insert" method="post">
			<div class="group">
				<div class="child tit">
				 	질문 <span class="must">*</span>
				</div>
				<div class="child">
					<input type="text" class="subinput" placeholder="질문입력" required="required">
				</div>
			</div>
			<div class="child tit">
				답변 <span class="must">*</span>
			</div>
			<div>
				<textarea class="textinput" placeholder="답변을 입력해주세요" required="required"></textarea>
			</div>
			<div class="btn-wrap">
				<button type="submit" class="btn-add">등록하기</button> 
				<button type="button" class="btn-list" onclick="location.href='list'">취소하기</button>
			</div>
		</form>
	</div>
</div>
