<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="star-rating-svg.css">
<link rel="stylesheet" type="text/css" href="/css/review_style.css">

<div class="popup-modal">
	<div class="modal">
		
		<div class="modal-title">${nickname}님과의 거래후기는?</div>
			<form name="myform" id="myform" method="post" action="insert" enctype="multipart/form-data">
		<div class="modal-content">
		
	<input type="hidden" name="seller" value="${seller}" id="seller">
	<input type="hidden" name="buyer" value="${id}" id="buyer">
		<div class="modal-title"><b>${nickname}</b>님과의 거래후기는?</div>
		
			<div class="my-rating"></div>
			
			<fieldset> 
						<legend>이모지 별점</legend>
						<input type="radio" name="star" value="5" id="rate1"><label
							for="rate1">⭐</label> <input type="radio" name="star" value="4"
							id="rate2"><label for="rate2">⭐</label> <input
							type="radio" name="star" value="3" id="rate3"><label
							for="rate3">⭐</label> <input type="radio" name="star" value="2"
							id="rate4"><label for="rate4">⭐</label> <input
							type="radio" name="star" value="1" id="rate5"><label
							for="rate5">⭐</label>
					</fieldset>
			<textarea placeholder="선택사항" name="content" id="content"></textarea>
		</div>
	
		</form>
			
		</div>
		<button type="submit">등록</button>
		<button type="button" class="modal-close">취소</button>
	
	</div>
	

    


<form name="myform" id="myform" method="post" action="insert" enctype="multipart/form-data">
	<input type="hidden" name="seller" value="${seller}" id="seller">
	<input type="hidden" name="buyer" value="${id}" id="buyer">
		<div class="modal-title"><b>${nickname}</b>님과의 거래후기는?</div>
		<div class="modal-content">
			<div class="my-rating"></div>
			
			<fieldset> 
						<legend>이모지 별점</legend>
						<input type="radio" name="star" value="5" id="rate1"><label
							for="rate1">⭐</label> <input type="radio" name="star" value="4"
							id="rate2"><label for="rate2">⭐</label> <input
							type="radio" name="star" value="3" id="rate3"><label
							for="rate3">⭐</label> <input type="radio" name="star" value="2"
							id="rate4"><label for="rate4">⭐</label> <input
							type="radio" name="star" value="1" id="rate5"><label
							for="rate5">⭐</label>
					</fieldset>
			<textarea placeholder="선택사항" name="content" id="content"></textarea>
		</div>
		<button type="submit" class="btn-add btn-sm" >등록</button>
		<button type="button" class="modal-close">취소</button>
		
		</form>
		
		
		
	
		




					
			
