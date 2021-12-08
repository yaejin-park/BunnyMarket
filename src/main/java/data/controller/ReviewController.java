package data.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.servlet.ModelAndView;

import data.service.MemberService;
import data.service.ReviewService;

@Controller
public class ReviewController {
	
	

	
	@Autowired 
	ReviewService Rservice;
	
	@Autowired
	MemberService Mservice;
	
	@GetMapping("/review/insertForm")
	public String insertForm() {
		return "/review/insertForm";
	}
	
	@GetMapping("/review/choose")
	public ModelAndView choose(Principal principal) {
		ModelAndView mview = new ModelAndView();
		
		//아이디 얻어오기
		String id=principal.getName();
		System.out.println(id);
		//닉네임 얻어오기
		String nickname=Mservice.getNick(id);
		System.out.println(nickname);
		List<String> time=Rservice.getTime(id);
		System.out.println(time);
		
		mview.addObject("nickname", nickname);
		mview.addObject("time", time);
		mview.setViewName("/review/choose");
		return mview;
		
		
		
		
	}
	
	
}
