package data.controller;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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
		
		String userId = "no";
		String userType = "no";
		String userNickName = "no";
		String local = "";
		String[] localArr = {};
		
		if(principal != null) {
			userId = principal.getName();
			userType = memService.currentUserType(principal);
			userNickName = memService.currentUserNickName(principal);
			local = memService.getLocal(principal);
			localArr = local.split(",");
		}		
		mview.addObject("userType", userType);
		mview.addObject("userNickName", userNickName);		
		mview.addObject("localCnt", localArr.length);
		mview.addObject("localArr", localArr);
		
		mview.setViewName("/mypage/profile_updateForm");
		return mview;
	}
	
	@PostMapping("/auth/profile_update")
	public String pudate(
			Principal principal) {
		HashMap<String, String> map=new HashMap<String, String>();
		
		String userId = "no";
		String userType = "no";
		String userNickName = "no";
		String local = "";
		String[] localArr = {};
		
		if(principal != null) {
			userId = principal.getName();
			userType = memService.currentUserType(principal);
			userNickName = memService.currentUserNickName(principal);
			local = memService.getLocal(principal);
			localArr = local.split(",");
		}		
		map.put("userType", userType);
		map.put("userNickName", userNickName);
		
		return "redirect:/mypage/detail";
	}
	
	@GetMapping("/unregister")
	public ModelAndView deleteForm(
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
