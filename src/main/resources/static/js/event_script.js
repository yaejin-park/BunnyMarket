$(function(){
	$(window).on("load", function(){
        $(".event-list li").each(function(){
			$(this).find(".img-div").height($(this).find(".img-div").width() / 1.8);
            if($(this).find("img").width() > $(this).find("img").height()){
                $(this).find("img").width("auto");
                $(this).find("img").height("100%");
            }else{
                $(this).find("img").width("100%");
                $(this).find("img").height("auto");
            }
        });
    });

	var fileListArr = new Array();
	var keyNum = 0;
	var fileCnt = 0;
	
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
	
	$(document).on("click", ".preview-img .close", function(){
		var delIdx = $(this).parent(".preview-img").attr("idx");
		
		var fileArr = fileListArr;
		fileArr.splice(delIdx,1);
		fileCnt--;
		
		$(this).parent(".preview-img").remove();
	});
	
	$(".event-div .event-add-btn").click(function(){
		var title = $(".event-div.write-form input[name='title']").val();
		var content = $(".event-div.write-form textarea[name='content']").val();
		var category = $(".event-div.write-form select[name='category'] option:selected").text();
		var eventStart = $(".event-div.write-form input[name='event_start']").val() + " 00:00:00";
		var eventEnd = $(".event-div.write-form input[name='event_end']").val() + " 00:00:00";
		var formData = new FormData();
		if(title == '' || content == '' || fileCnt == 0 || category == '' || eventStart == '' || eventEnd == ''){
			alert("필수 입력을 입력해주세요.");
			return;
		}
		formData.append("title", title);
		formData.append("content", content);
		formData.append("category", category);
		formData.append("eventStart", eventStart);
		formData.append("eventEnd", eventEnd);
		
		for(var i=0; i<fileListArr.length; i++){
			console.log(fileListArr[i]);
			formData.append("uploadFile", fileListArr[i]);
		}
		
		$.ajax({
			type:"POST",
			enctype: "multipart/form-data",
			url:"/event/auth/insert",
			data:formData,
			processData:false,
			contentType:false,
			success:function(){
				console.log("성공");
				location.href="/event/list";
			},
			error:function(e){
				console.log("에러" + e);
			}
		});
	});
})