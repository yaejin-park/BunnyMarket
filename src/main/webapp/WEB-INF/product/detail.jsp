<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<link rel="stylesheet" type="text/css" href="/css/product_style.css">
    
<div class="inner">
<form action="insert" method="post" enctype="multipart/form-data">
	<div class="group">
		<div class="child head">이미지<span class="require">*</span></div>
		<div class="child">
			<label for="chooseFile">
	        	<img class="chooseFile" alt="chooseFile" src="../image/icon-upload.jpg">
	        </label>
       		<input type="file" name="upload" id="chooseFile" accept="image/*" hidden="hidden">
        </div>
      </div>
    <div class="group">
		<div class="title child head">제목<span class="require">*</span></div>
		<div class="child">
			<input type="text" name="title" placeholder="글제목" required="required">
		</div>
	</div>
	<div class="group">
		<div class="category child head">카테고리<span class="require">*</span></div>
		<div class="child">
			<select>
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
		<div class="price child head">금액</div>
		<div class="child"><input type="text" name="title" placeholder="금액(숫자만 입력)" required="required">&nbsp;&nbsp;원</div>
	</div>
	<div class="group">
		<div class="child">
			<textarea class="content" name="content" placeholder="상품설명을 입력해주세요"></textarea>
		</div>
	</div>
</form>
</div>
