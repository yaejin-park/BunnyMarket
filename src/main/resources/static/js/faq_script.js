$(function () {
	var getCategoryName = function(value) {
		var name = '';
		switch (value) {
		case 'sale':   
			name = '구매/판매';   
		break;
		case 'manner':    
			name = '거래매너';  
		break;
		case 'other':    
			name = '기타';  
		break;
		default:
			name = '전체';  
		break;
		}
		return name;
	}

	var renderList = function(currentPage) {
		var category=$("#faq-category").val();
		$.ajax({
			type:"get",
			dataType:"json",
			url:"/faq/list_by_category",
			data:{
				"category":category,
				"currentPage": currentPage  
			},
			success:function(data){
				var totalCount = data.totalCount;
				var startPage = data.startPage;
				var endPage = data.endPage;
				var list = data.list;
				var category = data.category;
				var currentPage = data.currentPage;
				var totalPage = data.totalPage;
				
				$("#faq-list-tbody").empty();
				$("#pagination").empty();
				
				
				if (list !== null && list.length > 0) {
					for (var i = 0; i < list.length; i++) {
						var a = list[i];
						var html = '';
						html += '<tr>';
						html += '	<td>'+getCategoryName(a.category)+'</td>';
						html += '	<td>'+a.question+'</td>';
						html += '	<td>';
						html += '		<button type="button" class="updatelist btn-update btn-sm" data-idx="'+a.idx+'">수정하기</button>';
						html += '		<button type="button" class="deletelist btn-delete btn-sm" data-idx="'+a.idx+'">삭제하기</button>';
						html += '		<button type="button" class="arrow1" data-idx="'+a.idx+'"></button>';
						html += '	</td>';
						html += '</tr>';
						html += '<tr class="answer" id="answer-'+a.idx+'">';
						html += '	<td  colspan="3">'+a.answer+'</td>';
						html += '</tr>';
						$("#faq-list-tbody").append(html);
					}
	
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

					$(".updatelist").click(function() {
						var idx = $(this).data('idx');
						location.href="updateform?idx=" + idx + "&currentPage=" + currentPage;
					});
					
					$(document).on("click",".deletelist",function() {
						var idx = $(this).data('idx');
						var a = confirm("삭제하겠습니까?");
						if(a==true) {
							$.ajax({
								type:"get",
								dataType:"text",
								url:"faqdelete",
								data:{"idx":idx},
								success:function(data) {
									list();
								}
							});
						}
					});
					
					var ph = '';
					ph += '<ul class="pagination">';
					if (startPage > 1) {
						ph += '<li><a href="#" class="pagination-link" data-page="'+startPage-1+'">이전</a></li>';
					}
					
					for (var pp = startPage; pp <= endPage; pp++) {
						if (currentPage == pp) {
							ph += '<li class="active"><a href="#" class="pagination-link" data-page="'+pp+'">'+pp+'</a></li>';
						} else {
							ph += '<li><a href="#" class="pagination-link" data-page="'+pp+'">'+pp+'</a></li>';
						}
					}
					
					if (endPage < totalPage) {
						ph += '<li><a href="#" class="pagination-link" data-page="'+endPage+1+'">다음</a></li>';
					}
					ph += '</ul>';
					
					$("#pagination").append(ph);
					
					$(".pagination-link").click(function() {
						var page = $(this).data('page');
						renderList(page);
					});
				}

			}
		});
	};



	
	$("#faq-category").on('change', function() {
		renderList(1);
	});
	
	renderList(1);
	
});