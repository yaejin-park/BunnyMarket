$(function(){
	$("header .menu-btn").click(function(){
		if(!$(this).hasClass("on")){
			$(this).addClass("on");
			$("body").css("overflow","hidden");
			$("header .menu").addClass("gnb-on");
			gsap.to(".gnb", 0.6, {opacity:1, right:0, ease:Power3.easeOut});
		}else{
			$(this).removeClass("on");
			$("header .menu").removeClass("gnb-on");	
			gsap.to(".gnb", 0.6, {opacity:0, right:"-50%", ease:Power3.easeOut});
			$("body").css("overflow","auto");
		}
	});

	$(".sub-body .search-btn").click(function(){
		if(!$(".sub-body .search-area").hasClass("on")){
			$(".sub-body .search-area").addClass("on");
		}else{
			$(".sub-body .search-area").removeClass("on");	
		}
	});	
	
	$("header .local-div .local-btn").click(function(){
		if(!$(this).hasClass("on")){
			$(this).addClass("on");
			$("header .local-option").stop(true,true).slideDown(300);
		}else{
			$(this).removeClass("on");
			$("header .local-option").stop(true,true).slideUp(300);	
		}
	});
});

imgArr=new Array();
function loadFile(event){
	for(var image of event.target.files){
		var reader = new FileReader();
		var img="";
		reader.onload = function(e){
			img="<div class='preview-img' idx='"+ (imgArr.length+1) +"'><img src='" +  e.target.result +  "' alt='' /><span class='close'>X</span></div>";
			
			imgArr.push(img);
			$("div.previewarea").append($(img));
		}; 
		
		reader.onloadend = function(e){
			if($(img).width() > $(img).find("img").height()){
		        $(img).find("img").width("auto");
		        $(img).find("img").height("100%");
		    }else{
		        $(img).find("img").width("100%");
		        $(img).find("img").height("auto");
		    }
		}
		reader.readAsDataURL(image);
	}
	
	$(document).on("click", ".preview-img .close", function(){
		var selectIdx = $(this).parents(".preview-img").attr("idx");
		console.log("삭제 전 갯수 :" + imgArr.length + "개");
		for(var i=0;i<imgArr.length; i++){
			var idx = $(imgArr[i]).attr("idx");
			if(idx == selectIdx){
				$(this).parents(".preview-img").remove(); 
				imgArr.splice(i,1);
			}
		}
		console.log("삭제 후 갯수 :" + imgArr.length);
	});
}

function popOpen(pop){
	$(pop).fadeIn(500);
	
	$(pop).find(".modal-close").click(function(){
		$(pop).fadeOut(500);
	});
}