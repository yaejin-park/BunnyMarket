package data.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import data.service.MemberService;

@Controller
public class MainController {
	@Autowired
	MemberService memberService;
	
	@GetMapping({"/", "/index"})
	public ModelAndView home(
		Principal principal
		) 
	{
		ModelAndView mview = new ModelAndView();
		String userId = "no";
		String local ="";
		String[] localArr = {};
		if(principal != null) {
			userId = principal.getName();
			local = memberService.getLocal(principal);
			localArr = local.split(",");
		}
				
		mview.addObject("localCnt", localArr.length);
		mview.addObject("localArr", localArr);
		mview.setViewName("/layout/main");
		return mview;
	}
	
	@GetMapping("/sub")
	public String sub() {
		return "/layout/content";
	}
}
