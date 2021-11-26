<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="/css/ad_style.css">
<div class="write-form">
	<div class="inner">
			<div class="group">
				<div class="child tit">
					이미지 <span class="must">*</span>
				</div>
				<div class="child imgupload">
					<div class="form-group uploadImg">
						<label for="chooseFile"> 
							<img src="../image/write-upload-icon.JPG">
						</label>
						<input type="file" id="chooseFile" name="photoupload" class="imginput" multiple="multiple" accept="image/*" onchange="loadFile(event)">
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
				<button type="submit" class="btn-add">글쓰기</button>
				<button type="button" class="btn-list" onclick="location.href='list'">취소하기</button>
			</div>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		var formObj=$("form[role='form']");
		$("button[type='submit']").on("click",function(e){
			e.preventDefault();
			console.log("submit clicked");
		});
		
		var regex=new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		//var maxSize=5242880; //5MB
		
		function checkExtension(fileName,fileSize) {
			if(fileSize>=maxSize){
				alert("파일 사이즈 초과");
				return false;
			}
			
			if(regex.test(fileName)){
				alert("해당 종류의 파일은 업로드할 수 없습니다.");
				return false;
			}
			return true;
		}
		
		$("input[type='file']").change(function(e) {
			var formData=new FormData();
			var inputFile=$("input[name='photoupload']");
			var files=inputFile[0].files;
			
			for(var i=0;i<files.length;i++){
				if(!checkExtension(files[i]).name,files[i].size)){
					return false;
				}
				formData.append("photoupload",files[i]);
			}
			
			$.ajax
		});i
	});
</script>