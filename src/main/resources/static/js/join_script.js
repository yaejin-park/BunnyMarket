$(function(){
	$("#adminPop .admin-code-btn").click(function(){
		var inputCode = $("#adminPop .admin-code input[name='admin-code']").val();
		if(inputCode != "CarrotCarrot"){
			alert("관리자 코드가 일치하지 않습니다.");
			$("#adminPop .admin-code input[name='admin-code']").focus();
			$("#adminPop .admin-code input[name='admin-code']").val("");
		}else{
			$("#adminPop").fadeOut(500);
			location.href = "./addForm?type=admin";
		}
	});
	
	$(".join-div .acco-btn").click(function(){
		if(!$(this).hasClass("on")){
			$(this).addClass("on");
			$(this).find("input[type='checkbox']").prop("checked", true);
			$(this).parents(".acco-div").siblings().find(".acco-con").stop(true,true).slideUp(500);
			$(this).parents(".acco-div").find(".acco-con").stop(true,true).slideDown(500);
		}else{
			$(this).removeClass("on");
			$(this).find("input[type='checkbox']").prop("checked", false);
			$(this).parents(".acco-div").find(".acco-con").stop(true,true).slideUp(500);
		}
		
		var accoSize = $(".join-div .acco-btn").length;
		var checkSize = $(".join-div .acco-btn").find("input[type='checkbox']:checked").length;
		
		if(accoSize == checkSize){
			$(".join-div .all-check").find("input[type='checkbox']").prop("checked", true);
		}else{
			$(".join-div .all-check").find("input[type='checkbox']").prop("checked", false);
		}
	});
	
	$(".join-div .all-check").click(function(){
		if(!$(this).find("input[type='checkbox']").prop("checked")){
			$(".join-div .term-area").find("input[type='checkbox']").prop("checked", true);
		}else{
			$(".join-div .term-area").find("input[type='checkbox']").prop("checked", false);
		}
	});
	
	$(".email-div .domain").change(function(){
		var chooseMail = $(this).find("option:selected").val();
		$(this).parent(".email-div.form-div").find(".etc-input").val(chooseMail);
	});
	
	var key = "";
	$(".email-check").click(function(){
		var mail1 = $(this).parent(".email-div").find("input[name='email1']").val();
		var mail2 = $(this).parent(".email-div").find("input[name='email2']").val();
		var mail = "";
		
		if(mail1 == "" || mail2 == ""){
			alert("메일 주소가 입력되지 않았습니다.");
		}else{
			mail = mail1+"@"+mail2;
			$.ajax({
				type:'post',
				url:'./CheckMail',
				data:{
					mail:mail
				},
				dataType :'json',
				success:function(data){
					key = data.key;
				}
			});
			alert("인증번호가 전송되었습니다.") 
			isCertification=true; //추후 인증 여부를 알기위한 값
			$(".email-certify").show();
		}
	});
	
	$(".email-certify .email-certify-btn").click(function(){
		var inputTxt = $(".email-certify input[name='email-certify']").val();
		if(key == inputTxt){
			alert("성공")
			$(".email-certify .email-msg").txt("인증 성공");
		}else{
			alert("실패")
			$(".email-certify .email-msg").txt("인증 실패하였습니다. 다시 확인해주세요.");
		}
	});
	
});

function findAddr(){
	new daum.Postcode({
        oncomplete: function(data) {
        	// console.log(data);
			if(data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
				addrNum = data.zonecode; 
                addr = data.roadAddress;
				$(".join-div .write-form input[name='addr-num']").val(addrNum);
				$(".join-div .write-form input[name='addr1']").val(addr);
            }else{ // 사용자가 지번 주소를 선택했을 경우(J)
				addrNum = data.zonecode; 
                addr = data.jibunAddress;
				$(".join-div .write-form input[name='addr-num']").val(addrNum);
				$(".join-div .write-form input[name='addr1']").val(addr);
            }
        }
    }).open();
}