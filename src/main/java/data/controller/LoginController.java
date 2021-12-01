package data.controller;


import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import data.service.MemberService;

@Controller()
@RequestMapping("/login")
public class LoginController {
	@Autowired
	BCryptPasswordEncoder encoder;
	
	@Autowired
	MemberService memberService;
	
	@GetMapping("/main")
	public String loginHome(
			Model model,
			HttpServletRequest request,
			@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "exception", required = false) String exception
			) 
	{
		model.addAttribute("error", error);
		model.addAttribute("exception", exception);
		
		request.getSession().setAttribute("returnUrl", request.getHeader("referer"));
		System.out.println("returnUrl =>" + request.getHeader("referer"));

		return "/login/main";
	}	
	
	
}
