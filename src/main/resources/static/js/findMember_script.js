$(function(){
	$(".find-form-div .find-id-btn").click(function(){
		var userName = $(".find-form-div input[name='user_name']").val();
		var userHp = $(".find-form-div input[name='user_hp']").val();
		
		popOpen("#findIdPop");
		
		$.ajax({
			type:"post",
			url:"checkid",
			dataType:"json",
			data:{
				"name":userName,
				"hp":userHp
			},
			success:function(data){
				if(data.result == "yes"){
					$("#findIdPop .result").html("<span>" + data.id + "</span>");
				}else{
					$("#findIdPop .result").text("등록된 회원정보가 없습니다.");
				}
			}
		});
	});
	
	var emailKey = "";
	$(".find-form-div .email-send-btn").click(function(){
		var mail = $(".find-form-div input[name='user_email1']").val() + "@" + $(".find-form-div input[name='user_email2']").val();
		console.log(mail);
		$.ajax({
			type:"post",
			data:{"mail":mail},
			url:"./checkmail",
			success:function(data){
				emailKey = data.key;
				alert("이메일 전송되었습니다.\n 이메일 확인해주세요.");
			},
			error:function(){
				console.log("에러");
			}
		});
	});
	
	$(".find-form-div select[name='user_email_choose']").change(function(){
		var choose = $(this).find("option:selected").val();
		
		$(".find-form-div input[name='user_email2']").val(choose);
	});
	
	$(".find-form-div input[name='user_email2']").keyup(function(){
		var email2 = $(this).val();
		$(".find-form-div select[name='user_email_choose'] option").attr("selected", false);
		$(".find-form-div select[name='user_email_choose'] option").each(function(){
			if(email2 != $(this).val()){
				$(".find-form-div select[name='user_email_choose'] option").eq(1).attr("selected", true);
			}else{
				$(this).attr("selected", true);
			}
		});
	});
	
	var isEmail = false;
	$(".find-form-div .email-check-btn").click(function(){
		var emailCertify = $(".find-form-div input[name='email_certify']").val();
		if(emailCertify == emailKey){
			$(".email-certify .msg").text("인증 성공").addClass("success");
			isEmail = true;
		}else{
			$(".email-certify .msg").text("인증 실패").removeClass("success");
		}
	});
	
	$(".find-form-div .find-pw-btn").click(function(){
		var id = $(".find-form-div input[name='user_id']").val();
		var name = $(".find-form-div input[name='user_name']").val();
		var email = $(".find-form-div input[name='user_email1']").val() + "@" + $(".find-form-div input[name='user_email2']").val();
		if(id == "" || name == "" || $(".find-form-div input[name='user_email1']").val() == "" || $(".find-form-div input[name='user_email2']").val() == ""){
			alert("아이디,이름,이메일 미입력되어있습니다.\n입력해주세요.");
			return;
		}
		
		if(!isEmail){
			alert("이메일 인증해주세요.");
			return;	
		}
		
		
		$.ajax({
			type:"post",
			url:"./findpw",
			data:{
				"id":id,
				"name":name,
				"email":email
			},
			dataType:"json",
			success:function(data){
				console.log("data.result =>" + data.result);
				popOpen("#findPwPop");
				if(data.result == "yes"){
					$("#findPwPop").find(".result").html("<span>"+ data.key +"</span>");
				}else{
					$("#findPwPop").find(".result").text("등록된 회원 정보가 없습니다.");
				}
			}
		})
	});
});