<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link rel="stylesheet" type="text/css" href="/css/chat_style.css">

<div class="inner">
	<div class="list-room">
		<div class="chat-list">
			<div class="wrap">
				<img alt="profile" src="/image/profile-icon.png" class="profile-img me">
				<div class="info-text">
					<span class="tit nick">${nick}</span>
				</div>
			</div>
			
			<!-- 채팅리스트 X -->
			<c:if test="${chlist.size() == 0}">
				<h1>no-image</h1>
			</c:if>
			
			<!-- 채팅리스트 O -->
			<c:if test="${chlist.size() != 0}">
				<c:forEach var="one" items="${chlist}">
					<div class="alist">
						<div class="alist-info">
							<div class="profile-div">
								<img alt="profile" src="/image/profile-icon.png" class="profile-img">
							</div>
							<div class="list-info">
								<div class="tit">
									${one.nickname}
								</div>
								<div class="msg">
									${one.chat_file}
								</div>
							</div>
						</div>
						<div class="thumbNail">
							<c:set var="thumbNail" value="${fn:split(one.upload_file,',')[0]}"/>
							<img alt="product_thumbnail" src="/photo/${thumbNail}" class="thumbImg"/>
						</div>
					</div>
				</c:forEach>
			</c:if>
		</div>
		
		
		<!-- 채팅방 -->
		<!-- 채팅방 클릭 안했을 때 -->
		<div id="container" class="container">
		
		<div class="nodata">
			<p class="icon">
				<img alt="" src="/image/nodata-icon.png">
			</p>
			<p class="tit">채팅할 상대를 선택해주세요.</p>
			<p>선택된 채팅이 없습니다.</p>
		</div>
		
		<div id="roomShow">
		<input type="hidden" id="chatHistory" value="${chatHistory}">
		<div class="info">
			<div class="wrap">
				<img alt="profile" src="/image/profile-icon.png" class="profile-img">
				<div class="info-text">
					<span class="tit nick">${nick}</span> <span class="sm-tit">후기</span>
				</div>
				<div class="chatout-btn">
					<button type="button" class="btn-list" id="chatOutBtn">나가기</button>
				</div>
			</div>

			<div class="wrap link" onclick="location.href='../../product/detail?idx=${dto.idx}'">
				<img alt="product-image" src="../../photo/${photo}" class="product-img">
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
		</div>

		<div id="chating" class="chating">
			<c:forEach var="chat" items="${chatHistory}">
				<c:if test="${chat.sender == myId}">
					<div class='me'>
						<div class='time'>
							<fmt:parseDate var="dateString" value="${chat.time}" pattern="yyyy-MM-dd HH:mm:ss" />
							<fmt:formatDate value="${dateString}" pattern=" HH:mm" />
						</div>
						<div class='speech-bubble'>
							<p>${chat.msg }</p>
						</div>
					</div>
				</c:if>
				<c:if test="${chat.sender != myId}">
					<div class='other'>
						<div class='speech-bubble other-bubble'>
							<p>${chat.msg }</p>
						</div>
						<div class='time'>
							<fmt:parseDate var="dateString" value="${chat.time}" pattern="yyyy-MM-dd HH:mm:ss" />
							<fmt:formatDate value="${dateString}" pattern="HH:mm" />
						</div>
					</div>
				</c:if>
			</c:forEach>
		</div>

		<form:form modelAttribute="ChatDTO" name="msg-form" class="msgForm">
			<input type="hidden" name="chat_idx" id="chat_idx"
				value="${chat_idx}">
			<input type="hidden" name="sessionId" id="sessionId" value="${myId}">
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
	</div>
		<div class="btn-wrap">
			<button type="button" class="btn-default" onclick="history.back()">뒤로가기</button>
		</div>
	</div>

</div>

<script>
	$("#roomShow").hide();
</script>