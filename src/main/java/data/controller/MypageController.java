package data.controller;

import java.security.Principal;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import data.service.FollowService;
import data.service.MemberService;
import data.service.ProductService;

@Controller
@RequestMapping("/mypage")
public class MypageController {
	@Autowired
	MemberService memService;
	
	@Autowired
	ProductService pdService;
	
	@Autowired
	FollowService pfService;
	
	@GetMapping("/detail")
	public ModelAndView detail(
			HttpServletRequest request,
			Principal principal) {
		ModelAndView mview=new ModelAndView();
		
		//로그인 체크
		String isLogin="N";
		isLogin=(String)request.getSession().getAttribute("isLogin");
		
		//로그인 되어 있을 경우,
		if(isLogin!=null) {
			//로그인 아이디 가져오기
			String id=principal.getName();
			mview.addObject("myId", id);
		}
		
		//닉네임 가져오기
		String nick=memService.getNick(principal.getName());		
		mview.addObject("isLogin", isLogin);
		mview.addObject("nick", nick);
		
		//프로필 이미지
		
		mview.setViewName("/mypage/detail");
		return mview;
	}
	
	@GetMapping("/updateform")
	public String update() {
		return "/mypage/test_updateForm";
	}
	
	@GetMapping("/auth/profile_updateform")
	public ModelAndView pupdateform(HttpServletRequest request,
			Principal principal) {
		ModelAndView mview=new ModelAndView();
		
		//로그인 체크
		String isLogin="N";
		isLogin=(String)request.getSession().getAttribute("isLogin");
		
		//로그인 되어 있을 경우,
		if(isLogin!=null) {
			//로그인 아이디 가져오기
			String id=principal.getName();
			mview.addObject("myId", id);
		}
		
		//닉네임 가져오기
		String nick=memService.getNick(principal.getName());
		
		mview.addObject("isLogin", isLogin);
		mview.addObject("nick", nick);
		
		mview.setViewName("/mypage/profile_updateForm");
		return mview;
	}
	
	@PostMapping("/auth/profile_update")
	public String pudate(@RequestParam HashMap<String, String> map,
			Principal principal) {		
		String nick=map.get("nick");
		map.put("nick", nick);
		
		memService.updateNickName(map);
		return "/mypage/detail";
	}
	
	@GetMapping("/unregister")
	public String register() {
		return "/mypage/unregister_member";
	}
}
