$(function () {
	$(".arrow1").click(function() {
		var idx = $(this).data('idx');
		$("#answer-"+ idx).toggle();
	});
	
	$(".arrow1").on("click",function(e) {
		if($(this).hasClass("on")){
			$(this).removeClass("on");
		}else{
			$(this).addClass("on");
		}
	});
	
	$("#faq-category").on('change', function() {
		var category=$(this).val();
		$.ajax({
			type:"get",
			dataType:"json",
			url:"/faq/list_by_category",
			data:{
				"category":category,
				"currentPage": 1,
			},
			success:function(data){
				$("td").text(data.length);
				var s="";
				$.each(data,function(i,dto) {
					s+=dto.idx;
					s+=dto.category;
					s+=dto.question;
					s+=dto.answer;
				});
			}
		});
	});
	
});