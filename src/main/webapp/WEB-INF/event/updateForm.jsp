<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<div class="write-form event-div update">
	<input type="hidden" name="idx" value="${dto.idx}">
	<div class="inner">
		<div class="group">
			<div class="child tit">
				이미지 <span class="must">*</span>
			</div>
			<div class="child img-upload">
				<div class="form-group upload-img">
					<label for="chooseFile"> 
						<img src="/image/write-upload-icon.JPG" alt="이미지 등록">
					</label>
					<input type="file" id="chooseFile" name="photo-upload" class="img-input" multiple="multiple"/>
				</div>
				<div class="preview-area">
					<input type="hidden" name="photo" value="${dto.photo}">
					<c:forEach var="photo" items="${photoList}">
						<div class="preview-img">
							<img alt="" src="/photo/${photo}">
							<span class="close"></span>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
		<div class="group">
			<div class="child tit">
				제목 <span class="must">*</span>
			</div>
			<div class="child">
				<input type="text" name="title" class="sub-input" placeholder="글제목" value="${dto.title}">
			</div>
		</div>
		<div class="group">
			<div class="child tit">
				카테고리 <span class="must">*</span>
			</div>
			<div class="child">
				<select id="category" name="category">
					<option value="">선택</option>
					<option ${dto.category=="디지털기기"?"selected":""}>디지털기기</option>
					<option ${dto.category=="의류"?"selected":""}>의류</option>
					<option ${dto.category=="뷰티"?"selected":""}>뷰티</option>
					<option ${dto.category=="인테리어"?"selected":""}>인테리어</option>
					<option ${dto.category=="스포츠"?"selected":""}>스포츠</option>
					<option ${dto.category=="문화생활"?"selected":""}>문화생활</option>
					<option ${dto.category=="기타"?"selected":""}>기타</option>
				</select>
			</div>
		</div>
		<div class="group">
			<div class="child tit">
				이벤트 기간 <span class="must">*</span>
			</div>
			<div class="child">
				<div class="date-form form-div">
					<input type="date" name="event_start" value="${fn:substring(dto.event_start,0,10)}">
					<span>~</span>
					<input type="date" name="event_end" value="${fn:substring(dto.event_end,0,10)}">
				</div>
			</div>
		</div>
		<div class="group">
			<div class="child tit">
				설명 <span class="must">*</span>
			</div>
			<div class="child">
				<textarea name="content" class="text-input" placeholder="설명을 입력해주세요.">${dto.content}</textarea>
			</div>
		</div>
		<div class="btn-wrap">
			<button type="button" class="btn-add event-update-btn" >글쓰기</button>
			<button type="button" class="btn-list" onclick="location.href='list'">취소하기</button>
		</div>		
	</div>
</div>
<script type="text/javascript" src="/js/event_script.js"></script>