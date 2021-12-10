<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="/css/review_style.css">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<div class="popup-modal" id="reviewPop">
	<div class="modal">
		<div class="modal-title"><h2>거래완료</h2> <h3>구매자를 선택해주세요</h3></div>
		<div class="modal-content">
			<c:forEach var="r" items="${list}">
	<table class="review">
		<tr>
			<td class="img">${r.profile}</td>
			<td class="name">${r.nickname}<small class="small">${r.last_time}</small>
			</td>
			<td class="go"><i class="arrow" onclick="location.href='insertForm?idx=${idx}&nickname=${r.nickname}&id=${r.buyer_id}'"></i></td>
		</tr>

	</table>
	
	
</c:forEach>
		</div>
		<button type="button" class="modal-close">안쓸래요</button>
	</div>
</div>
