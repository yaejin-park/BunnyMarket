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

function loadFile(event){
	imgArr=new Array();
	for(var image of event.target.files){
		var reader = new FileReader();
		
		reader.onload = function(e){
			var img="<div class='preview-img'><img src='" +  e.target.result +  "' alt='' /><span class='close'>X</span></div>";
			imgArr.push(img);
			$("div.previewarea").append($(img));
		}; 
		reader.readAsDataURL(image);
	}
	setTimeout(function(){
		$(".preview-img").each(function(){
			if($(this).width() > $(this).find("img").height()){
		        $(this).find("img").width("auto");
		        $(this).find("img").height("100%");
		    }else{
		        $(this).find("img").width("100%");
		        $(this).find("img").height("auto");
		    }
		});
	},10);
	
	$(document).on("click", ".preview-img .close", function(e){
		//console.log($(this));
		$(this).parent().remove("");
		
		var file = $(this).parent().attr('file');
		for(var i=0;i<imgArr.length;i++){
			if(imgArr[i].name==file){
				imgArr.splice(i,1);
				break;
			}
		}
	});
}