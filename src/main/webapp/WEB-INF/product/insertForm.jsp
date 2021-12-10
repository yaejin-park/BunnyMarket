<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" type="text/css" href="/css/product_style.css">
<div class="write-form product-div">
	<div class="inner">
		<form action="insert" method="post" enctype="multipart/form-data">
			<input type="hidden" name="sellstatus" value="판매중">
			<input type="hidden" name="local" id="local" value="">
			
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
						required="required">
				</div>
			</div>
			<div class="group">
				<div class="child tit">
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
				<div class="child tit">
					금액<span class="must">*</span>
				</div>
				<div class="child">
					<input type="number" name="price" class="subinput price"
						placeholder="금액(숫자만 입력)" required="required">
					<div class="won">원</div>
				</div>
			</div>

			<div class="group">
				<div class="child tit">
					설명 <span class="must">*</span>
				</div>
				<div class="child">
					<textarea class="textinput" name="content"
						placeholder="상품설명을 입력해주세요" required="required"></textarea>
				</div>
			</div>

			<div class="group">
				<div class="btn-wrap">
					<button type="button" class="btn-add">등록하기</button>
					<button type="button" class="btn-default">취소</button>
				</div>
			</div>
		</form>
	</div>
</div>

<script>
//지역설정
$("#local").val($(".local-btn").text());


var fileListArr = new Array();
var keyNum = 0;
var fileCnt = 0;

//파일 업로드
$("#chooseFile").on("change", function(e){
	var files = $(this)[0].files;
	var fileArr = new Array();
	fileArr = fileListArr;
	
	for(var i=0; i<files.length; i++){
		fileCnt++;
		if(!files[i].type.match("image.*")){
			alert("확장자는 이미지 확장자만 가능합니다.");
			return false;
		}
	}
	
	if($(this).parents(".product-div").hasClass("update")){
		fileCnt = fileCnt + $(".preview-img").length;
	}
	
	if(fileCnt > 4){
		alert("파일은 최대 4개까지만 가능합니다.");
		fileCnt = fileCnt - files.length;
		return false;
	}

	for(var i=0; i<files.length; i++){
		var reader = new FileReader();
		reader.onload = function(e){
			var tag = "<div class='preview-img' idx='"+ keyNum +"'><img src='" + e.target.result +"' alt='''><span class='close'></span></div>";
			$(".preview-area").append(tag);
			keyNum++;
		}
		reader.readAsDataURL(files[i]);
		
		reader.onloadend = function(e){
			$(".preview-img").each(function(){
				$(this).height($(this).width());
				if($(this).width() > $(this).find("img").height()){
					$(this).find("img").width("auto");
					$(this).find("img").height("100%");
				}else{
					$(this).find("img").width("100%");
					$(this).find("img").height("auto");
				}
			});
		}
		fileArr.push(files[i]);
	}
			
	fileListArr = new Array();
	fileListArr = fileArr;
	console.log(fileListArr.length);
});

var deleteFile = "";
$(document).on("click", ".product-div .preview-img .close", function(e){
	var delIdx = $(this).parent(".preview-img").attr("idx");
	
	if($(this).parents(".product-div").hasClass("update")){
		var fileTxt = $(e.target).prev("img").attr("src");
		deleteFile += $(e.target).prev("img").attr("src").substring(7,fileTxt.length)  + ",";
	}
	
	var fileArr = fileListArr;
	fileArr.splice(delIdx,1);
	fileCnt--;
	
	$(this).parent(".preview-img").remove();
});

$(".product-div .btn-add").click(function(){
	var title = $(".product-div.write-form input[name='title']").val();
	var category = $(".product-div.write-form select[name='category'] option:selected").text();
	var price = $(".product-div.write-form input[name='price']").val();
	var content = $(".product-div.write-form textarea[name='content']").val();
	var sellstatus = $(".product-div.write-form input[name='sellstatus']").val();
	var local = $(".product-div.write-form input[name='local']").val();
	
	var formData = new FormData();
	if(title == '' || price == '' || content == '' || fileCnt == 0 || category == ''){
		alert("필수 입력을 입력해주세요.");
		return;
	}
	
	formData.append("title", title);
	formData.append("category", category);
	formData.append("price", price);
	formData.append("content", content);
	formData.append("sellstatus", sellstatus);
	formData.append("local", local);
	
	for(var i=0; i<fileListArr.length; i++){
		console.log(fileListArr[i]);
		formData.append("uploadFile", fileListArr[i]);
	}
	
	$.ajax({
		type:"POST",
		enctype: "multipart/form-data",
		url:"insert",
		data:formData,
		processData:false,
		contentType:false,
		success:function(data){
			console.log("성공");
			location.href="../detail?idx="+data.idx;
		},
		error:function(e){
			console.log("에러" + e);
		}
	});
});

</script>
