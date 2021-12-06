<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"  %>
<link rel="stylesheet" type="text/css" href="/css/swiper.min.css">
<link rel="stylesheet" type="text/css" href="/css/product_style.css">
<link rel="stylesheet" type="text/css" href="/css/ad_style.css">
<div class="inner">
<div class="infoAll">
	<input type="hidden" name="current-page" value="${currentPage}">
		<div class="img group">
			<div class="detail-swiper">
				<div class="bigImgDiv swiper-wrapper">
					<c:forEach items="${dto.photo}" var="dbimg">				
						<div class="swiper-slide bigImg fix">
							<c:if test="${dto.photo=='no'}">
								<img class="bigImg" alt="thumbnail" src="/image/list-noimg.gif">
							</c:if>
							<c:if test="${dto.photo!='no'}">
								<img class="bigImg" alt="thumbnail" src="../photo/${dbimg}">
							</c:if>
						</div>
					</c:forEach>
				</div>
				<div class="swiper-button-next"></div>
	   			<div class="swiper-button-prev"></div>
				<div class="swiper-pagination"></div>
			</div>
			<div class="smImgDiv">
				<c:forEach items="${dbimg}" var="dbimg">			
					<div class="smImg child">
						<c:if test="${dto.photo=='no'}">
							<img alt="smallImage" src="/image/list-noimg.gif" class="smImg">
						</c:if>
						<c:if test="${dto.photo!='no'}">
							<img alt="smallImage" src="../photo/${dbimg}" class="smImg">
						</c:if>
					</div>
				</c:forEach>
			</div>
		</div>
		
		<div class="info">
			<table class="table table-default">
				<tr>				
					<td class="ad-tit" colspan="3">
						제목부분입니다.[ ${dto.title} ]
					</td>
				</tr>
				<tr>
					<td rowspan="2" class="profile">
						<img alt="profile" src="/image/profile-icon.png" class="profileImg">	
					</td>
					<td class="nick tit verticalBottom">
						닉네임나올곳 [ ${nick} ]
					</td>
				</tr>
				<tr>
					<td colspan="2" class="tit-sm">
						작성일 <fmt:formatDate value="${dto.writeday}" pattern="yy.MM.dd HH:mm"/>
					</td>
					<td colspan="3" class="tit-sm">
				<div class="info-sm">   
					<div class="info-sm-div">
						<a href="detail?idx=${dto.idx}&currentPage=${currentPage}&key=list#reply">
							<div class="comment icon-sm">${recount}</div>
						</a>
					</div>
					<div class="info-sm-div">
						<div class="dibs icon-sm">${dto.goodcount}</div>
					</div>
					<div class="info-sm-div">
						<div class="read icon-sm">${dto.readcount}</div>
					</div>
				</div>
			</td>
				</tr>
			</table>
		</div>
	</div>

	<!-- 로그인/비로그인시 나타나는 버튼들 -->
	<div class="detailbtn">
		<!-- 로그인 안했을경우 -->
		<c:if test="${sessionScope.isLogin != 'Y'}">
			<button type="button" class="btn-list delist" onclick="location.href='list'">목록</button>
		</c:if>
		
		<!-- 로그인 했을경우 -->
		<c:if test="true">
			<button type="button" class="btn-list delist" onclick="location.href='list'">목록</button>
			<button type="button" class="btn-add gdcount">공감</button>
			<button type="button" class="btn-update" onclick="location.href='./auth/updateform?idx=${dto.idx}&currentPage=${currentPage}'">수정</button>
			<button type="button" id="deleteBtn" class="btn-delete" value="${dto.idx}">삭제</button>
		</c:if>
	</div>
	<div class="img-detail-div">
		<a href="javascript:" class="img-detail-view">사진상세보기</a>
		<div class="content-img">
		<c:forEach var="photo" items="${dto.photo}">
				<img src="/photo/${photo}" alt="">
		</c:forEach>
		</div>
	</div>
	<div class="content-detail-div">
		<pre class="detailContent">${dto.content}</pre>
	</div>
	
	<!-- 댓글 -->
	<div class="reform tit">
		댓글 ${recount}
	</div>
	<!-- 댓글작성 -->
	<form action="reinsert" method="post">
	<input type="hidden" value="${currentPage}" name="currentPage">
	<input type="hidden" value="${dto.idx}" name="num">
	<div class="reply" id="reply">
		<div class="re-addcontent">
			<textarea name="content" class="re-textinput" placeholder="댓글을 입력해주세요."
						required="required"></textarea>
		</div>
		<div class="re-items">
			<div class="re-addbtn">
				<button type="submit" class="btn-add btn-sm" id="re-addbtn">등록</button>
			</div>
			<div class="text-count">
				<span class="text-plus">0</span><span>/100</span>
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
			<c:forEach var="ardto" items="${relist}">
			    <!-- relevel 만큼 공백 -->
                <c:forEach var="sp" begin="0" end="${ardto.relevel}">
                  	<span class="re-blank"></span>
                </c:forEach>
				<!-- 답글인 경우에만 re 이미지 출력 -->
				<c:if test="${ardto.relevel>0}">
					<span>👉</span>
				</c:if>
			    <div class="re-div">
			    	<div class="re-info">
			    		<p class="profile-img"><img alt="" src="/image/profile-icon.png"></p>
			            <span class="re-writer">댓글 작성자 안됨 ${nick}</span>
			    	</div>
			    	<div class="re-detail" id="re-detail">
			    		<div class="re-content">                
			                <!-- 댓글내용 --> 
			                <div><pre>${ardto.content}</pre></div>	
			                <div class="re-util">                	
					            <span class="re-day">
					                <fmt:formatDate value="${ardto.writeday}" pattern="yy.MM.dd"/>
					                <fmt:formatDate value="${ardto.writeday}" pattern="HH:mm"/>
					            </span>
					            <!-- 로그인시 나타나는 버튼들 -->
					            <c:if test="true">
						        	<a href="javascript:" class="re-re-add-btn">답글쓰기</a>
				                	<a href="javascript:" class="re-del-btn" idx="${ardto.idx}">삭제</a>
			                	</c:if>
			                </div>
				        </div>
				        <!-- 대댓글 -->
			        	<form action="reinsert" method="post" class="re-reply">
							<input type="hidden" name="currentPage" value="${currentPage}">
							<!-- ardto.num은 원글 저장 idx는 게시판 db에서 원글의 번호 -->
							<input type="hidden" name="num" value="${ardto.num}">							
							<!-- 원글번호 불러와서 저장하기(?) 위랑 아래 두개가 같이 있어야 하내 db에 저장되고 불러와짐 -->
							<input type="hidden" name="idx" value="${ardto.idx}">
							<input type="hidden" name="regroup" value="${ardto.regroup}">
							<input type="hidden" name="restep" value="${ardto.restep}">
							<input type="hidden" name="relevel" value="${ardto.relevel}">
							<div class="reply re-reply">
								<div class="re-addcontent">
									<textarea name="content" class="re-retextinput" placeholder="답글을 입력해주세요."
												required="required"></textarea>
								</div>
								<div class="re-items">
									<div class="re-addbtn">
										<button type="submit" class="btn-add btn-sm" id="re-addbtn">등록</button>
									</div>
									<div class="text-count">
										<span class="retext-plus">0</span><span>/100</span>
									</div>
								</div>
							</div>	
						</form>
			    	</div>
			    </div>
		    </c:forEach>
		</c:if>
	</div>
</div>

<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<!-- Initialize Swiper -->
<script>
$(document).ready(function() {
	//로그인 되어 있을 경우,
	if(${isLogin == "Y"}){
		//좋아요 여부로 하트 버튼 변경
		//좋아요 안했을 시,
		if(${likeCheck==0}){
			$("#dibsBtnImg").attr("src","/image/stopheart-icon.gif");
		} else{
			$("#dibsBtnImg").attr("src","/image/fullheart-icon.gif");
		}
	}
});

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
//게시글 삭제
$(function(){
	//삭제 버튼 alert
	$("#deleteBtn").click(function() {
		var idx =  $(this).val();
		var currentPage= $("input[name='current-page']").val();
		
		var n = confirm("정말 게시물을 삭제하시겠습니까?");
		if(n){
			location.href="./auth/delete?idx="+idx+"&currentPage="+currentPage;
		}else{
			return;			
		}
	});

	//댓글 글자수 제한
	$(".re-textinput").keyup(function() {
		var inputlength=$(this).val().length;
		var remain=+inputlength;
		$(".text-plus").html(remain);
		if(remain>=90){
			$(".text-plus").css('color','red');
		}else{
			$(".text-plus").css('color','black');
		}
		
		if(remain>=101){
			alert("100자를 초과했습니다.");
			$(this).val($(this).val().substring(0, 100));
            $(".text-plus").html("100");
		}
	});

	//댓글삭제
	$("a.re-del-btn").click(function() {
	      var idx=$(this).attr("idx");
	      console.log(idx);
	      if(confirm("댓글을 삭제하시겠습니까?")){
	         $.ajax({
	            type:"get",
	            dataType:"html",
	            url:"auth/redelete",
	            data:{
	               "idx":idx
	            },
	            success:function(){
	               alert("댓글을 삭제했습니다.");
	               location.reload();
	            }
	         });
	      }
	   });
	
	/*	대댓글	*/
	//답글달기 클릭시 대댓글 입력창 나타나기
	$(".re-re-add-btn").click(function() {
		$(this).parents(".re-div").siblings().find(".re-reply").hide();
		$(this).parents(".re-div").find(".re-reply").toggle();
	});
	
	//대댓글 글자수 제한
	$(".re-retextinput").keyup(function() {
		var inputlength=$(this).val().length;
		var remain=+inputlength;
		$(".retext-plus").html(remain);
		if(remain>=90){
			$(".retext-plus").css('color','red');
		}else{
			$(".retext-plus").css('color','black');
		}
		
		if(remain>=101){
			alert("100자를 초과했습니다.");
			$(this).val($(this).val().substring(0, 100));
            $(".retext-plus").html("100");
		}
	});
	
	//이미지 상세 보기
	$(".img-detail-view").click(function() {
		$(this).parents(".img-detail-div").siblings().find(".content-img").hide();
		$(this).parents(".img-detail-div").find(".content-img").toggle();
	});
});	
</script>