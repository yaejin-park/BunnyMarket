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
				alert(data);
			},
			error:function(){
				alert("에러 발생");
			}
		});
	});
	
	$("select[name = 'category']").change(function() {
		console.log($(this).val());  //  value값 얻기
		console.log($(this).find("option:selected").text()); //  text값 가져오기
	});
});