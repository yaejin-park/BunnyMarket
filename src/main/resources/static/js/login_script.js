$(function(){
	
});

function onSignIn(googleUser){
	var profile = googleUser.getBasicProfile();
	/* console.log("id :" + profile.getId());
	console.log("Name :" + profile.getName());
	console.log("Image URL :" + profile.getImageUrl());
	console.log("Email :" + profile.getEmail()); */
	$(".sns-login .g-signin2").hide();
	$(".sns-login .google button").show();
}

function signOut(){
	var auth2 = gapi.auth2.getAuthInstance();
	auth2.signOut().then(function(){
		/* console.log("User signed out"); */
		$(".sns-login .g-signin2").show();
		$(".sns-login .google button").hide();
	})
}