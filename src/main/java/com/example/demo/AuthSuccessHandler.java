package com.example.demo;


import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;

public class AuthSuccessHandler extends SimpleUrlAuthenticationSuccessHandler{
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		
		System.out.println("==> onAuthenticationSuccess");
		
		String returnUrl = request.getSession().getAttribute("returnUrl").toString();
		
		request.getSession().setAttribute("isLogin", "Y");
		
		setDefaultTargetUrl(returnUrl);
		
		super.onAuthenticationSuccess(request, response, authentication);
	}
	
}
