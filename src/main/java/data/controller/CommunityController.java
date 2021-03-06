package data.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import ch.qos.logback.classic.Logger;
import data.dto.AdreplyDTO;
import data.dto.ComReplyDTO;
import data.dto.CommunityDTO;
import data.dto.MemberDTO;
import data.mapper.CommunityMapper;
import data.service.CommunityService;
import data.service.MemberService;

@Controller
@RequestMapping("/community")
public class CommunityController {

	@Autowired
	CommunityService service;
	
	@Autowired
	MemberService mservice;

	@Autowired
	CommunityMapper mapper;
	

	@GetMapping("/list")
	public ModelAndView list(
			@RequestParam(defaultValue = "1") int currentPage,
			Principal principal
			)
	{
		ModelAndView mview = new ModelAndView();
		
		//지역 가져오기
		String userId = "no";
		String local = "";
		String[] localArr = {};
		String currentLocal = "";
		if(principal != null) {
			userId = principal.getName();
			local = mservice.getLocal(principal);
			localArr = local.split(",");
			currentLocal = mservice.currentLocal(userId);
		}
		mview.addObject("localCnt",localArr.length);
		mview.addObject("localArr",localArr);
		mview.addObject("currentLocal",currentLocal);

		int totalCount = service.getTotalCount(); 
		//페이징 처리에 필요한 변수
		int perPage = 16; 
		int totalPage;
		int start; 
		int perBlock=5; 
		int startPage; 
		int endPage;
		//총 페이지 갯수
		totalPage = totalCount/perPage + (totalCount%perPage==0?0:1);
		//각 블럭의 시작페이지
		startPage = (currentPage-1)/perBlock * perBlock +1; 
		//각 블럭의 마지막페이지
		endPage = startPage + perBlock-1;
		if(endPage>totalPage){ endPage = totalPage; }
		//각 페이지에서 불러올 시작번호
		start = (currentPage-1) * perPage; 
		
		List<CommunityDTO> list= service.getList(start, perPage);

		for(CommunityDTO d:list) {
			//댓글 갯수가져오기
			List<ComReplyDTO> relist = service.getReplyList(d.getIdx());
			d.setAcount(relist.size());
		}
		
		//출력에 필요한 변수들을 request에 저장
		mview.addObject("commulist", list); 
		mview.addObject("startPage",startPage);
		mview.addObject("endPage",endPage);
		mview.addObject("totalPage",totalPage);
		mview.addObject("currentPage",currentPage);
		mview.addObject("totalCount",list.size());

		mview.setViewName("/community/list");
		return mview;
	}

	@GetMapping("/auth/insertform")
	public ModelAndView form(
			Principal principal
			)
	{
		ModelAndView mview = new ModelAndView();
		
		//지역 가져오기
		String userId = "no";
		String local = "";
		String[] localArr = {};
		String currentLocal = "";
		if(principal != null) {
			userId = principal.getName();
			local = mservice.getLocal(principal);
			localArr = local.split(",");
			currentLocal = mservice.currentLocal(userId);
		}
		mview.addObject("localCnt",localArr.length);
		mview.addObject("localArr",localArr);
		mview.addObject("currentLocal",currentLocal);
		mview.setViewName("/community/writeForm");
		return mview;
	}

	
	@PostMapping("/auth/insert")
	   public @ResponseBody void insert(
			   @ModelAttribute CommunityDTO dto,
				MultipartHttpServletRequest multiRequest,
				HttpServletRequest request,
				HttpSession session,
				Principal principal
				)throws Exception
	   {
		
	    List<MultipartFile> fileList = multiRequest.getFiles("uploadFile");
	    
	    String title = multiRequest.getParameter("title");
	    String content = multiRequest.getParameter("content");
	      
	    String photoname = "";
	    String originalPhotoName = "";
	    
	    if(fileList != null) {
			String path = session.getServletContext().getRealPath("/photo");

			File dir = new File(path);
			if(!dir.isDirectory()) {
				dir.mkdirs();}
		
		if(!fileList.isEmpty()) {
			for(int i=0; i<fileList.size(); i++) {
				//uuid(랜덤이름) 생성
				String random = UUID.randomUUID().toString();
				String originalFileName = fileList.get(i).getOriginalFilename();
				String saveFileName = random + "_" + originalFileName;
				String savePath = path + "//" + saveFileName;
				fileList.get(i).transferTo(new File(savePath));		
						
				photoname += saveFileName + ",";
				originalPhotoName += originalFileName + ","; 
				}
				
				//마지막 사진 콤마제거
				photoname = photoname.substring(0, photoname.length()-1);
				originalPhotoName = originalPhotoName.substring(0, originalPhotoName.length()-1);
				}
	      	}
	    
	      //아이디 얻어서 dto에 저장하기
	      String id=principal.getName();
	      
	      dto.setId(id);
	      dto.setTitle(title);
	      dto.setContent(content);
	      dto.setPhoto(photoname);
	      dto.setOriginal_photo(originalPhotoName);
	      
	      service.insert(dto);
	   }
	
	

	@GetMapping("/detail")
	public ModelAndView detail(
			@RequestParam String idx,
			@RequestParam(defaultValue = "1") int currentPage,
			@RequestParam(required = false) String key,
			@RequestParam Map<String, String> map,
			HttpServletRequest request,
			Model model,
			Principal principal
			)
	{
		ModelAndView mview = new ModelAndView();
		//지역 가져오기
		String userId = "no";
		String userType = "no";
		String userNickName = "no";
		String local = "";
		String[] localArr = {};
		String currentLocal = "";
		String userProfile = "no";
		
		//아이디,닉네임,위치 가져오기
		if(principal != null) {
			userId = principal.getName();
			userType = mservice.currentUserType(principal);
			userNickName = mservice.currentUserNickName(principal);
			userProfile = mservice.getMemberId(userId).getProfile();
			local = mservice.getLocal(principal);
			localArr = local.split(",");
			currentLocal = mservice.currentLocal(userId);
		}
		
		//로그인 여부
		String isLogin = "N";
		isLogin = (String)request.getSession().getAttribute("isLogin");

		//로그인 되어 있을 경우,
		if(isLogin!=null) {
			String id = principal.getName();
			model.addAttribute("myId", id);
		}
		//리스트에서 들어올 경우 조회수 증가하기
		if(key!=null) {
			service.updateReadCount(idx);
			
		}
		//커뮤니티DTO 데이터 가져오기 
		CommunityDTO dto = service.getData(idx);
		
		//게시글 닉네임,이미지 불러오기
		String nick = mservice.getNick(dto.getId());
		String profile = mservice.getMemberId(dto.getId()).getProfile(); //  게시글 쓴 애 프로필
		
		//,로 DB사진나누기 (대표이미지)
		String [] photo = dto.getPhoto().split(",");
		
		//댓글관련
		String maxReply = service.getMaxReply(idx);
		
		List<ComReplyDTO> relist = service.getReplyList(idx);
		int recount = relist.size();
		
		for(ComReplyDTO cdto:relist) {
			cdto.setNickname(mservice.getNick(cdto.getId()));
			cdto.setProfile(mservice.getMemberId(cdto.getId()).getProfile());
		}
		
		mview.addObject("dto",dto);
		mview.addObject("photo",photo);
		mview.addObject("nick",nick);
		mview.addObject("userId", userId);
		mview.addObject("userType", userType);
		mview.addObject("userNickName", userNickName);
		mview.addObject("userProfile", userProfile); // 현재 로그인된 애 프로필 (댓글쓸때)
		mview.addObject("relist", relist);
		mview.addObject("recount", recount);
		mview.addObject("maxReply", maxReply);
		mview.addObject("localCnt", localArr.length);
		mview.addObject("localArr", localArr);
		mview.addObject("currentLocal",currentLocal);
		mview.addObject("currentPage", currentPage);
		mview.addObject("isLogin", isLogin);
		mview.addObject("profile", profile);
		
		System.out.println("isLogin=>" + isLogin);
		
		mview.setViewName("/community/detail");
		
		return mview;
	}
	
	@GetMapping("/auth/delete")
	public String delete(
			@RequestParam String idx,
			@RequestParam String currentPage
			)
	{
	    service.delete(idx);
		return "redirect:../list?currentPage="+currentPage;
	}
	
	@GetMapping("/auth/updateform")
	public ModelAndView updateform(
			 @RequestParam String idx,
			 @RequestParam String currentPage,
			Principal principal
			) 
	{
		ModelAndView mview = new ModelAndView();
		
		//지역 가져오기
		String userId = "no";
		String local = "";
		String[] localArr = {};
		String currentLocal = "";
		if(principal != null) {
			userId = principal.getName();
			local = mservice.getLocal(principal);
			localArr = local.split(",");
			currentLocal = mservice.currentLocal(userId);
		}
		
		CommunityDTO dto = service.getData(idx);
		String[] photoList = dto.getPhoto().split(",");
		
		mview.addObject("dto",dto);
		mview.addObject("currentPage",currentPage);
		mview.addObject("localCnt", localArr.length);
		mview.addObject("localArr", localArr);
		mview.addObject("currentLocal",currentLocal);
		mview.addObject("photoList",photoList);
		mview.setViewName("/community/updateForm");
		return mview;
	}
	
	@PostMapping("/auth/update")
	public @ResponseBody void update(
			@RequestParam String idx,
			MultipartHttpServletRequest multiRequest,
			HttpServletRequest request,
			HttpSession session
			)throws Exception
	{
		
		String path = session.getServletContext().getRealPath("/photo");
		
		List<MultipartFile> fileList = multiRequest.getFiles("uploadFile");
	    String title = multiRequest.getParameter("title");
	    String content = multiRequest.getParameter("content");
	      
	    String photoname = multiRequest.getParameter("updatePhoto");
	    String originalPhotoName = multiRequest.getParameter("updateOrigin");
	    
	    if(fileList != null) {
			File dir = new File(path);
			if(!dir.isDirectory()) {
				dir.mkdirs();}
		
		if(!fileList.isEmpty()) {
			for(int i=0; i<fileList.size(); i++) {
				String random = UUID.randomUUID().toString();
				String originalFileName = fileList.get(i).getOriginalFilename();
				String saveFileName = random + "_" + originalFileName;
				String savePath = path + "\\" + saveFileName;
				fileList.get(i).transferTo(new File(savePath));		
						
				photoname += saveFileName + ",";
				originalPhotoName += originalFileName + ","; 
				}
					
				photoname = photoname.substring(0, photoname.length()-1);
				originalPhotoName = originalPhotoName.substring(0, originalPhotoName.length()-1);
			}
	    }
	    
	    CommunityDTO dto = new CommunityDTO();
	    dto.setTitle(title);
	    dto.setContent(content);
	    dto.setPhoto(photoname);
	    dto.setIdx(idx);
	    dto.setOriginal_photo(originalPhotoName);
		
		//수정
		service.update(dto);
	}
	
	
	@PostMapping("/updateGoodcount")
	public @ResponseBody HashMap<String, Integer> updateGoodCount(
			@RequestParam String idx, 
			Principal principal
			) 
	{
		//goodcount +1 하기 
		service.updateGoodCount(idx);
		Integer goodCnt = service.getGoodCount(idx);
		HashMap<String, Integer> resultMap = new HashMap<String, Integer>();
		resultMap.put("goodCnt", goodCnt);
		
		return resultMap;
	}
	
	
	@PostMapping("/updateGoodCancel")
	public @ResponseBody HashMap<String, Integer> updateGoodCancel(
			@RequestParam String idx, 
			Principal principal
			) 
	{
		//goodcount -1하기
		service.updateGoodCancel(idx);
		
		Integer goodCnt = service.getGoodCount(idx);
		HashMap<String, Integer> resultMap = new HashMap<String, Integer>();
		resultMap.put("goodCnt", goodCnt);
		
		return resultMap;
	}
	
	@PostMapping("/auth/reply/insert")
	public @ResponseBody void replyInsert(
			@ModelAttribute ComReplyDTO dto,
			@RequestParam String checkStep,
			Principal principal
			)
	{
		System.out.println("checkStep =>"+ checkStep);
		int regroup = dto.getRegroup();
		int restep = dto.getRestep();
		int relevel = dto.getRelevel();
		
		dto.setId(principal.getName());
		if(checkStep.equals("no")) {
			regroup = regroup + 1;
			restep = 0;
			relevel = 0;
		}else {
			service.updateReplyStep(restep,regroup);
			
			restep++;
			relevel++;
		}
		dto.setRegroup(regroup);
		dto.setRestep(restep);
		dto.setRelevel(relevel);
		service.insertReplyData(dto);
	}
	
	@GetMapping("/auth/reply/delete")
	public @ResponseBody void replyDelete(
			@RequestParam String idx
			)
	{
		service.deleteReply(idx);
	}
	
	
}















