<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<link rel="stylesheet" type="text/css" href="/css/swiper.min.css">
<link rel="stylesheet" type="text/css" href="/css/common.css">
<link rel="stylesheet" type="text/css" href="/css/community_style.css">
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
						<c:if test="${photo=='no'}">
						<!-- 이미지 없는경우 -->
							<img src="../image/co-noimg.jpg">
						</c:if>
						<c:if test="${photo!='no'}">
						<!-- 이미지 있을경우 -->
							<img alt="smallImage" src="../photo/${photo}" class="smallImg">
						</c:if>
					</div>
				</c:forEach>
			</div>
		</div>
	
		<div class="info">
			<table class="table">
				<tr>
					<td colspan="2">
						<fmt:formatDate value="${dto.writeday}" pattern="yy.MM.dd"/>
					</td>
					<td>
						<a class="txt readcount">조회수 : ${dto.readcount}</a>
					</td>
				</tr>
				<tr>
					<td colspan="2" class="detailtit">
						${dto.title}
					</td>
				</tr>
				<tr>
					<td class="proimg">
						<img alt="profile" src="/image/profile-icon.png" class="profileImg" />
						<span class="nick txt">${nick}닉네임</span>
					</td>
				</tr>
				<tr>
					<td class="tit-sm other" >
						<div class="reply-heart">
							<!-- 공감수표시 -->
								<div class="gdcount-icon">
									<img src="../image/heart-icon.png">
									<span class="txt gdcount">${dto.goodcount}</span>
								</div>
							<!-- 댓글수표시 -->
								<div class="reply-icon">
									<img src="../image/comment-icon.png">
									<span class="txt recount">${recount}</span>
								</div>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<div class="loginokbtn">
							<!-- 로그인 했을경우에만 -->
								<sec:authorize access="isAuthenticated()">
								<button type="button" class="btn-update deupdate"
								onclick="location.href='updateform?idx=${dto.idx}&currentPage=${currentPage}'">수정</button>
								<button type="button" id="deleteBtn" class="btn-delete dedelete" value="${dto.idx}">삭제</button>
								</sec:authorize>
						</div>
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
		<sec:authorize access="isAnonymous()">
			<button type="button" class="btn-list delist"
			onclick="location.href='list'">목록</button>
	 	</sec:authorize> 
	
	<!-- 로그인 했을경우 -->
		<sec:authorize access="isAuthenticated()">
			<button type="button" class="btn-add gdcount" onclick="gdClick()">공감♥</button>
			<button type="button" class="btn-list delist"
				onclick="location.href='list'">목록</button>
		</sec:authorize>
	</div>
	
	<!-- 댓글 -->
	<div class="reform txt">
		<b>댓글수 : ${recount}</b>
	</div>
	
	<!-- 댓글작성 -->
	<form action="reinsert" method="post">
		<input type="hidden" value="${currnetPage}" name="currentPage">
		<input type="hidden" value="${dto.idx}" name="num">
		<div class="reply">
			<div class="re-addcontent">
				<textarea name="content" class="re-textinput" placeholder=" 댓글을 입력해주세요."
				required="required" id="re-textinput"></textarea>
			</div>
			<div class="re-items">
				<div class="re-addbtn">
					<button type="submit" class="btn-add btn-sm replyadd" id="re-addbtn">등록</button>
				</div>
			</div>
		</div>
	</form>
	
	<!-- 댓글목록 -->
	<div class="re-list">
		<c:if test="${recount==0}">
			<div class="nodata">
				<p class="icon">
					<img alt="" src="/image/nodata-icon.png">
				</p>
				<p>등록된 댓글이 없습니다.</p>
			</div>
		</c:if>
		<c:if test="${recount>0}">
			<c:forEach var="cdto" items="${relist}">
				<div class="re-detail">
			 		<!-- relevel만큼 공백 -->
			 		<c:forEach var="sp" begin="1" end="${cdto.relevel}">
			 			<div class="re-blank"></div>
					 </c:forEach>
					 <!-- 답글인 경우에만 re 이미지출력 -->
			 		<c:if test="${cdto.relevel>0}">
			 			<div>ㄴ</div>
					 </c:if> 
				</div>
				<div class="re-div">
					<div class="re-info">
						<div class="writer-info">
							<p class="profile-img"><img alt="" src="/image/profile-icon.png" class="re-profileimg"></p>
						 	<span class="re-writer">${nick}닉네임</span>
						</div>
						<div class="re-content">
							<div class="txt">
								${cdto.content}
								<span class="adel" idx="${cdto.idx}"></span>
							</div>
								
							<div class="re-util">
							 	<span class="re-day">
							 		<fmt:formatDate value="${cdto.writeday}" pattern="yy.MM.dd HH:mm"/>
							 	</span>
							 	<div class="re-rebtn">
									<a href="javascript:" class="wr-reply">답글쓰기</a>
								</div>
							</div>
						</div>
					</div>
					
					<div class="re-reply">
						<form action="reinsert" method="post">
							<input type="hidden" value="${currnetPage}" name="currentPage">
							<input type="hidden" value="${dto.idx}" name="num">
							<input type="hidden" name="regroup" value="${regroup}">
							<input type="hidden" name="relevel" value="${relevel}">
							<input type="hidden" name="restep" value="${restep}">
							<div class="reply">
								<div class="re-addcontent">
									<textarea name="content" class="re-text-input" placeholder=" 댓글을 입력해주세요."
									required="required" id="re-textinput"></textarea>
								</div>
								<div class="re-items">
									<button type="submit" class="btn-add btn-sm re-add-btn">등록</button>
								</div>
							</div>
						</form>
					</div>	
				</div>
			</c:forEach>
		</c:if>
	</div>
</div>

<script type="text/javascript" src="/js/swiper.min.js"></script>
<script>

//미리보기 이미지 클릭
$(document).on("click",".smallImg", function(e) {
	var src = $(this).attr("src");
	$(".bigImage").attr("src",src);
}); 

$(document).ready(function() {
	//로그인 되있을 경우
	let loginCheck = '${isLogin}';
	 if($(loginCheck == "Y")){
		//공감버튼 클릭시 글자색 변경
		if($(goodCheck == 0)){
			$(".gdcount").css("color","#fcfef9");
		}else{
			$(".gdcount").css("color","#98077e");
		}
	}  
	
	//미리보기 이미지 호버시,
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
	
	//댓글 글자수제한
	$('#re-textinput').on('keyup',function(){
		$('#text-plus').html("("+$(this).val().length+" / 100)입력");
		
		if($(this).val().length >90 && $(this).val().length <=100) {
			$('#text-plus').css("color","red");
		}else{
			$('#text-plus').css("color","black");
		}
		
		if($(this).val().length > 100) {
			$(this).val($(this).val().substring(0, 100));
			$('#text-plus').html("(100 / 100)입력");
		}
	});
	
});




//게시글 삭제버튼 클릭시 확인
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


function gdClick(){
	var idx = ${dto.idx};
	console.log("공감버튼 클릭");
	//로그인 안했을경우 
	if(${isLogin != "Y"}){
		alert("로그인 후 사용가능합니다.");
		return;
	}else{
		//로그인 했을경우
		//공감버튼 눌렀을때 공감수 +
		if($(goodCheck != 0)){
		$.ajax({
			type : "post",
			url : "updateGoodcount",
			dataType : "text",
			data : {"idx":idx},
			success : function (data) {
				$("#updateGoodcount").html(data);
			}
		});
	} 
	else{
		$.ajax({
			type : "post",
			url : "updateGoodCancel",
			dataType : "text",
			data : {"idx":idx},
			success :function (data){
				$("updateGoodcount").html(data);
				}
			});
		}
	}
}


//원댓글 삭제
$("span.adel").click(function(){
	var idx=$(this).attr("idx");
	//alert(num);
	
	var check = confirm("댓글을 삭제하시겠습니까?");
	//alert(check);
	if(check ==true){
	 $.ajax({
		type: "get",
		dataType: "text",
		url: "redelete",
		data: {"idx":idx},
		success: function(data){
			alert("삭제완료");
			location.reload();
		},error: function(e){
			console.log("에러",e);
		}
	}); 
	}else{
		alert("취소 되었습니다.");
		return;
	}
});

//답글쓰기 토글
$(document).on("click",".re-rebtn", function(e) {
	$(this).parents(".re-div").siblings().find(".re-reply").hide();
	$(this).parents(".re-div").find(".re-reply").show();
});


</script> 