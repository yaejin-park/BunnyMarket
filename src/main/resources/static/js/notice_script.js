 


function selectAll(selectAll){
	const checkboxes
		= document.getElementsByName('del');
		
	checkboxes.forEach((checkbox) =>{
		checkbox.checked =selectAll.checked;
		})
	}
	
	
	
	$(function(){
		$("#delete").click(function(){
		  var a=confirm("정말로 삭제하시겠습니까?");
		  if(a==true){
		       deleteReport();
			}
			
		});
	});
	function deleteReport(){
	
		var cnt = $("input[name='del']:checked").length;
		var arr = new Array();
		$("input[name='del']:checked").each(function(){
			arr.push($(this).attr('id'));
		});
		if(cnt == 0){
		 alert("선택된 글이 없습니다");
		 }
		else{
	
			$.ajax = {
			type: "POST",
			url: "checkboxdel",
			data: "RPRT_ODR=" + arr + "&CNT=" + cnt,
			dataType: "json",
			success: function(jdata){
				if(jdata != 1){
				alert("삭제오류");
				}
				else{
					alert("삭제 성공");
					}
				},
				error: function(){alert("서버통신 오류");}
			
			};
		}
	}
			
		
    
 
			