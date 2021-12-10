package data.controller;

import java.security.Principal;

import java.util.List;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import data.service.ProductLikeService;
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
	
	@Autowired
	ProductLikeService plservice;
	
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
		@RequestParam String email1,
		@RequestParam String email2,
		@RequestParam String hp1,
		@RequestParam String hp2,
		@RequestParam String hp3,
		@RequestParam String addrLocal,
		@RequestParam String zonecode,
		@RequestParam String addr1,
		@RequestParam String addr2,
		MemberDTO dto,
		Principal principal
		) 
	{	
		System.out.println("addrLocal=>" + addrLocal);
		String[] localArr = memService.getLocal(principal).split(",");
		String local = "";
		
		localArr[0] = addrLocal;
		
		for(String i:localArr) {
			local+=i+",";
		}
				
		local = local.substring(0, local.length()-1);
		
		
		dto.setEmail(email1 + "@" + email2); 
		dto.setHp(hp1 + "-" + hp2 + "-" + hp3);
		dto.setLocal(local); 
		dto.setAddr(addr1 + "," + addr2);
		dto.setZonecode(zonecode); 
		memService.updateMember(dto);
		
		return "redirect:../detail";
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
		
		//지역 가져오기
		String userId = "no";
		String local = "";
		String[] localArr = {};
		if(principal != null) {
			userId = principal.getName();
			local = memService.getLocal(principal);
			localArr = local.split(",");
		}
		mview.addObject("localCnt",localArr.length);
		mview.addObject("localArr",localArr);
		
		int totalCount = pservice.getTotalCount(category); 
		//페이징 처리에 필요한 변수
		int perPage = 15; 
		int totalPage;
		int start; 
		int perBlock=5; 
		int startPage; 
		int endPage;
		//총 페이지 갯수
		totalPage = totalCount/perPage + (totalCount%perPage==0?0:1);
		//각 블럭의 시작페이지
		startPage = (currentPage-1)/perBlock * perBlock +1; 
		//각 블럭 마지막페이지
		endPage = startPage + perBlock-1;
		if(endPage>totalPage){ endPage = totalPage; }
		//각 페이지에서 불러올 시작번호
		start = (currentPage-1) * perPage; 
		
		List<ProductDTO> list = pservice.getList(startPage, perPage, category, local);
		
		
		//request에서 getParameter로 kind 값을 불러오기
		String kind = request.getParameter("kind");
		
		//출력에 필요한 변수들을 request에 저장
		mview.addObject("list",list);
		mview.addObject("kind",kind);
		mview.addObject("startPage",startPage);
		mview.addObject("endPage",endPage);
		mview.addObject("totalPage",totalPage);
		mview.addObject("currentPage",currentPage);
		mview.addObject("totalCount",list.size());
		
		mview.setViewName("/mypage/sell_list");
		return mview;
	}
	@GetMapping("/productlike/list")
	public ModelAndView productLikeList(
			@RequestParam (defaultValue = "1") int currentPage, HttpSession session) { 
	ModelAndView mview = new ModelAndView();
	String id = (String)session.getAttribute("myid");
	int totalCount = plservice.getTotalCount(id);
	
	//페이징 처리에 필요한 변수 선언
	int perPage = 20;
	int totalPage;
	int start;
	int perBlock = 5;
	int startPage;
	int endPage;
	
	//총 페이지 갯수 구하기
	totalPage = totalCount/perPage+(totalCount%perPage==0?0:1);
	//각 블럭의 시작 페이지
	startPage = (currentPage-1)/perBlock*perBlock +1;
	//각 블럭의 마지막 페이지
	endPage = startPage + perBlock -1;
	
	if(endPage > totalPage) {
		endPage = totalPage;
	}
	
	//각 페이지에서 불러올 시작번호
	start = (currentPage-1)*perPage;
	
	List<ProductDTO> list = plservice.getList(start, perPage, id);
	
	//각 페이지에 출력할 시작번호
	int no = totalCount-(currentPage-1)*perPage;
	
	//출력에 필요한 변수들을 request에 저장
	mview.addObject("list",list);
	mview.addObject("startPage", startPage);
	mview.addObject("endPage", endPage);
	mview.addObject("totalPage", totalPage);
	mview.addObject("no", no);
	mview.addObject("currentPage", currentPage);
	mview.addObject("totalCount", totalCount);
	
	mview.setViewName("/productlike/list");
		  
	return mview; 
	}
}