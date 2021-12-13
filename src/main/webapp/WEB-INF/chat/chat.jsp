<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="now" value="<%=new java.util.Date()%>" />

<link rel="stylesheet" type="text/css" href="/css/chat_style.css">

<div class="inner">
	<div id="container" class="container">
		<input type="hidden" id="chatHistory" value="${chatHistory}">
		<div class="info">
			<div class="wrap">
				<div class="profile-div">
					<c:if test="${profile == 'no' }">
						<img alt="profile" src="/image/profile-icon.png" class="profile-img">	
					</c:if>
					<c:if test="${profile != 'no' }">
						<img alt="profile" src="/photo/${profile}" class="profile-img">	
					</c:if>
				</div>
				<div class="info-text">
					<div class="tit nick">${nick}</div>
					<div class="sm-tit">후기 ${reviewCount}개</div>
				</div>
				<div class="chatout-btn">
					<button type="button" class="btn-list" id="chatOutBtn">나가기</button>
				</div>
			</div>

			<div class="product-info wrap link">
				<div class="front" onclick="location.href='../../product/detail?idx=${dto.idx}'">
					<div class="thumbNail">
						<img alt="product_thumbnail" src="/photo/${photo}" class="thumbImg" />
					</div>
					<div class="info-text">
						<div class="title-div">
							<div class="status" id="status">${dto.sellstatus}</div>
							<div class="title">${dto.title}</div>
						</div>
						<div class="price tit">
							<fmt:formatNumber type="number" value="${dto.price}" />원
						</div>
					</div>
				</div>
				<!-- 판매완료+ 후기작성에 해당하면, 후기작성버튼 -->
				<c:if test="${dto.sellstatus=='판매완료' && checkReviewee != 0 && checkWrite == 0}">
					<div class="back">
						<button type="button" class="btn-default" id="reviewBtn">후기 작성</button>				
					</div>
				</c:if>
				<!-- 후기작성에 해당하지만, 후기가 있으면 -->
				<c:if test="${dto.sellstatus=='판매완료' && checkWrite != 0 }">
					<div class="back">
						<button type="button" class="btn-default">후기 완료</button>				
					</div>
				</c:if>
			</div>
		</div>

		<div id="chating" class="chating">
			<!-- 채팅 히스토리 -->
			<c:forEach var="chat" items="${chatHistory}">
				<c:set var="thisTime" value="${fn:substring(chat.time,0,10)}"/>
				<c:if test="${thisTime != lastTime || lastTime == null}">
					<fmt:parseDate var="dateString" value="${thisTime}" pattern="yyyy-MM-dd" />
					<div class="date-wrap">
						<div class="date-change">
							<fmt:formatDate value="${dateString}" pattern="yyyy년 MM월 dd일" />
						</div>
					</div>
				</c:if>
			
				<!-- 내가 보낸 메세지 -->
				<c:if test="${chat.sender == id}">
					<div class='me'>
						<div class='time'>
							<fmt:parseDate var="dateString" value="${chat.time}" pattern="yyyy-MM-dd HH:mm:ss" />
							<fmt:formatDate value="${dateString}" pattern="a hh:mm" />
						</div>
						<div class='speech-bubble'>
							<p>${chat.msg }</p>
						</div>
					</div>
				</c:if>
				
				<!-- 상대방이 보낸 메세지 -->
				<c:if test="${chat.sender != id}">
					<div class='other'>
						<div class='speech-bubble other-bubble'>
							<p>${chat.msg }</p>
						</div>
						<div class='time'>
							<fmt:parseDate var="dateString" value="${chat.time}" pattern="yyyy-MM-dd HH:mm:ss" />
							<fmt:formatDate value="${dateString}" pattern="a hh:mm" />
						</div>
					</div>
				</c:if>
				<c:set var="lastTime" value="${fn:substring(chat.time,0,10)}"/>
			</c:forEach>
		</div>

		<form:form modelAttribute="ChatDTO" name="msg-form" class="msgForm">
			<input type="hidden" name="chat_idx" id="chat_idx" value="${chat_idx}">
			<input type="hidden" name="sessionId" id="sessionId" value="${id}">
			<input type="hidden" name="userName" id="userName" value="${nick}">
			<input type="hidden" name="roomNumber" id="roomNumber" value="${roomNumber}">
			<input type="hidden" name="idx" id="idx" value="${dto.idx}">
			<input type="hidden" name="seller" id="seller" value="${dto.id}">
			<textarea class="chat-box" name="msg" id="chatting"
				placeholder="메세지를 입력해주세요"></textarea>
			<div class="chat-btn-div">
				<button type="button" class="btn-add" onclick="first()" id="sendBtn">전송</button>
			</div>
		</form:form>
	</div>
	
	<div class="btn-wrap back">
		<button type="button" class="btn-default"
			onclick="location.href='../../product/detail?idx=${dto.idx}'">뒤로가기</button>
	</div>
</div>


<!-- 별점 팝업 -->
<div class="popup-modal" id="insertPop">
	<div class="modal">
		<div class="modal-title">${yournick}님과의 거래후기는?</div>
			<div class="modal-content" id="pop-insert">
				<input type="hidden" name="reviewer" value="${reviewer}" id="reviewer">
				<input type="hidden" name="reviewee" value="" id="reviewee">
				<input type="hidden" name="idx" value="${idx}" id="idx">

				<div id="my-rating">
					<fieldset> 
						<legend>이모지 별점</legend>
						<input type="radio" name="star" value="5" id="rate1">
						<label for="rate1">⭐</label> 
						<input type="radio" name="star" value="4" id="rate2">
						<label for="rate2">⭐</label> 
						<input type="radio" name="star" value="3" id="rate3">
						<label for="rate3">⭐</label> 
						<input type="radio" name="star" value="2" id="rate4">
						<label for="rate4">⭐</label> 
						<input type="radio" name="star" value="1" id="rate5">
						<label for="rate5">⭐</label>
					</fieldset>
				</div>
				
				<textarea placeholder="선택사항" name="content" id="popcontent"></textarea>
				<div class="btn-wrap">
					<button type="button" class="btn-add" id="btn-pop-insert">등록</button>
				</div>
			
				<input type="hidden" id="isLogin" value="${isLogin}">
		</div>	
		<button type="button" class="modal-close">닫기</button>
	</div>	
</div>

<script type="text/javascript">
//스크롤 항상 제일 밑으로
$(".chating").scrollTop($(".chating")[0].scrollHeight);

var ws;

function wsOpen() {
	ws = new WebSocket("ws://" + location.host + "/chating/"+ $("#roomNumber").val());
	wsEvt();
}

function wsEvt() {
	ws.onopen = function(data) {
		//소켓이 열리면 동작
	}

	ws.onmessage = function(data) {
		//메시지를 받으면 동작
		var msg = data.data;

		//채팅메세지가 존재하면,
		if (msg != null && msg.trim() != '') {
			var d = JSON.parse(msg);
			if (d.type == "sessionOpen") {
				var si = d.sessionId != null ? d.sessionId : "";
				if (si != '') {
					$("#sessionId").val(si);
				}
			} else if (d.type == "message") {
				//현재 시간
				var today = new Date();   
				var now = today.getFullYear()+"-"+(today.getMonth()+1)+"-"+today.getDate(); // 년도
				
				//날짜 출력
				//한번도 날짜가 찍힌적이 없으면 날짜 출력
				if($(".date-change").length==0){
					var s = '<div class="date-wrap"><div class="date-change">';
					s += now.replace('-','년 ').replace('-', '월 ')+'일</div></div>';
					
					$("#chating").append(s);
				} else{
					//시간이 다르면
					if('${lastTime}' != now){
						var s = '<div class="date-wrap"><div class="date-change">';
						s += now.replace('-','년 ').replace('-', '월 ')+'일</div></div>';
						
						$("#chating").append(s);
					}
				}
				
				if (d.sessionId == $("#sessionId").val()) {
					$("#chating").append(
					"<div class='me'><div class='time'><fmt:formatDate value="${now }" type="time" pattern="a hh:mm"/></div>"
					+"<div class='speech-bubble'><p>"+ d.msg + "</p></div></div>"+
					"<c:set var='lastTime' value='${fn:substring(chat.time,0,10)}'/>");
				} else {
					$("#chating").append(
					"<div class='other'><div class='speech-bubble other-bubble'><p>"+ d.msg
					+ "</p></div><div class='time'><fmt:formatDate value="${now }" type="time" pattern="a hh:mm"/></div></div>"+
					"<c:set var='lastTime' value='${fn:substring(chat.time,0,10)}'/>");
				}
				//스크롤 항상 제일 밑으로
				$(".chating").scrollTop($(".chating")[0].scrollHeight);
			} else {
				console.warn("unknown type!")
			}
		}
	}

/* 	//엔터눌러도 보내지게
	document.addEventListener("keypress", function(e) {
		if (e.keyCode == 13) {
			if ($("#sendBtn").attr("onClick") == "first()") {
				first();
			} else {
				send();
			}
			$("#chatting").val("");
		}
	}); */
}

//소켓 열기
wsOpen();

//첫번째 메세지
function first() {
	console.log("first");
	//이벤트 변경
	$("#sendBtn").attr("onclick", "send()");
	var idx = $("#idx").val();
	var seller = $("#seller").val();
	var roomNumber = $("#roomNumber").val();
	var msg = $("#chatting").val();
	msg = msg.replaceAll(/(\n|\r\n)/g,'<br>');
	//현재 시간
	var today = new Date();   
	var now = today.getFullYear()+"-"+(today.getMonth()+1)+"-"+today.getDate(); // 년도

	//방 만들기
	$.ajax({
		type : "post",
		url : "firstSend",
		data : {
			"idx" : idx,
			"seller" : seller,
			"roomNumber" : roomNumber,
			"msg" : msg
		},
		success : function(data) {
			$("#chat_idx").val(data.chat_idx);
		},
		error : function(data) {
			console.log("에러", data);
		} 
	});

	var option = {
		type : "message",
		roomNumber : $("#roomNumber").val(),
		sessionId : $("#sessionId").val(),
		userName : $("#userName").val(),
		msg : $("#chatting").val()
	}
	ws.send(JSON.stringify(option))

	$('#chatting').val("");
}

//메세지 전송 버튼 눌렀을 때,
function send() {
	console.log("send");
	
	var msg = $("#chatting").val();
	msg = msg.replaceAll(/(\n|\r\n)/g,'<br>');

	var data = {
		chat_idx : $("#chat_idx").val(),
		product_idx : $("#idx").val(),
		sender : $("#sessionId").val(),
		seller_id : $("#seller").val(),
		msg : msg
	}

	//send 저장
	$.ajax({
		type : "post",
		url : "send",
		data : data,
		success : function() {
			console.log("send success");
		},
		error : function(data) {
			console.log("send 에러", data);
		}
	});

	var option = {
		type : "message",
		roomNumber : $("#roomNumber").val(),
		sessionId : $("#sessionId").val(),
		userName : $("#userName").val(),
		msg : msg
	}
	ws.send(JSON.stringify(option))

	//채팅메세지 사라지게
	$('#chatting').val("");
}

//판매상태 폰트 색상
if ($("#status").text() == "판매완료") {
	$("#status").css("color", "#979593");
} else if ($("#status").text() == "예약중") {
	$("#status").css("color", "#ff7ab0");
} else if ($("#status").text() == "판매중") {
	$("#status").css("color", "#3088d4");
}

//후기작성 버튼
$(document).on("click","#reviewBtn",function(){
	var chooseNick = $(this).find(".name").find("span").text();
	popClose("#choosePop");
	popOpen("#insertPop");
	$(".choose-nick").text(chooseNick);
	$('input[name=reviewee]').attr('value',chooseNick);
});

//후기 등록 눌렀을 때,
$("#btn-pop-insert").click(function(){
	star = $('input:radio[name="star"]:checked').val();
	reviewer =$('#reviewer').val();
	reviewee =$('#seller').val();
	content=$('#popcontent').val();
	idx=$('#idx').val();
	
	if(star == null){
		alert("별점을매겨주세요.");
		return;
	}
	
	console.log(content);
	$.ajax({
	    url: "../../product/popinsert",
	    type: "post",
	    datatype:"txt",
	    data:{
	    	"star" : star,
	    	"reviewer":reviewer,
	    	"reviewee":reviewee,
	    	"content":content,
	    	"idx":idx
	    },
	    success: function (data) {
	    	console.log(star, reviewer, reviewee, content, idx, data);
            alert("후기 작성 성공");
            popClose("#insertPop");
        }, error: function (data) {
        	console.log("실패", star, reviewer, reviewee, content, idx, data);
		}
	});
})

//채팅방 나가기
$("#chatOutBtn").click(function() {
	var result = confirm("정말 채팅방을 나가시겠습니까?\n나간 채팅방의 데이터는 복구되지 않습니다");
	if (result) {
		//채팅방 delete
		location.href = "deleteChat?chat_idx="+$('#chat_idx').val() + "&id=" + $('#sessionId').val() + "&idx=" + $('#idx').val();
		//console.log("delete");
	} else {
		return;
	}
});
</script>