

	//list에 대표이미지 사이즈 맞추기
	$(function(){
		$(window).on("load", function(){
			$(".cummu-list .image").each(function(){
				$(this).height($(this).width());
				if($(this).width() > $(this).find("img").height()){
					$(this).find("img").width("auto");
					$(this).find("img").height("100%");
				}else{
					$(this).find("img").width("100%");
					$(this).find("img").height("auto");
				}
			});
		
		});
	})














