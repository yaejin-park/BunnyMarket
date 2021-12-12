$(function(){
	var swiper = new Swiper(".main-vis", {
		pagination: {
			el: ".main-vis .swiper-pagination",
		},
	});

	$(window).resize(function(){
		$(".product-list li").each(function(){
			$(this).find(".img-div").height($(this).find(".img-div").width());
			
			if($(this).find(".img-div").width() * $(this).height() < $(this).find(".img-div").height() * $(this).width()){
				$(this).find("img").width($(this).width());
				$(this).find("img").height("auto");
			}else{
				$(this).find("img").width("auto");
				$(this).find("img").height($(this).height());
			}
		});
	}).resize();

	$(window).scroll(function(){
		// console.log($(window).scrollTop());
		var scrollTop = $(window).scrollTop() + $(window).height();
		if(scrollTop >= $(".product-list").offset().top){
			// console.log("실행")
			$(".product-list li").each(function(i){
				gsap.to($(this), 1.2, {delay:0.1*i, top:0, opacity:1, ease:Power3.easeOut});
			});
		}
	});
});