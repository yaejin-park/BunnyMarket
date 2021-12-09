package data.controller;

import java.security.Principal;

import java.util.List;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import data.dto.MemberDTO;
import data.dto.ProductDTO;

import data.service.FollowService;
import data.service.MemberService;
import data.service.ProductService;

@Controller
@RequestMapping("/mypage/auth")
public class MypageController {
	@Autowired
	MemberService memService;
	
	@Autowired
	private BCryptPasswordEncoder encoder;
	
	@Autowired
	ProductService pservice;
	
	@Autowired
	ProductService pdService;
	
	@Autowired
	FollowService pfService;
	
	@GetMapping("/detail")
	public ModelAndView detail(
			HttpServletRequest request,
			Principal principal
		) 
	{
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
	
	@GetMapping("/profile_updateform")
	public ModelAndView pupdateform(
			HttpServletRequest request,
			Principal principal
		) 
	{
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
	
	@PostMapping("/profile_update")
	public String pudate(
			Principal principal
		) 
	{
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
	
	@PostMapping("/changepw")
	public @ResponseBody void changePw(
		@RequestParam String pw,
		Principal principal
		) 
	{
		String changePw = encoder.encode(pw);
		String userId = principal.getName();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("pw", changePw);
		map.put("id", userId);
		memService.updatePw(map);
	} 
	
	@GetMapping("/member/updateform")
	public ModelAndView updateForm(
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
		MemberDTO dto = memService.getMemberId(userId);
		
		mview.addObject("localCnt", localArr.length);
		mview.addObject("localArr", localArr);
		mview.addObject("dto", dto);
		mview.setViewName("/mypage/updateMemberForm");
		return mview;
	}
	
	@PostMapping("/member/update")
	public String updateMember(
		@RequestParam String type,
		@RequestParam String email1,
		@RequestParam String email2,
		@RequestParam String hp1,
		@RequestParam String hp2,
		@RequestParam String hp3,
		@RequestParam String addrLocal,
		@RequestParam String zonecode,
		@RequestParam String addr1,
		@RequestParam String addr2,
		MemberDTO dto
		) 
	{	
		dto.setType(type);
		dto.setPw(encoder.encode(dto.getPw()));
		dto.setEmail(email1 + "@" + email2);
		dto.setHp(hp1 + "-" + hp2 + "-" + hp3);
		dto.setLocal(addrLocal);
		dto.setAddr(addr1 + "," + addr2);
		dto.setZonecode(zonecode);
		memService.updateMember(dto);
		return "redirect:complete";
	}
	
	@GetMapping("/member/deleteform")
	public ModelAndView deleteForm(
		Principal principal
		) 
	{
		ModelAndView mview = new ModelAndView();
		String userId = "no";
		String userNickName = "";
		String local="";
		String[] localArr = {};
		if(principal != null) {
			userId = principal.getName();
			userNickName = memService.currentUserNickName(principal);
			local = memService.getLocal(principal);
			localArr = local.split(",");
		}
		
		mview.addObject("localCnt", localArr.length);
		mview.addObject("localArr", localArr);
		mview.addObject("userNickName", userNickName);
		mview.setViewName("/mypage/deleteMemberForm");
		return mview;
	}
	
	@GetMapping("/member/deletemember")
	public String deleteMember(
		Principal principal,
		HttpServletRequest request
		) 
	{
		memService.deleteMember(principal.getName());
		request.getSession().removeAttribute("isLogin");
		return "redirect:/logout";
	}
	

	@PostMapping("/auth/sell_list")
	public @ResponseBody ModelAndView sell_list(
		@RequestParam(defaultValue = "1") int currentPage,
		@RequestParam (defaultValue = "전체") String category,
		HttpServletRequest request,
		HttpServletResponse response,
		Model model,
		Principal principal) throws Exception
	{
		ModelAndView mview = new ModelAndView();
		
		
		mview.setViewName("/mypage/sell_list");
		return mview;
	}
	
}
