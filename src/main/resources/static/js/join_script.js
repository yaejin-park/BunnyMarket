var idCheck = false;
var pwCheck = false;
var nickCheck = false;
var emailCheck = false;
var termCheck = false;

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
			$(".join-div .all-check").addClass("on");
			$(".join-div .all-check").find("input[type='checkbox']").prop("checked", true);
			termCheck = true;
		}else{
			$(".join-div .all-check").removeClass("on");
			$(".join-div .all-check").find("input[type='checkbox']").prop("checked", false);
		}
	});
	
	$(".join-div .all-check").click(function(){
		if(!$(this).hasClass("on")){
			$(this).addClass("on");
			$(".join-div .term-area").find("input[type='checkbox']").prop("checked", true);
			termCheck = true;
		}else{
			$(this).removeClass("on");
			$(".join-div .term-area").find("input[type='checkbox']").prop("checked", false);
		}
	});
	
	$(".email-div .domain").change(function(){
		var chooseMail = $(this).find("option:selected").val();
		$(this).parent(".email-div.form-div").find(".etc-input").val(chooseMail);
	});
	
	$(".email-div input[name='email2']").keyup(function(){
		var email2 = $(this).val();
		$(".email-div .domain option").attr("selected", false);
		$(".email-div .domain option").each(function(){
			if(email2 != $(this).val()){
				$(".email-div .domain option").eq(1).attr("selected", true);
			}else{
				$(this).attr("selected", true);
			}
		});
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
				url:'/join/CheckMail',
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
			$(".email-certify .email-msg").text("인증 성공").addClass("success");
			emailCheck = true;
		}else{
			$(".email-certify .email-msg").text("인증 실패하였습니다. 다시 확인해주세요.").removeClass("success");
		}
	});
	
	$(".join-div .write-form input[name='pw']").change(function() {
		var pw = $(this).val();
		var num = pw.search(/[0-9]/g);
		var eng = pw.search(/[a-z]/g);
		var spe = pw.search(/[`~!@@#$%^&*|\\\'\";:\/?]/gi);

		if(pw.length < 8 || pw.length > 20){
			$(".join-div .write-form .pw-msg").text("8자리~20자리 이내로 입력해주세요.").removeClass("success");
		}else if(pw.search(/\s/) != -1){
			$(".join-div .write-form .pw-msg").text("비밀번호는 공백없이 입력해주세요.").removeClass("success");
		}else if(num < 0 || eng < 0 || spe < 0 ){
			$(".join-div .write-form .pw-msg").text("영문+숫자+특수문자를 포함하여 입력해주세요.").removeClass("success");
		}else {
			$(".join-div .write-form .pw-msg").text("안전한 비밀번호입니다.").addClass("success");
			pwCheck = true;
		}
	});
	
	$(".join-div .write-form input[name='pw'], .join-div .write-form input[name='pw2']").change(function() {
		var pw1 = $(".join-div .write-form input[name='pw']").val();
		var pw2 = $(".join-div .write-form input[name='pw2']").val();
		if(pw2.length > 0){
			if(pw1 != pw2){
				$(".join-div .write-form .pw-check-msg").text("비밀번호 불일치합니다. 다시 확인해주세요.").removeClass("success");
				pw2.val("").focus();
			}else{
				$(".join-div .write-form .pw-check-msg").text("비밀번호 일치합니다.").addClass("success");
			}
		}
	});
	
	var id = "";
	$(".join-div .write-form .id-check, #idCheckPop .id-check").click(function(){
		id = $(this).prev("input[name='id']").val();
		
		if(id == ""){
			alert("아이디 입력해주세요.");
			return;
		}else{
			popOpen('#idCheckPop');
			
			$.ajax({
				method:"get",
				url:"idCheck",
				data:{"id":id},
				dataType:"json",
				success:function(data){
					console.log(data.id);
					if(data.id == 0) {
						$("#idCheckPop").find(".result-msg").html("입력하신 <span>" + id + "</span>는 사용하실 수 있습니다.");
						$("#idCheckPop").find(".use-btn").show();
					}else{
						$("#idCheckPop").find(".result-msg").html("입력하신 <span>" + id +"</span>는 존재하는 아이디가 있습니다.");
						$("#idCheckPop").find(".use-btn").hide();
					}
				}
			})
		}
	});
	
	$("#idCheckPop").find(".use-btn").click(function(){
		$("#idCheckPop .modal-close").click();
		$(".join-div .write-form input[name='id']").val(id);
		idCheck = true;
	});
	
	var nick = "";
	$(".join-div .write-form .nick-check, #nickCheckPop .nick-check").click(function(){
		nick = $(this).prev("input[name='nickname']").val();
		
		if(nick == ""){
			alert("닉네임을 입력해주세요.");
			return;
		}else{
			popOpen('#nickCheckPop');
			
			$.ajax({
				method:"get",
				url:"/join/nickCheck",
				data:{"nick":nick},
				dataType:"json",
				success:function(data){
					console.log(data.nick);
					if(data.nick == 0) {
						$("#nickCheckPop").find(".result-msg").html("입력하신 <span>" + nick + "</span>는 사용하실 수 있습니다.");
						$("#nickCheckPop").find(".use-btn").show();
					}else{
						$("#nickCheckPop").find(".result-msg").html("입력하신 <span>" + nick +"</span>는 존재하는 닉네임이 있습니다.");
						$("#nickCheckPop").find(".use-btn").hide();
					}
				}
			})
		}
	});
	
	$("#nickCheckPop").find(".use-btn").click(function(){
		$("#nickCheckPop .modal-close").click();
		$(".join-div .write-form input[name='nickname']").val(nick);
		nickCheck = true;
	});
	
	
	$("#pwCheckPop .pw-check-btn").click(function(){
		var pw = $("#pwCheckPop").find("input[name='password']").val();
		
		console.log(pw)
		$.ajax({
			type:"post",
			url:"/join/pwCheck",
			data:{"pw":pw},
			dataType:"json",
			success:function(data){
				if(data.result == 0){
					alert("비밀번호가 틀립니다.");
					$("#pwCheckPop").find("input[name='password']").val("").focus();
					return;
				}else{
					popClose("#pwCheckPop");
					popOpen("#pwChangePop");
				}
			}
		});
	});
	
	$("#pwChangePop input[name='pw']").change(function() {
		var pw = $(this).val();
		var num = pw.search(/[0-9]/g);
		var eng = pw.search(/[a-z]/g);
		var spe = pw.search(/[`~!@@#$%^&*|\\\'\";:\/?]/gi);

		if(pw.length < 8 || pw.length > 20){
			alert("8자리~20자리 이내로 입력해주세요.");
		}else if(pw.search(/\s/) != -1){
			alert("비밀번호는 공백없이 입력해주세요.");
		}else if(num < 0 || eng < 0 || spe < 0 ){
			alert("영문+숫자+특수문자를 포함하여 입력해주세요.");
		}else {
			alert("안전한 비밀번호입니다.");
		}
	});
	
	$("#pwChangePop input[name='pw'], #pwChangePop input[name='pw2']").change(function() {
		var pw1 = $("#pwChangePop input[name='pw']").val();
		var pw2 = $("#pwChangePop input[name='pw2']").val();
		if(pw2.length > 0){
			if(pw1 != pw2){
				alert.text("비밀번호 불일치합니다. 다시 확인해주세요.");
				pw2.val("").focus();
			}else{
				alert("비밀번호 일치합니다.");
				pwCheck = true;
			}
		}
	});
	
	$("#pwChangePop .use-btn").click(function(){
		var pw = $("#pwChangePop input[name='pw']").val();
		
		$.ajax({
			type:"post",
			url:"/mypage/auth/changepw",
			data:{"pw":pw},
			success:function(){
				alert("비밀번호 변경이 완료되었습니다.");
				popClose("#pwChangePop");
			}
		})
	});
	
});

function findAddr(){
	new daum.Postcode({
        oncomplete: function(data) {
        	// console.log(data);
			$(".join-div .write-form input[name='addrLocal']").val(data.bname);
			
			if(data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
				addrNum = data.zonecode; 
                addr = data.roadAddress;
				$(".join-div .write-form input[name='zonecode']").val(addrNum);
				$(".join-div .write-form input[name='addr1']").val(addr);
            }else{ // 사용자가 지번 주소를 선택했을 경우(J)
				addrNum = data.zonecode; 
                addr = data.jibunAddress;
				$(".join-div .write-form input[name='zonecode']").val(addrNum);
				$(".join-div .write-form input[name='addr1']").val(addr);
            }
        }
    }).open();
}

function joinFormCheck(f){
	if(!idCheck && !pwCheck && !nickCheck && !emailCheck){
		alert("중복확인 및 이메일 인증해주세요.");
		return false;
	}else{
		return true;
	}
	
	if(!termCheck){
		alert("약관동의해주세요.");
		return false;
	}else{
		return true;
	}
}

function updateFormCheck(f){
	if(!termCheck){
		alert("약관동의해주세요.");
		return false;
	}else{
		return true;
	}
}