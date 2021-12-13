<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="/css/faq_style.css">
<div class="faq-div">
	<div class="inner">
		<form class="faq-form-div" action="insert" method="post">
			<select name="category" class="category">
				<option value="">선택</option>
				<option value="sale">구매/판매</option>
				<option value="manner">거래매너</option>
				<option value="other">기타</option>
			</select>
			<div class="group">
				<div class="child tit">
					질문 <span class="must">*</span>
				</div>
				<div class="child">
					<input type="text" name="question" placeholder="질문입력"
						required="required">
				</div>
			</div>
			<div class="child tit">
				답변 <span class="must">*</span>
			</div>
			<div>
				<textarea name="answer" placeholder="답변을 입력해주세요" required="required"></textarea>
			</div>
			<div class="btn-wrap">
				<button type="submit" class="btn-add" id="btn">등록하기</button>
				<button type="button" class="btn-list"
					onclick="location.href='list'" id="btn">취소하기</button>
			</div>
		</form>
	</div>
</div>