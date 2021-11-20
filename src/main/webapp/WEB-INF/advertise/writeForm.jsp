<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="/css/ad_style.css">
<div class="inner">
	<form method="post" enctype="multipart/form-data">
		<div class="group">
			<div class="child">
				이미지 <span class="must">*</span>
			</div>
			<div class="child imgupload">
				<label for="selectImg"> 
					<img class="uploadImg" src="../image/write-upload-icon.JPG">
				</label>
				<input type="file" id="selectImg" name="selectImg" class="form-control imginput" multiple="multiple" accept="image/*"
					onchange="loadFile(event)">			
			</div>
				<div class="previewarea"></div>
		</div>
	</form>
	
	<br>
	<div class="group">
		<div class="child">
			제목 <span class="must">*</span>
		</div>
		<div class="child">
			<input type="text" class="subinput" placeholder="글제목">
		</div>
	</div>
	<br>
	<div class="group">
		<div class="child">
			설명 <span class="must">*</span>
		</div>
		<div class="child">
			<textarea rows="30" cols="100" placeholder="설명을 입력해주세요."></textarea>
		</div>
	</div>
</div>

<!-- Image Preview Event -->
<script type="text/javascript">
	function loadFile(event){
		for(var image of event.target.files){
			var reader = new FileReader();
			
			reader.onload = function(event){
				var img = document.createElement("img");
				img.setAttribute("src", event.target.result);
				img.setAttribute("class", "preview");
				document.querySelector("div.previewarea").appendChild(img);
			};
			
			console.log(image);
			reader.readAsDataURL(image);
		}
	}
</script>