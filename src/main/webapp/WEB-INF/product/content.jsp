<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" type="text/css" href="/css/product_style.css">
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1"/>
<!-- Link Swiper's CSS -->
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css"/>

<div class="inner">
<div class="infoAll">
	<div class="img group">
		<div class="swiper mySwiper">
			<div class="bigImgDiv swiper-wrapper">
				<c:forEach items="${photo}" var="photo">
					<div class="swiper-slide bigImg">
						<img id="bigImg" alt="thumbnail" src="../photo/${photo}">
					</div>
				</c:forEach>
			</div>
			<div class="swiper-button-next"></div>
   			<div class="swiper-button-prev"></div>
			<div class="swiper-pagination"></div>
		</div>
		<div class="smImgDiv">
			<c:forEach items="${photo}" var="photo">
				<div class="smImg child">
					<img alt="smallImage" src="../photo/${photo}" class="smallImg">
				</div>
			</c:forEach>
		</div>
	</div>
	
	<table class="info table table-default">
		<tr>
			<td rowspan="2" class="profile">
				<img alt="profile" src="/image/profile-icon.png" class="profileImg">	
			</td>
			<td class="nick tit">
				닉네임
			</td>
			<td rowspan="2" class="detailBtn">
				<button class="btn-list" id="follow">
					<span class="glyphicon glyphicon-plus"></span>
				팔로우</button>
			</td>
		</tr>
		<tr>
			<td>
				후기
			</td>
		</tr>
		<tr>
			<td colspan="3">${dto.category } | ${dto.writeday }</td>
		<tr>
		<tr>
			<!-- 작성자가 아닐 경우-->
			<c:if test="false">
				<td>
					예약중
				</td>
			</c:if>
			<c:if test="true">
				<td>
					<select>
						<option class="tit selling">판매중</option>
						<option class="tit reserved">예약중</option>
						<option class="tit finished">거래완료</option>
					</select>
				</td>
			</c:if>
			<td colspan="2">
				${dto.title}
			</td>
		</tr>
		<tr>
			<td colspan="3">
				${dto.price}
			</td>
		</tr>
		<tr>
			<td colspan="3">
			대화 찜 조회수
			</td>
		</tr>
		<tr>
			<td>
			찜
			</td>
			<!-- 작성자가 아니면 -->
			<c:if test="false">
				<td colspan="2">
					<button class="btn-add">채팅하기</button>
				</td>
			</c:if>
			<!-- 작성자면 -->
			<c:if test="true">
				<td colspan="2" class="detailBtn">
					<button class="btn-update">수정</button>
					<button class="btn-delete">삭제</button>
				</td>
			</c:if>
		</tr>
	</table>
</div>
	<div class="detailContentDiv">
		<textarea class="detailContent">${dto.content}</textarea>
	</div>
	<br><br>
	<hr>
	
	<div class="relative">
		<div class="tit child">연관상품</div>
		<div class="child">더보기></div>
	</div>
</div>

<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<!-- Initialize Swiper -->
<script>
setTimeout(() => {
	 var swiper = new Swiper(".mySwiper", {
		    navigation: {
		      nextEl: ".swiper-button-next",
		      prevEl: ".swiper-button-prev",
		    },
		    pagination: {
		      el: ".swiper-pagination",
		    },
		  });
}, 20);

$(document).on("click",".smallImg", function(e) {
	var src = $(this).attr("src");
	$("#bigImg").attr("src",src);
});

$(document).ready(function() {
	var original = $("#bigImg").attr("src");
	$(".smallImg").hover(function() {
		var src = $(this).attr("src");
		$("#bigImg").attr("src",src);
	}, function() {
		var src = $(this).attr("src");
		$("#bigImg").attr("src",original);
	});
});




</script>

