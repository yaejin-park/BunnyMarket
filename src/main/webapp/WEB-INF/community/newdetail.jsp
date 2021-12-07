<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
							<!-- 이미지없는 경우 -->
							<c:if test="${photo=='no'}">
								<img alt="" src="../image/co-noimg.jpg">
							</c:if>
							<!-- 이미지 있는 경우 -->
							<c:if test="${photo!='no'}">
								<img class="bigImage" alt="thumbnail" src="../photo/${photo}">
							</c:if>
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
					<td>
						<span class="txt fmtdate">
						<fmt:formatDate value="${dto.writeday}" pattern="yy.MM.dd"/>
						</span>
						<span class="txt dereadcount">
						조회수 : ${dto.readcount}
						</span>
					</td>
				</tr>
				<tr>
					<td class="detailtit">
						${dto.title}
					</td>
				</tr>	
				<tr>
					<td>
						<img class="profileImg" alt="profile" src="/image/profile-icon.png">
						<span class="nick txt">닉네임</span>
					</td>
				</tr>
				<tr>
					<td class="tit-sm other">
						댓글,공감
					</td>
				</tr>
				<tr>
					<td>
						<div class="loginokbtn">
							<!-- 로그인 했을경우에만 -->
							<c:if test="true">
								<button type="button" class="btn-update deupdate"
								onclick="location.href='updateform?idx=${dto.idx}&currentPage=${currentPage}'">수정</button>
								<button type="button" id="deleteBtn" class="btn-delete dedelete" value="${dto.idx}">삭제</button>
							</c:if>
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
		<c:if test="false">
			<button type="button" class="btn-list delist"
			onclick="location.href='list'">목록</button>
		</c:if>
		
		<!-- 로그인 했을경우 -->
		<c:if test="true">
			<button type="button" class="btn-list delist"
				onclick="location.href='list'">목록</button>
			<button type="button" class="btn-add gdcount">공감♥</button>
		</c:if>
	</div>
	
	<div class="detail-reply">
		<div class="row">
			<div class="col-sm-12">
				<h2 id="cnt"></h2>
				<div id="replyArea"></div>
			</div>
		</div>
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

var IDX = getQueryStringObject().idx;
function getQueryStringObject() {
   var a = window.location.search.substr(1).split('&');
   if (a == "") return {};
   var b = {};
   for (var i = 0; i < a.length; ++i) {
       var p = a[i].split('=', 2);
       if (p.length == 1)
           b[p[0]] = "";
       else
           b[p[0]] = decodeURIComponent(p[1].replace(/\+/g, " "));
   }
   return b;
}
function drawReply(replys) {
	$("#cnt").text("등록된 댓글 - " + replys.length)
	var html = '';
	html += '<form class="form-inline" action="writeReply" method="post"><input type="hidden" name="idx" value = "' + IDX + '"><input type="hidden" name="replyIdx" value = "0"><input type="text" class="form-control mb-2 mr-sm-2" id="contents" placeholder="답글" name="contents"><button type="submit" class="btn btn-primary mb-2">등록</button></form>';
	replys.forEach(function(reply){ 
		if (reply.replyIdx == 0) {
			var rc = 0;
			replys.forEach(function(i){
				if (reply.idx == i.replyIdx) rc++;
			})
			html += '<div class="row"><div class="col-sm-12">';
			html += '<form class="form-inline" action="writeReply" method="post"><label for="pwd" class="mr-sm-2">' + reply.contents + '(' + rc + ')' + '</label>'
			html += '<input type="hidden" name="idx" value = "' + IDX + '"><input type="hidden" name="replyIdx" value = "' + reply.idx + '"><input type="text" class="form-control mb-2 mr-sm-2" id="contents" placeholder="답글" name="contents"><button type="submit" class="btn btn-primary mb-2">등록</button></form>';
			html += '<div class="row"><div class="col-sm-12 sub' + reply.idx + '"></div></div></div></div>';
		}
	})
	$("#replyArea").append(html);
	replys.forEach(function(reply){ 
		if (reply.replyIdx != 0) {
			var rc = 0;
			replys.forEach(function(i){
				if (reply.idx == i.replyIdx) rc++;
			})
			var subHtml = '';
			subHtml = '<div class="row"><div class="col-sm-12 subReply">';
			subHtml += '<form class="form-inline" action="writeReply" method="post"><label for="pwd" class="mr-sm-2">' + reply.contents + '(' + rc + ')' + '</label>'
			subHtml += '<input type="hidden" name="idx" value = "' + IDX + '"><input type="hidden" name="replyIdx" value = "' + reply.idx + '"><input type="hidden" name="currentPage" value="' + currentPage + '"><input type="text" class="form-control mb-2 mr-sm-2" id="contents" placeholder="답글" name="contents"><button type="submit" class="btn btn-primary mb-2">등록</button></form>';
			subHtml += '<div class="row"><div class="col-sm-12 sub' + reply.idx + '"></div></div></div></div>';
			$(".sub" + reply.replyIdx).append(subHtml);
		}
	})
}
 
 $.ajax({url: "replyList?idx="+IDX, success: function(replys){
	  drawReply(replys)
  }});

</script>








