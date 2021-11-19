$(function(){
	var swiper = new Swiper(".main-vis", {
		pagination: {
			el: ".main-vis .swiper-pagination",
		},
	});
	
	$(window).on("load", function(){
        $(".product-list li").each(function(){
			$(this).find(".img-div").height($(this).find(".img-div").width());
            if($(this).find("img").width() > $(this).find("img").height()){
                $(this).find("img").width("auto");
                $(this).find("img").height("100%");
            }else{
                $(this).find("img").width("100%");
                $(this).find("img").height("auto");
            }
        });
    });
});