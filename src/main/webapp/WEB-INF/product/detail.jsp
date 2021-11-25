<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="/css/product_style.css">
<!-- Link Swiper's CSS -->
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css"/>

<div class="inner">
<div class="infoAll">
	<div class="img group">
		<div class="swiper mySwiper">
			<div class="bigImgDiv swiper-wrapper">
				<c:forEach items="${photo}" var="photo">
					<div class="swiper-slide bigImg fix">
						<img class="bigImage" alt="thumbnail" src="../photo/${photo}">
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
	
	<div class="info">
	<table class="table table-default">
		<tr>
			<td rowspan="2" class="profile">
				<img alt="profile" src="/image/profile-icon.png" class="profileImg">	
			</td>
			<td class="nick tit verticalBottom">
			닉네임
			</td>
			<td rowspan="2" class="detailBtn">
				<button class="btn-list" id="follow">
					<span class="glyphicon glyphicon-plus"></span>
				팔로우</button>
			</td>
		</tr>
		<tr>
			<td class="tit-sm verticalTop">
				후기
			</td>
		</tr>
		<tr>
			<td colspan="3" class="tit-sm"><a>${dto.category }</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<fmt:formatDate value="${dto.writeday }" pattern="yy.MM.dd"/></td>
		<tr>
		<tr class="needHeight">
			<!-- 작성자가 아닐 경우-->
			<c:if test="true">
				<c:if test="${dto.sellstatus !='판매중' }">
					<td class="sellstatus verticalBottom">
						<span class="${dto.sellstatus=='판매중'?'selling':dto.sellstatus=='예약중'?'reserved':'finished'} tit">${dto.sellstatus}</span>
					</td>
				</c:if>
			</c:if>
			<c:if test="false">
				<td>
					<select name="sellstaus">
						<option class="tit selling" value="selling">판매중</option>
						<option class="tit reserved" value="reserved">예약중</option>
						<option class="tit finished" value="finished">거래완료</option>
					</select>
				</td>
			</c:if>
			<td ${dto.sellstatus=='판매중'?'colspan="3"':'colspan="2"'} class="tit verticalBottom">
				${dto.title}
			</td>
		</tr>
		<tr class="needHeight">
			<td colspan="3" class="tit verticalTop">
				<fmt:formatNumber>${dto.price} </fmt:formatNumber>원
			</td>
		</tr>
		<tr>
			<td colspan="3" class="tit-sm">
			대화 ${dto.chatcount}&nbsp;&nbsp;&nbsp;찜 ${dto.goodcount}&nbsp;&nbsp;&nbsp;조회수 ${dto.readcount}
			</td>
		</tr>
		<tr class="lineNeed">
			<td class="marginZero">
				<button type="button" id="dibs" onclick="dibsClicked()"><img src="/image/stopheart-icon.gif" alt="dibsButton" id="dibsBtnImg"></button>
			</td>
			<!-- 작성자가 아니면 -->
			<c:if test="false">
				<td colspan="2">
					<button type="button" class="btn-add">채팅하기</button>
				</td>
			</c:if>
			<!-- 작성자면 -->
			<c:if test="true">
				<td colspan="2" class="detailBtn">
					<button type="button" class="btn-update" onclick="location.href='updateForm?idx=${dto.idx}'">수정</button>
					<button type="button" id="deleteBtn" class="btn-delete" value="${dto.idx}">삭제</button>
				</td>
			</c:if>
		</tr>
	</table>
	</div>
</div>

	<div class="detailContentDiv">
		<pre class="detailContent">${dto.content}</pre>
	</div>
	<br><br>
	<hr>
	
	<div class="relative group">
		<div class="tit child">연관상품</div>
		<div class="child tit-sm more">더보기></div>
		<div class="relative-list">
		</div>
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

//미리보기 이미지 클릭시,
$(document).on("click",".smallImg", function(e) {
	var src = $(this).attr("src");
	$(".bigImage").attr("src",src);
});

//미리보기 이미지 호버시,
/* $(document).ready(function() {
	var original = $(".bigImg").attr("src");
	$(".smallImg").hover(function() {
		var src = $(this).attr("src");
		$(".bigImage").attr("src",src);
	}, function() {
		var src = $(this).attr("src");
		$(".bigImage").attr("src",original);
	});
}); */

//찜버튼 클릭시
function dibsClicked(){
	//찜 DB에 올라가기
	
	//버튼 이미지 변경
	if($("#dibsBtnImg").attr("src")=="/image/stopheart-icon.gif"){
		$("#dibsBtnImg").attr("src","/image/movingheart-icon.gif");
	} else{
		$("#dibsBtnImg").attr("src","/image/stopheart-icon.gif");
	}
}

//삭제 버튼 alert
$("#deleteBtn").click(function() {
	var idx =  $(this).val();
	
	var n = confirm("정말 게시물을 삭제하시겠습니까?");
	if(n){
		location.href="delete?idx="+idx;
	} else{
		return;			
	}
	
});



</script>

