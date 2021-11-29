<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="popup-modal">
	<div class="modal">
		<form>
		<div class="modal-title">닉네임과의 거래후기는?</div>
		<div class="modal-content">
			<div class="my-rating"></div>
			<textarea placeholder="선택사항"></textarea>
		</div>
		<button type="submit">등록</button>
		<button type="button" class="modal-close">취소</button>
		</form>
	</div>
</div>
    
<script src="jquery.star-rating-svg.js"></script>
<script>
$(".my-rating").starRating({
    starSize: 25,
    callback: function(currentRating, $el){
        // make a server call here
    }
});
</script>