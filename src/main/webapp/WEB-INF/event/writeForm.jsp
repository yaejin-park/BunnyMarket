<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<div class="write-form event-div">
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
				<div class="preview-area"></div>
			</div>
		</div>
		<div class="group">
			<div class="child tit">
				제목 <span class="must">*</span>
			</div>
			<div class="child">
				<input type="text" name="title" class="sub-input" placeholder="글제목">
			</div>
		</div>
		<div class="group">
			<div class="child tit">
				카테고리 <span class="must">*</span>
			</div>
			<div class="child">
				<select id="category" name="category">
					<option value="">선택</option>
					<option>디지털기기</option>
					<option>의류</option>
					<option>뷰티</option>
					<option>인테리어</option>
					<option>스포츠</option>
					<option>문화생활</option>
					<option>기타</option>
				</select>
			</div>
		</div>
		<div class="group">
			<div class="child tit">
				이벤트 기간 <span class="must">*</span>
			</div>
			<div class="child">
				<div class="date-form form-div">
					<input type="date" name="event_start">
					<span>~</span>
					<input type="date" name="event_end">
				</div>
			</div>
		</div>
		<div class="group">
			<div class="child tit">
				설명 <span class="must">*</span>
			</div>
			<div class="child">
				<textarea name="content" class="text-input" placeholder="설명을 입력해주세요."></textarea>
			</div>
		</div>
		<div class="btn-wrap">
			<button type="button" class="btn-add event-add-btn" >글쓰기</button>
			<button type="button" class="btn-list" onclick="location.href='list'">취소하기</button>
		</div>		
	</div>
</div>
<script type="text/javascript" src="/js/event_script.js"></script>