$(function(){
	//지역설정
	$("#local").val($(".local-btn").text());
	
	var idx = $("#idx").val();
	
	//입력
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
	
	//수정
	$(".product-div .update-btn").click(function(){
	
		var idx = $(".product-div.write-form input[name='idx']").val();
		var title = $(".product-div.write-form input[name='title']").val();
		var category = $(".product-div.write-form select[name='category'] option:selected").text();
		var price = $(".product-div.write-form input[name='price']").val();
		var content = $(".product-div.write-form textarea[name='content']").val();
		var local = $(".product-div.write-form input[name='local']").val();
		var photo = $(".product-div input[name='photo']").val().split(",");
		var deletePhoto = deleteFile.split(",");
		
		var formData = new FormData();
			alert(idx+"/"+title+"/"+category+"/"+price+"/"+content+"/"+local+"/"+fileCnt+"/"+photo);
		if(title == '' || price == '' || content == '' || category == ''|| local == ''){
			alert("필수 입력을 입력해주세요.1");
			return;
		}
		
		formData.append("idx", idx);
		formData.append("title", title);
		formData.append("category", category);
		formData.append("price", price);
		formData.append("content", content);
		formData.append("local", local);
		formData.append("deleteFile", deleteFile);
		
		var updatePhoto = "";
		var updateOrigin = "";
		for(var i=0; i<deletePhoto.length; i++){
			for(var j=0; j<photo.length; j++){
				if(deletePhoto[i]==photo[j]){
					photo.splice(j,1);
					console.log(deletePhoto[i] +"삭제" + photo[j])
				}
			}
		}
		
		for(var i=0; i<photo.length; i++){
			updatePhoto += photo[i] + ",";
		}
		
		formData.append("updatePhoto", updatePhoto.substring(0,updatePhoto.length));
		
		for(var i=0; i<fileListArr.length; i++){
			console.log(fileListArr[i]);
			formData.append("uploadFile", fileListArr[i]);
		}
		
		$.ajax({
			type:"POST",
			enctype: "multipart/form-data",
			url:"update",
			data:formData,
			processData:false,
			contentType:false,
			success:function(){
				console.log("성공");
				location.href="../detail?idx="+idx;
			},
			error:function(e){
				console.log("에러", e);
			}
		});
	});
})