package com.example.demo;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;

public class AuthFailureHandler extends SimpleUrlAuthenticationFailureHandler{
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		
		String msg = "Invalid Email or Password";
		
		if(exception instanceof UsernameNotFoundException) {
			msg = "UsernameNotFoundException account";
		}else if(exception instanceof DisabledException) {
			msg = "DisabledException account";
		}else if(exception instanceof BadCredentialsException) {
			msg = "BadCredentialsException account";
		}else if(exception instanceof LockedException) {
			msg = "LockedException account";
		}
		

		//setDefaultFailureUrl("/login?error=true&exception=" + msg);
		setDefaultFailureUrl("/login/main?error=true");
		
		super.onAuthenticationFailure(request, response, exception);
	}
}
