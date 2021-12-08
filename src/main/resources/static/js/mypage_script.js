/* sell_list js*/
$(function(){
	$("input:button[name='button']").on('click',function(){
	  var kind = $(this).val();//버튼이 클릭시, 개별 버튼의 값 kind 변수에 담기
        $.ajax({
            url : "/mypage/auth/selllist",
            type : "post",
            cache : false,
			headers : {"cache-control":"no-cache","pragma":"no-cache"},
            data : {
                 //id : $(this).val()->컨트롤러에서 principal로 아이디값 받기,
                "kind":kind // 버튼의 value값에따라 작동
            },
            success : function(data){
                $('body').html(data); // 성공 시, body부분에 data라는 html 문장들을 다 적용
            },
            error : function(data){
                alert('error');
            }
        });
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
