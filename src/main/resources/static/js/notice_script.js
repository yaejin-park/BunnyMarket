


function selectAll(selectAll) {
	const checkboxes
		= document.getElementsByName('del');

	checkboxes.forEach((checkbox) => {
		checkbox.checked = selectAll.checked;
	})
}



$(function() {
	$("#delete").click(function() {
		var cnt = $("input[name='del']:checked").length;
		var a = confirm("총"+cnt+"개의 게시글을 삭제하시겠습니까?");
		
		if (a == true) {
			deleteReport();
		}

	});
});


	

function deleteReport() {

	var cnt = $("input[name='del']:checked").length;
	var arr = new Array();
	$("input[name='del']:checked").each(function() {
		arr.push($(this).attr('id'));
	});
	
	if (cnt == 0) {
		alert("선택된 글이 없습니다");
	}
	else {
		$.each(arr, function(idx, arrdata) {
			
			$.ajax({
				type: "POST",
				url: "checkboxdel",
				data: { "arrdata": arrdata },
				dataType: "text",
				success: function() {
					location.reload();

				}
			});
		});
	}
}


$(function() {
	$("#delete2").click(function() {
		var a = confirm("게시글을 삭제하시겠습니까?");
		var idx = $('input').attr('value');
		console.log(idx);
		
		
		if (a == true) {
			 delete1();
			
		}

	});
});



function delete1() {

	        var idx=$('#idx').val();
	        var currentPage=$('#currentPage').val();
	        console.log("1:"+idx,currentPage);
	        
			
			$.ajax({
				type: "get",
				url: "delete",
				data: { "idx": idx,"currentPage": currentPage  },
				dataType: "text",
				success: function() {
					location.href="/notice/list";
				}

			});
				
	

}

  $(document).on("change", ".file-input", function(){
   
    $filename = $(this).val();

    if($filename == "")
      $filename = "파일을 선택해주세요.";

    $(".filename").text($filename);

  })









		
    
 
			