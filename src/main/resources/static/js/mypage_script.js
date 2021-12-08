$(function(){
	var sideMenuSwiper = new Swiper(".mydetail-form .side-menu-div", {
    	slidesPerView: 'auto',
        centeredSlides: true,
        observer:true,
        observeparents:true,
        updateOnWindowResize:true,
        noSwiping:true,
        noSwipingClass:'stop-swiping',
        on: {
            init: function(){
                if($(window).innerWidth()>=768){
                    $(".mydetail-form .side-menu-div .swiper-wrapper").css("transform", "translate3d(0, 0px, 0px)");
                    $(".mydetail-form .side-menu-div .swiper-slide").addClass("stop-swiping"); 
                }else{
                    $(".mydetail-form .side-menu-div .swiper-slide").eq(this.activeIndex).addClass("active");
                    $(".mydetail-form .side-menu-div .swiper-slide").removeClass("stop-swiping"); 
                }
            },
			resize : function(){
                if($(window).innerWidth()>=768){
                    $(".mydetail-form .side-menu-div .swiper-wrapper").css("transform", "translate3d(0, 0px, 0px)");
                    $(".mydetail-form .side-menu-div .swiper-slide").addClass("stop-swiping");  
                }else{
                    $(".mydetail-form .side-menu-div .swiper-slide").removeClass("stop-swiping"); 
                }
            }
        },       
	});
	
	$(".unregister-form #go-unregi").click(function(){
		if($(".unregister-form .unregi-reason option").index($(".unregister-form .unregi-reason option:selected")) == 0){
			alert("탈퇴하려는 이유를 선택해주세요.");
			return;
		}
		if(confirm("정말 탈퇴하시겠습니까?\n 탈퇴 시, 바니마켓의 정보는 모두 삭제됩니다.")){
			location.href="deletemember";
		}
	});
});