<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" type="text/css" href="/css/product_style.css">
<div class="write-form">
	<div class="inner">
		<form action="update" method="post" enctype="multipart/form-data">
			<input type="hidden" name="sellstatus" value="판매중">
			<input type="hidden" name="local" id="local" value="">
			<input type="hidden" name="idx" value="${dto.idx }">
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
					<div class="preview-area"></div>
				</div>
			</div>
			<div class="group">
				<div class="child tit">
					제목<span class="must">*</span>
				</div>
				<div class="child">
					<input type="text" name="title" class="subinput" placeholder="글제목"
						required="required" value="${dto.title}">
				</div>
			</div>
			<div class="group">
				<div class="child tit category">
					카테고리<span class="must">*</span>
				</div>
				<div class="child">
					<select id="category" name="category">
						<option disabled="disabled" selected="selected">선택</option>
						<option value="디지털기기">디지털기기</option>
						<option value="의류">의류</option>
						<option value="뷰티">뷰티</option>
						<option value="인테리어">인테리어</option>
						<option value="스포츠">스포츠</option>
						<option value="문화생활">문화생활</option>
						<option value="기타">기타</option>
					</select>
				</div>
			</div>
			<div class="group">
				<div class="price child tit">
					금액<span class="must">*</span>
				</div>
				<div class="child">
					<input type="number" name="price" class="subinput price child"
						placeholder="금액(숫자만 입력)" required="required" value="${dto.price}">
					<div class="child won">원</div>
				</div>
			</div>

			<div class="group">
				<div class="child tit">
					설명 <span class="must">*</span>
				</div>
				<div class="child">
					<textarea class="textinput" name="content"
						placeholder="상품설명을 입력해주세요" required="required">${dto.content}</textarea>
				</div>
			</div>

			<div class="group">
				<div class="btn-wrap">
					<button type="submit" class="btn-list">수정하기</button>
					<button type="button" class="btn-default" onclick="history.back()">취소</button>
				</div>
			</div>
		</form>
	</div>
</div>

<script>
$(function(){
	$('#category option[value=${dto.category}]').attr('selected', 'selected');
});

//지역설정
$("#local").val($(".local-btn").text());

</script>
<script type="text/javascript" src="/js/event_script.js"></script>
