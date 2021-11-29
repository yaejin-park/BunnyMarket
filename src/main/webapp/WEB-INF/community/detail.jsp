<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" type="text/css" href="/css/product_style.css">
<!-- Link Swiper's CSS -->
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css"/>

<div class="inner">
<input type="hidden" name="currentPage" value="${currentPage}">

<div class="infoAll">
	<div class="img group">
		<div class="detail-swiper">
			<div class="bigImgDiv swiper-wrapper">
				<c:forEach items="${photo}" var="photo">
					<div class="swiper-slide bigImg fix">
						<!-- 이미지 없는경우 -->
						<c:if test="${photo=='no'}">
							<img src="../image/co-noimg.jpg">
						</c:if>
						<!-- 이미지 있는경우 -->
						<c:if test="${photo!='no'}">
							<img class="bigImage" alt="thumbnail" src="../photo/${photo}">
						</c:if>
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
						<!-- 이미지 없는경우 -->
						<c:if test="${photo=='no'}">
							<img src="../image/co-noimg.jpg">
						</c:if>
						<!-- 이미지 있을경우 -->
						<c:if test="${photo!='no'}">
							<img alt="smallImage" src="../photo/${photo}" class="smallImg">
						</c:if>
					</div>
				</c:forEach>
			</div>
		</div>
	
	<div class="info">
		<table class="table table-default">
			<tr>
				<td colspan="3" class="tit-sm">
				<fmt:formatDate value="${dto.writeday}" pattern="yy.MM.dd"/>
				<a class="txt readcount">조회수 ${dto.readcount}</a>
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
					<span class="nick txt">닉네임</span>
				</td>
			</tr>
			<tr>
				<td colspan="3" class="txt">
					댓글 , 공감
				</td>
			</tr>
		</table>
	</div>
</div>

	<div class="detailContentDiv">
		<pre class="detailContent">${dto.content}</pre>
	</div>
	
	<div class="detailbtn">
		<!-- 로그인 안했을경우 -->
		<c:if test="false">
			<button type="button" class="btn-list delist"
			onclick="location.href='list'">목록</button>
		</c:if>
		
		<!-- 로그인 했을경우 -->
		<c:if test="true">
			<button type="button" class="btn-list delist"
				onclick="location.href='list'">목록</button>
			<button type="button" class="btn-add gdcount">공감♥</button>
			<button type="button" class="btn-update deupdate"
			onclick="location.href='updateform?idx=${dto.idx}&currenPage=${currentPage}'">수정</button>
			<button type="button" id="deleteBtn" class="btn-delete dedelete" value="${dto.idx}">삭제</button>
		</c:if>
	</div>
	
</div>


<script type="text/javascript" src="/js/swiper.min.js"></script>
<script>

/* //미리보기 이미지 클릭
$(document).on("click",".smallImg", function(e) {
	var src = $(this).attr("src");
	$(".bigImage").attr("src",src);
}); */

//미리보기 이미지 호버시,
$(document).ready(function() {
	$(".smImgDiv").mouseenter(function() {
		var original = $(".bigImage").attr("src");
		console.log("enter"+original);
		$(".smallImg").hover(function() {
			var src = $(this).attr("src");
			$(".bigImage").attr("src",src);
		});
	}), function() {
		console.log("out");
		var src = $(this).attr("src");
		$(".bigImage").attr("src",original);
	}                                                                                                      
});


//삭제버튼 클릭시 확인
$("#deleteBtn").click(function(){
	var idx = $(this).val();
	var currentPage = $("input[name='currentPage']").val();
	
	var check = confirm("해당 글을 삭제하시겠습니까?");
	
	if(check){
		location.href="delete?idx="+idx+"&currentPage="+currentPage;
		}
	else{
		return;
		}
});

</script>















