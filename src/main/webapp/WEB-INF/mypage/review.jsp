<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="/css/mypage_style.css">
<div class="inner">
<h3>받은 후기</h3>
	<table class="table" id="review">
		<tbody>
			<tr>
				<td>작성자아이디or닉네임</td><td>후기내용<small>작성일</small></td>
				<td>
					<div id="my-rating">
					<fieldset> 
						<legend>이모지 별점</legend>
						<input type="radio" name="star" value="5" id="rate1">
						<label for="rate1">⭐</label> 
						<input type="radio" name="star" value="4" id="rate2">
						<label for="rate2">⭐</label> 
						<input type="radio" name="star" value="3" id="rate3">
						<label for="rate3">⭐</label> 
						<input type="radio" name="star" value="2" id="rate4">
						<label for="rate4">⭐</label> 
						<input type="radio" name="star" value="1" id="rate5">
						<label for="rate5">⭐</label>
					</fieldset>
				</div>
				
				</td>
			</tr>
		</tbody>
	
	</table>	
			
</div>
<!-- css 부분입니다 -->
<style>
small {
	
	color: #bebebe;
}

#my-rating fieldset {
	
	display: inline-block; /* 하위 별점 이미지들이 있는 영역만 자리를 차지함.*/
	direction: rtl; /* 이모지 순서 반전 */
	border: 0; /* 필드셋 테두리 제거 */
}

#my-rating fieldset legend {
	text-align: left;
}

#my-rating input[type=radio] {
	display: none; /* 라디오박스 감춤 */
}

#my-rating label {
	font-size: 3em; /* 이모지 크기 */
	color: transparent; /* 기존 이모지 컬러 제거 */
	text-shadow: 0 0 0 #f0f0f0; /* 새 이모지 색상 부여 */
}


#my-rating label:hover ~ label {
	text-shadow: 0 0 0 #ff7ab0;; /* 마우스 호버 뒤에오는 이모지들 */
}

#my-rating input[type=radio]:checked ~ label {
	text-shadow: 0 0 0 #ff7ab0;;
	cursor: pointer;
	 /* 마우스 클릭 체크 */
}
#review{
	margin-top: 10px;
}



</style>