<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="">
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
						<img class="bigImage" alt="thumbnail" src="../photo/${photo}">
					</div>
				</c:forEach>
			</div>
			<div class="swiper-butten-next"></div>
			<div class="swiper-butten-prev"></div>
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
	
	<div class="info">
		<table class="table table-default">
			<tr>
				<td colspan="3" class="tit-sm">
				<fmt:formatDate value="${dto.writeday}" pattern="yy.MM.dd"/>
				<a class="">조회수 ${dto.readcount}</a>
				</td>
			</tr>
			<tr>
				<td colspan="3" class="tit">
					${dto.title}
				</td>
			</tr>
			<tr>
				<td colspan="2" class="profile">
					<img alt="profile" src="/image/profile-icon.png" class="profileImg">
				</td>
				<td class="nick tit verticalBottom">
					닉네임
				</td>
			</tr>
			<tr>
				<td colspan="3" class="">
					댓글 , 공감
				</td>
			</tr>
		</table>
	</div>
</div>

	<div class="detailContentDiv">
		<pre class="detailContent">${dto.content}</pre>
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

//미리보기 이미지 클릭
$(document).on("click",".smallImg", function(e) {
	var src = $(this).attr("src");
	$(".bigImage").attr("src",src);
});

</script>















