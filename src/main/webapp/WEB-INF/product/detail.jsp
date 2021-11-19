<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
    
    
<div class="inner">
<form action="insert" method="post" enctype="multipart/form-data">
	<div class="">이미지<span class="require">*</span></div>
	<div><input type="file" name="upload"></div>
	<div class="title">제목</div>
	<div>
		<input type="text" name="title" placeholder="글제목" required="required">
	</div>
	<div class="category">카테고리</div>
	<div><select></select> </div>
	<div class="price">금액</div>
	<div><input type="text" name="title" placeholder="금액(숫자만 입력)" required="required">원</div>
		
</form>
</div>
