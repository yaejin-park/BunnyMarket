package data.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
	public String register() {
		return "/mypage/unregister_member";
	}
}
