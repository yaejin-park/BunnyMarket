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
})