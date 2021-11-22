<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<link rel="stylesheet" type="text/css" href="/css/communitywf_style.css">
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>

<div class="inner">
	<form action="insert" method="post" enctype="multipart/form-data">
		<div class="group">
			<div class="child txt">
				이미지<span class="star">*</span>
			</div>
				<div class="child img-div">
					<label for="chooseFile">
						<img src="/image/imageadd.jpg">
					</label>
				<input type="file" class="chooseFile" id="chooseFile" accept="image/*" onchange="viewFile(event)" 
				multiple="multiple" hidden="hidden">
				<div class="viewfile"></div>
				</div>
			</div>
		<br>
		<div class="group">
			<div class="child txt">
				제목<span class="star">*</span>
			</div>
			<div class="child">
				<input type="text" class="subinput" required="required" placeholder="제목 입력" maxlength="20">
			</div>
		</div>
		<br>
		<div class="group">
			<div class="child txt">
				내용<span class="star">*</span>
			</div>
			<div class="child">
				<textarea class="continput" required="required" placeholder="내용을 입력하세요" ></textarea>
			</div>
		</div>
		<div class="write-btn">
			<button type="submit" class="btn-add">글쓰기</button>
			<button type="button" class="btn-list"
			onclick="location.href='list'">목록</button>
		</div>
	</form>
</div>



<script type="text/javascript">

	function viewFile(event){
		for(var image of event.target.files){
				var reader   = new FileReader();
			
				var files = event.target.files;
				var filesArr = Array.prototype.slice.call(files);

			filesArr.forEach(function(f){
				if(!f.type.match("image.*")){
					alert("이미지파일만 업로드 가능합니다");
					return;
				}
				
			reader.onload = function(event){ 
				var img = document.createElement("img");
				img.setAttribute("src",event.target.result);
				img.setAttribute("class","showfile");
				document.querySelector("div.viewfile").appendChild(img);
				};
			});
		reader.readAsDataURL(image);
		}
	}

</script>










