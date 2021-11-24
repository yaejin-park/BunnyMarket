<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<link rel="stylesheet" type="text/css" href="/css/product_style.css">

<div class="inner">
<form action="update" method="post" enctype="multipart/form-data">
	<div class="group">
		<div class="child tit">이미지<span class="require">*</span></div>
		<div class="child">
	        <!-- 숨겨진 파일 업로더 -->
       		<input type="file" name="upload" id="chooseFile" accept="image/*" multiple="multiple" hidden="hidden">
			<!-- 보여지는 파일 업로더 -->
			<label for="chooseFile">
	        	<img alt="uploadimg" class="chooseImg child" id="showchooseFile" src="../image/icon-upload.jpg">
	        </label>
       		<div id="imgShow" class="child"></div>
        </div>
    </div>
    <div class="group">
		<div class="title child tit">제목<span class="require">*</span></div>
		<div class="child">
			<input type="text" name="title" placeholder="글제목" required="required" value="${dto.title}">
		</div>
	</div>
	<div class="group">
		<div class="category child tit">카테고리<span class="require">*</span></div>
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
		<div class="price child tit">금액</div>
		<div class="child"><input type="text" name="price" placeholder="금액(숫자만 입력)" required="required" class="child" value="${dto.price}">원</div>
	</div>
	<div class="group">
		<div class="child">
			<textarea class="content" name="content" placeholder="상품설명을 입력해주세요">${dto.content}</textarea>
		</div>
	</div>
	<div class="group">
		<div class="child">
			<button type="submit" class="btn-list">수정하기</button>
			<button type="button" class="btn-default">취소</button>
		</div>
	</div>
</form>
</div>

<script>
$(function(){
	$('#category option[value=${dto.category}]').attr('selected', 'selected');
});

</script>
    

