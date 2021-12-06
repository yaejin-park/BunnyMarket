<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" type="text/css" href="/css/local_style.css">
<div class="local-map-div">
	<div class="map-area">
		<div id="map"></div>
	</div>
	<div class="choose-div">
		<div class="inner">
			<input type="hidden" name="current-local">
			<div class="title-div">
				<p class="tit">동네 선택</p>
				<p>지역은 최소 1개 이상 최대 2개까지 설정 가능해요.</p>
			</div>
			<ul class="user-local-list">
				<c:forEach var="local" items="${localArr}">
					<li>
						<span>${local}</span>
						<a href="javascript:" class="delete-btn">삭제</a>
					</li>
				</c:forEach>
				<c:if test="${localCnt == 1}">
					<li class="plus-type">
						<a href="javascript:" class="plus-btn"></a>
					</li>
				</c:if>
			</ul>
			
			<div class="search-area">
				<div class="search-div">
					<input type="text" name="local-search" placeholder="검색할 지역을 입력해주세요." />
					<button type="button" class="btn-list local-search-btn">검색</button>
				</div>
				<div class="result-div"></div>
			</div>
			
			<div class="btn-wrap">
				<a href="javascript:" class="btn-add local-set-btn">설정완료</a>
			</div>
		</div>
	</div>
</div>

<div class="popup-modal" id="setCurrentPop">
	<div class="modal">
		<div class="modal-title">현재위치</div>
		<div class="modal-content">
			<p class="txt"></p>
			<div class="btn-wrap">
				<a href="javascript:" class="btn-add yes-btn">네</a>
				<a href="javascript:" class="btn-default" onclick="popClose('#setCurrentPop')">아니오</a>
			</div>
		</div>
		<button type="button" class="modal-close">닫기</button>
	</div>
</div>
<div class="popup-modal" id="setLocalPop">
	<div class="modal">
		<div class="modal-title">지역 설정</div>
		<div class="modal-content">
			<p class="txt"></p>
			<div class="btn-wrap">
				<a href="javascript:" class="btn-add yes-btn">네</a>
				<a href="javascript:" class="btn-default" onclick="popClose('#setLocalPop')">아니오</a>
			</div>
		</div>
		<button type="button" class="modal-close">닫기</button>
	</div>
</div>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=77q47uvszo&submodules=geocoder"></script>
<script type="text/javascript" src="/js/local_script.js"></script>