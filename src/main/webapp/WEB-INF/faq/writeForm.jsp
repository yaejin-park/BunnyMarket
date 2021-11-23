<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="/css/faq.css">
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>

<<script type="text/javascript">
function check(f) {
	if(f.question.value.length == 0) {
		alert("질문을 입력해주세요");
		return false;
	}
	if (f.answer.value.length == 0) {
		alert("답변을 입력해주세요");
		return false;
	}
}
</script>
<div class="inner">
	<select name="category">
		<option value="">선택</option>
		<option value="order">구매/판매</option>
		<option value="calcle">교환/반품</option>
		<option value="delivery">배송관련</option>
	</select> 
	</br></br>
	<form action="insert" method="post">
		<div class="group">
			<div class="child tit">
			 	질문 <span class="must">*</span>
			</div>
			<div class="child">
				<input type="text" class="subinput" name="question" placeholder="질문을 입력해주세요" required="required">
			</div>
		</div>
		<div class="group">
			답변 <span class="must">*</span>
		</div>
		<div>
			<textarea class="textinput" name="answer" placeholder="답변을 입력해주세요" required="required"></textarea>
		</div>
		<button type="submit" class="btn-add">등록하기</button> 
		<button type="button" class="btn-list" onclick="location.href='list'">취소하기</button>
	</form>
</div>