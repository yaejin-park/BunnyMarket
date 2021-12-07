package data.controller;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import data.service.MemberService;

@Controller
@RequestMapping("/mypage")
public class MypageController {
	@Autowired
	MemberService memService;
	
	@GetMapping("/detail")
	public String detail() {
		
		return "/mypage/detail";
	}
	
	@GetMapping("/updateform")
	public String update() {
		return "/mypage/test_updateForm";
	}
	
	@GetMapping("/profile_updateform")
	public String pupdate() {
		return "/mypage/profile_updateForm";
	}
	
	@GetMapping("/unregister")
	public ModelAndView register(
		Principal principal
		) 
	{
		ModelAndView mview = new ModelAndView();
		String userId = "no";
		String local="";
		String[] localArr = {};
		if(principal != null) {
			userId = principal.getName();
			local = memService.getLocal(principal);
			localArr = local.split(",");
		}
		
		mview.addObject("localCnt", localArr.length);
		mview.addObject("localArr", localArr);
		mview.setViewName("/mypage/unregister_member");
		return mview;
	}
	
	@GetMapping("/deletemember")
	public String deleteMember(
		Principal principal,
		HttpServletRequest request
		) 
	{
		memService.deleteMember(principal.getName());
		request.getSession().removeAttribute("isLogin");
		return "redirect:/logout";
	}
}
