<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="/css/ad_style.css">
<div class="write-form">
	<div class="inner">
		<form id="addForm">
			<div class="group">
				<div class="child tit">
					이미지 <span class="must">*</span>
				</div>
				<div class="child imgupload">
					<div class="uploadImg">
						<label for="photoupload"> 
							<img src="../image/write-upload-icon.JPG">
						</label>
						<input type="file" id="photoupload" name="photoupload" class="imginput" multiple="multiple" accept="image/*" onchange="loadFile(event)">
					</div>
					<div class="previewarea"></div>
				</div>
			</div>
			<div class="group">
				<div class="child tit">
					제목 <span class="must">*</span>
				</div>
				<div class="child">
					<input type="text" name="title" class="subinput" placeholder="글제목" required="required">
				</div>
			</div>
			<div class="group">
				<div class="child tit">
					설명 <span class="must">*</span>
				</div>
				<div class="child">
					<textarea name="content" class="textinput" placeholder="설명을 입력해주세요."
						required="required"></textarea>
				</div>
			</div>
			<div class="btn-wrap">
				<button type="button" class="btn-add" onclick="dataSubmit();">글쓰기</button>
				<button type="button" class="btn-list" onclick="location.href='list'">취소하기</button>
			</div>
		</form>
		<div id="resultDiv">
			<p th:text="{log}"></p>
		</div>
	</div>
</div>
<script type="text/javascript">
	var fileArr;
	var fileInfoArr=$
	
	//썸네일 클릭시 삭제
	function fileRemove(index) {
		console.log("index: "+index);
		fileInfoArr.splice(index, 1);
		
		var imgId="#img_id_";
	}
	
</script>