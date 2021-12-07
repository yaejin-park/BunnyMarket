<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link rel="stylesheet" type="text/css" href="/css/swiper.min.css">
<link rel="stylesheet" type="text/css" href="/css/product_style.css">

<div class="inner">
<div class="infoAll">
	<div class="img group">
		<div class="detail-swiper">
			<div class="bigImgDiv swiper-wrapper">
				<c:forEach items="${photo}" var="photo">
					<div class="swiper-slide bigImg fix">
						<img class="bigImage" alt="thumbnail" src="../photo/${photo}" />
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
				${nick}
			</td>
			<td rowspan="2" class="detailBtn">
				<button type="button" class="btn-list" id="follow">+ 팔로우</button>
			</td>
		</tr>
		<tr>
			<td class="tit-sm verticalTop">
				후기
			</td>
		</tr>	
		<tr>
			<td colspan="3" class="tit-sm"><a href="list?category=${dto.category}">${dto.category}</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<fmt:formatDate value="${dto.writeday }" pattern="yy.MM.dd"/></td>
		</tr>
		<tr class="needHeight">
			<!-- 작성자가 아닐 경우-->
			<c:if test="${myId != dto.id}">
				<c:if test="${dto.sellstatus !='판매중' }">
					<td class="sellstatus verticalBottom">
						<span class="${dto.sellstatus=='판매중'?'selling':dto.sellstatus=='예약중'?'reserved':'finished'} tit">${dto.sellstatus}</span>
					</td>
				</c:if>
			</c:if>
			<c:if test="${myId == dto.id}">
				<td class="verticalBottom">
					<select name="sellstaus" class="statusSelect" id="statusSelect">
						<option class="tit selling" value="selling">판매중</option>
						<option class="tit reserved" value="reserved">예약중</option>
						<option class="tit finished" value="finished">판매완료</option>
					</select>
				</td>
			</c:if>
			<td ${dto.sellstatus=='판매중' && dto.id != myId ?'colspan="3"':'colspan="2"'} class="tit verticalBottom">
				<p class="productTitle">${dto.title}</p>
			</td>
		</tr>
		<tr class="needHeight">
			<td colspan="3" class="tit verticalTop">
				<fmt:formatNumber>${dto.price} </fmt:formatNumber>원
			</td>
		</tr>
		<tr>
			<td colspan="3" class="tit-sm">
				<div class="info-sm">   
					<div class="info-sm-div">
						<div class="chat icon-sm">${dto.chatcount}</div>
					</div>
					<div class="info-sm-div">
						<div class="dibs icon-sm">${dto.likecount}</div>
					</div>
					<div class="info-sm-div">
						<div class="read icon-sm">${dto.readcount}</div>
					</div>
				</div>
			</td>
		</tr>
		<tr class="lineNeed">
			<td class="marginZero">
				<button type="button" id="dibs" onclick="dibsClicked()"><img src="/image/stopheart-icon.gif" alt="dibsButton" id="dibsBtnImg"></button>
			</td>
			<!-- 작성자가 아니면 -->
			<c:if test="${myId != dto.id}">
				<td colspan="2">
					<button type="button" class="btn-delete chat-btn" id="chatBtn">채팅하기</button>
				</td>
			</c:if>
			<!-- 작성자면 -->
			<c:if test="${myId == dto.id}">
				<td colspan="2" class="detailBtn">
					<button type="button" class="btn-update" onclick="location.href='updateForm?idx=${dto.idx}'">수정</button>
					<button type="button" id="deleteBtn" class="btn-delete" value="${dto.idx}">삭제</button>
				</td>
			</c:if>
		</tr>
	</table>
	</div>
</div>

	<div>
		<pre class="detailContent">${dto.content}</pre>
	</div>
	
	<div class="btn-wrap bottomBoreder">
		<button type="button" class="btn-list" onclick="location.href='list?currentPage=${currentPage}'">목록</button>
	</div>
	
	<!-- 연관상품 -->
	<div class="relative group">
		<div class=" tit-bottom">
			<div class="tit child">연관상품</div>
			<div class="child tit-sm more">
				<a href="list?category=${dto.category}">
					더보기>
				</a>
			</div>
		</div>
		<div class="relative-list">
		<c:if test="${list.size()==0}">
			<div class="nodata">
				<p class="icon">
					<img alt="" src="/image/nodata-icon.png">
				</p>
				<p>등록된 데이터가 존재하지 않습니다.</p>
			</div>
		</c:if>
		<c:if test="${list.size()!=0}">
			<div class="group">
				<c:forEach items="${list}" var="one">
					<c:set var="thumbName" value="${fn:split(one.uploadfile,',')[0]}" />
					<div class="oneList child" onclick="location.href='detail?idx=${one.idx}&currentPage=${currentPage}'">
						<div class="thumbnailDiv">
							<img alt="thumbnail" src="../photo/${thumbName}"class="thumbnail">
						</div>
						<div class="info-div">
							<div class="shortTit">${one.title}</div>
							<div>
								<div class="tit">
									<fmt:formatNumber type="number" value="${one.price}"/>원
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</c:if>
	</div>
</div>
<input type="hidden" id="sellstatus" name="sellstatus" value="${dto.sellstatus}">
</div>

<script type="text/javascript" src="/js/swiper.min.js"></script>
<script>
$(document).ready(function() {
	//로그인 되어 있을 경우,
	if(${isLogin == "Y"}){
		//좋아요 여부로 하트 버튼 변경
		//좋아요 안했을 시,
		if(${==0}){
			$("#dibsBtnImg").attr("src","/image/stopheart-icon.gif");
		} else{
			$("#dibsBtnImg").attr("src","/image/fullheart-icon.gif");
		}
		
		//팔로우 여부로 팔로우 버튼 변경
		//팔로우 했을 시,
		if(${followCheck != 0}){
			$("#follow").addClass("btn-add");
			$("#follow").removeClass("btn-list");
			$("#follow").html("팔로잉");
		}
		//유저가 판매자일 경우,
		if(${myId == dto.id}){
			//판매상태 dto에 맞게 선택되게
			$("#statusSelect").val($('#sellstatus').val()).attr("selected","selected");
			console.log($("#statusSelect").val());
			//판매상태에 따라 글씨색 바뀌기
			if($("#statusSelect").val() == "finished"){
				$("#statusSelect").css("color","#979593");
			} else if($("#statusSelect").val() == "reserved"){
				$("#statusSelect").css("color", "#ff7ab0");
			} else if($("#statusSelect").val() == "selling"){
				$("#statusSelect").css("color", "#3088d4");
			}
		}
	}
});

//미리보기 이미지 클릭시,
/* $(document).on("click",".smallImg", function(e) {
	var src = $(this).attr("src");
	$(".bigImage").attr("src",src);
}); */

/* //미리보기 이미지 호버시,
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
}); */

//찜버튼 클릭시
function dibsClicked(){
	var idx = ${dto.idx};
	console.log("dibs");
	//로그인 여부
	//로그인 안했을 경우
	if(${isLogin != "Y"}){
		alert("로그인 이후, 사용가능합니다");
		return;
	}  else{ //로그인 했을 경우
		//버튼 이미지 변경
		if($("#dibsBtnImg").attr("src")=="/image/stopheart-icon.gif"){
			$("#dibsBtnImg").attr("src","/image/movingheart-icon.gif");
			$.ajax({
				type : "post",  
		        url : "updateLikecount",       
		        dataType : "json",   
		        data : {"idx":idx},
		        success : function (data) {
					$("#likecount").html(data);
		        	console.log("success+");
				}
			});
		} else{
			$("#dibsBtnImg").attr("src","/image/stopheart-icon.gif");
			$.ajax({
				type : "post",  
		        url : "updateLikeMinuscount",       
		        dataType : "json",   
		        data : {"idx":idx},
		        success : function (data) {
					$("#likecount").html(data);
		        	console.log("success-");
				}
			});
		}
	}
}

//팔로우 버튼 클릭시
$(document).on("click","#follow", function() {
	//로그인 여부
	//로그인 안했을 경우
	if(${isLogin!="Y"}){
		alert("로그인 이후, 이용가능한 서비스입니다.");
		return;
	}  else{
		console.log("login됨");
	//로그인 했을 경우
		var followee = "${dto.id}";
		var follower = "${myId}";
		var idx = "${dto.idx}";
		
		//나를 팔로우 눌렀을 경우
		if(follower==followee){
			alert("본인을 팔로우할 수 없습니다.");
			return;
		} else{
			//버튼 클래스 변경
			//팔로우 안했을 경우,
			if($("#follow").attr("class") == "btn-list" ){
				$.ajax({
					type : "post",  
			        url : "../follow",       
			        dataType : "text",   
			        data : {"followee":followee, "follower":follower},
			        success : function (data) {
			        	$("#follow").removeClass("btn-list");
						$("#follow").addClass("btn-add");
						$("#follow").html("팔로잉");
			        	alert("팔로우 되었습니다.");
					},
					error : function(e){
		                console.log("통신 에러",e);
		            }
				});
			} else{ //팔로우했을 경우,
				$.ajax({
					type : "post",  
			        url : "../unfollow",       
			        dataType : "text",   
			        data : {"followee":followee, "follower":follower},
			        success : function (data) {
			        	$("#follow").removeClass("btn-add");
						$("#follow").addClass("btn-list");
						$("#follow").html("+ 팔로우");
						alert("팔로우가 취소되었습니다.");
					},
					error : function(e){
		                console.log("통신 에러",e);
		            }
				});
			}
		}
	}
});

//채팅 버튼 클릭시
$(document).on("click","#chatBtn", function() {
	//로그인 여부
	//로그인 안했을 경우
	if(${isLogin!="Y"}){
		alert("로그인 이후, 이용가능한 서비스입니다.");
		return;
	}  else{
		//로그인 했을 경우
		var id = "${myId}";
		var idx = "${dto.idx}";
		
		location.href ='../chat/room?idx='+idx+"&id="+id;
	}
});

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

//판매상태 변경
$(document).on("change", "#statusSelect", function() {
	var idx = ${dto.idx};
	var status = $("#statusSelect").val();
	//console.log(status);

	//판매상태 변경(product)
	$.ajax({
		type : "post",  
		url : "updateStatus",     
        dataType : "text",   
        data : {"idx":idx, "status":status},
        success: function(){
        	//판매상태에 따라 글씨색 바뀌기
			if($("#statusSelect").val() == "finished"){
				$("#statusSelect").css("color","#979593");
			} else if($("#statusSelect").val() == "reserved"){
				$("#statusSelect").css("color", "#ff7ab0");
			} else if($("#statusSelect").val() == "selling"){
				$("#statusSelect").css("color", "#3088d4");
			}
        	setTimeout(() => {
        		alert("판매상태 변경 완료");
			}, 100);
        },
        error: function(e){
        	console.log("Status error",e);
        }
	}); 
});

</script>

