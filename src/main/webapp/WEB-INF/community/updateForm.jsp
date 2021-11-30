<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<link rel="stylesheet" type="text/css" href="">
<div class="write-form">
	<div class="inner">
		<form action="update" method="post" enctype="multipart/form-data">
		<input type="hidden" name="idx" value="${dto.idx}">
		<input type="hidden" name="currentPage" value="${dto.currentPage}"> 
			<div class="group">
				<div class="child tit">
					이미지<span class="must">*</span>
				</div>
				<div class="child imgupload">
					<div class="form-group uploadImg">
						<label for="chooseFile"> 
						<img src="/image/imageadd.jpg">
						</label> 
						<input type="file" class="imginput" name="upload" id="chooseFile" multiple="multiple"/>
					</div>
					<div class="previewarea">
				 	<img id="previewimg"/> 
					</div>
				</div>
			</div>
			<div class="group">
				<div class="child tit">
					제목<span class="must">*</span>
				</div>
				<div class="child">
					<input type="text" name="title" class="subinput"
						required="required" value="${dto.title}" maxlength="30">
				</div>
			</div>
			<div class="group">
				<div class="child tit">
					내용<span class="must">*</span>
				</div>
				<div class="child">
					<textarea class="textinput" name="content" required="required">${dto.content}</textarea>
				</div>
			</div>
			<div class="btn-wrap">
				<button type="submit" class="btn-add">수정</button>
				<button type="button" class="btn-list"
					onclick="location.href='list'">목록</button>
			</div>
		</form>
	</div>
</div>



<script type="text/javascript">


var sel_file = [];

$(document).ready(function() {
	$("#chooseFile").on("change", handleImgFileSelect);
});

function fileUploadAction(){
	$("#chooseFile").trigger('click');
}

function handleImgFileSelect(e){
	//이미지 정보 초기화
	sel_files = [];
	
	var files = e.target.files;
	var filesArr = Array.prototype.slice.call(files);
	
	var index = 0;
	filesArr.forEach(function(f){
		if(!f.type.match("image.*")){
			alert("확장자는 이미지만 가능합니다");
			return;
		}
		
		sel_files.push(f);
		
		var reader = new FileReader();
		reader.onload = function(e){
			var html = "<div class='preview-img' href=\"javascript:void(0);\" onclick=\"deleteImageAction("+index+")\" id=\"img_id_"+index+"\"><img src='" +  e.target.result +  "' alt='' /><span class='close'>X</span></div>";
			$(".previewarea").append(html);
			index++;
		}
		reader.readAsDataURL(f);
	});
}


function deleteImageAction(index){
	sel_files.splice(index, 1);
	
	var img_id = "#img_id_"+index;
	$(img_id).remove();
}


</script>