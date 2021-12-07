<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="now" value="<%=new java.util.Date() %>"/>

<link rel="stylesheet" type="text/css" href="/css/chat_style.css">

<div class="inner">
<div id="container" class="container">
	<div class="info">
		<div class="wrap">
			<input type="hidden" name="userName" id="userName" value="${nick}">
			<input type="hidden" id="roomNumber" value="${roomNumber}">
			<input type="hidden" id="idx" value="${dto.idx}">
			<input type="hidden" id="seller" value="${dto.id}">
			<img alt="profile" src="/image/profile-icon.png" class="profile-img">
			<div class="info-text">
				<span class="tit nick">${nick}</span>
				<span class="sm-tit">후기</span>	
			</div>
			<div class="chatout-btn">
				<button type="button" class="btn-list">채팅방 나가기</button>
			</div>
		</div>
		
		<div class="wrap link" onclick="location.href='../product/detail?idx=${dto.idx}'">
			<img alt="product-image" src="../photo/${photo}" class="product-img">
			<div class="info-text">
				<div class="title">${dto.title}</div>
				<div class="price tit">
					<fmt:formatNumber type="number" value="${dto.price}"/>원
				</div>
			</div>
			<div class="status-div">
				<div class="status" id="status">${dto.sellstatus}</div>
			</div>
		</div>
	</div>
	
	<div id="chating" class="chating">
	</div>
	
	<form class="msgForm">
		<input type="hidden" id="sessionId" value="${myId}">
		<textarea class="chat-box" name="msg" id="chatting" placeholder="메세지를 입력해주세요"></textarea>
		<div class="chat-btn-div">
			<button type="button" class="btn-add" onclick="first()" id="sendBtn">전송</button>
		</div>
	</form>
	
	<div class="btn-wrap">
		<button type="button" class="btn-list" onclick="">목록</button>
		<button type="button" class="btn-default" onclick="redirect:product/detail?idx=${dto.idx }">취소</button>
	</div>
</div>
	<br>
	data : <fmt:formatDate value="${now }" type="date"/><br>
	time : <fmt:formatDate value="${now }" type="time" pattern=" hh:mm"/><br>
	both : <fmt:formatDate value="${now }" type="both"/><br>
	<br>
</div>
<script type="text/javascript">
var ws;

function wsOpen(){
	ws = new WebSocket("ws://" + location.host + "/chating/"+$("#roomNumber").val());
	wsEvt();
}


function wsEvt() {
	ws.onopen = function(data){
		//소켓이 열리면 동작
	}
	
	ws.onmessage = function(data) {
		//메시지를 받으면 동작
		var msg = data.data;
		if(msg != null && msg.trim() != ''){
			var d = JSON.parse(msg);
			if(d.type == "getId"){
				var si = d.sessionId != null ? d.sessionId : "";
				//var si = d.sessionId != null ? d.sessionId : "";
				if(si != ''){
					$("#sessionId").val(si); 
				}
			}else if(d.type == "message"){
				if(d.sessionId == $("#sessionId").val()){
					$("#chating").append("<div class='me'><div class='time'><fmt:formatDate value="${now }" type="time" pattern=" hh:mm"/></div><div class='speech-bubble'><p>" + d.msg + "</p></div></div>");	
				}else{
					$("#chating").append("<div class='other'><div class='speech-bubble other-bubble'><p>" + d.msg + "</p></div><div class='time'><fmt:formatDate value="${now }" type="time" pattern=" hh:mm"/></div></div>");
				}
				//스크롤 항상 제일 밑으로
				$(".chating").scrollTop($(".chating")[0].scrollHeight);
			}else{
				console.warn("unknown type!")
			}
		}
	}
	
	//엔터눌러도 보내지게
	document.addEventListener("keypress", function(e){
		if(e.keyCode == 13){ 
			if($("#sendBtn").attr("onClick")=="first()"){
				first();
			} else{
				send();
			}
		}
	});
}

//소켓 열기
wsOpen();

//첫번째 메세지
function first(){
	console.log("first");
	//이벤트 변경
	$("#sendBtn").attr("onClick", "send()");
	var idx = $("#idx").val();
	var id = $("#sessionId").val();
	var seller = $("#seller").val();
	var roomNumber = $("#roomNumber").val();
	
	console.log(idx,"idx",id,"id",roomNumber);
	
	//방 만들기
	$.ajax({
		type : "post",  
        url : "firstSend",       
        data : {"idx" : idx, "id" : id, "seller": seller , "roomNumber" : roomNumber},
        success : function (data) {
        	console.log("makeroom");
		}, error: function (data) {
			console.log("에러", data);
		}
	}); 
	
	var option ={
		type: "message",
		roomNumber: $("#roomNumber").val(),
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
	var option ={
		type: "message",
		roomNumber: $("#roomNumber").val(),
		sessionId : $("#sessionId").val(),
		userName : $("#userName").val(),
		msg : $("#chatting").val()
	}
	ws.send(JSON.stringify(option))
	
	/* //채팅방 생성
	if($(".speech-bubble").is); */
	
	$('#chatting').val("");
}




//판매상태 폰트 색상
if($("#status").text() == "판매완료"){
	$("#status").css("color","#979593");
	$("#status").css("border-color","#979593");
} else if($("#status").text() == "예약중"){
	$("#status").css("color", "#ff7ab0");
	$("#status").css("border-color","#ff7ab0");
} else if($("#status").text() == "판매중"){
	$("#status").css("color", "#3088d4");
	$("#status").css("border-color","#3088d4");
}

</script>