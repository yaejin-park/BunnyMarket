package data.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import data.dto.AdreplyDTO;
import data.dto.AdvertiseDTO;
import data.service.AdvertiseService;
import data.service.MemberService;

@Controller
@RequestMapping("/advertise")
public class AdvertiseController {
	@Autowired
	AdvertiseService service;
	
	@Autowired
	MemberService memService;
	
	@GetMapping("/list")
	public ModelAndView list(@RequestParam(defaultValue = "1") int currentPage,
			Principal principal) {
		ModelAndView mview=new ModelAndView();
		
		 //지역가져올라면...
		 String userId="no";
		 String local="";
		 String []localArr = {};
		String currentLocal = "";
		 if(principal != null) {
		    userId=principal.getName();
		    local = memService.getLocal(principal);
		    localArr=local.split(",");
			currentLocal = memService.currentLocal(userId);
		 }
		  
		  mview.addObject("localCnt", localArr.length);
		  mview.addObject("localArr", localArr);
		  mview.addObject("currentLocal", currentLocal);
		
		int totalCount=service.getTotalCount();
		
		//페이징에 필요한 변수들
		int perPage=10;
		int totalPage;
		int start;
		int perBlock=5;
		int startPage;
		int endPage;
		
		//총 페이지 개수
		totalPage=totalCount/perPage+(totalCount%perPage==0?0:1);
		//각 블럭의 시작페이지
		startPage=(currentPage-1)/perBlock*perBlock+1;
		endPage=startPage+perBlock-1;
		if(endPage>totalPage) {
			endPage=totalPage;
		}
		//각 페이지에서 불러올 시작번호
		start=(currentPage-1)*perPage;
		
		//각 페이지에서 필요한 게시글 가져오기
		List<AdvertiseDTO> list=service.getList(start, perPage);
		
		//닉네임 가져오기
		AdvertiseDTO dto=new AdvertiseDTO();
		String nick = memService.getNick(dto.getId());
		mview.addObject("nick", nick);
		
		//출력에 필요한 변수들 request에 저장
		mview.addObject("list", list);
		mview.addObject("startPage", startPage);
		mview.addObject("endPage", endPage);
		mview.addObject("totalPage", totalPage);
		mview.addObject("currentPage", currentPage);
		mview.addObject("totalCount", totalCount);
		
		mview.setViewName("/advertise/list");
		return mview;
	}
	
	@GetMapping("/auth/insertform")
	public String from(Principal principal) {

		String userId="no";
		if(principal != null) {
			userId=principal.getName();
		}
		
		return "/advertise/writeForm";
	}
	
	@PostMapping("/auth/insert")
	public @ResponseBody void insert(@ModelAttribute AdvertiseDTO dto,
			HttpSession session, 
			HttpServletRequest request,
			MultipartHttpServletRequest multiRequest,
			Principal principal,
			@RequestParam List<MultipartFile> photoupload) throws Exception {

		//로그인중이 아닐 경우 종료
		String isLogin=(String)request.getSession().getAttribute("isLogin");
		if(isLogin==null) {
			return;
		}
		
		//uuid(랜덤이름) 생성
		UUID uuid=UUID.randomUUID();
		
		String title=multiRequest.getParameter("title");
		String content=multiRequest.getParameter("content");
		photoupload = dto.getPhotoupload();
	
		//이미지 업로드 안했을때
		if(photoupload.get(0).getOriginalFilename().equals("")) {
			dto.setPhoto("no");
		}else {	//이미지 업로드 했을때
			//이미지 업로드 폴더 지정
			String path=session.getServletContext().getRealPath("/photo");
			String photoplus="";
			System.out.println(path);
	
			for(int i=0;i<photoupload.size();i++) {
				String photo=uuid.toString()+"_"+photoupload.get(i).getOriginalFilename();
				//실제 업로드
				try {
					photoupload.get(i).transferTo(new File(path+"\\"+photo));
				} catch (IllegalStateException | IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				photoplus += photo+",";
			}
			//마지막 콤마 제거
			photoplus = photoplus.substring(0, photoplus.length()-1);
			dto.setPhoto(photoplus);
		}
		//아이디 얻어서 dto에 저장
		String id=principal.getName();
		dto.setId(id);
		
		dto.setTitle(title);
		dto.setContent(content);
		
		//insert
		service.insertAdvertise(dto);
	}
	
	@GetMapping("/detail")
	public ModelAndView detail(@RequestParam String idx,
				@RequestParam(defaultValue = "1") int currentPage,
				@RequestParam(required = false) String key,
				@RequestParam Map<String, String> map,
				HttpServletRequest request, Principal principal,
				Model model) {
		ModelAndView mview=new ModelAndView();
		
		String userId = "no";
		String userType = "no";
		String userNickName = "no";
		String local = "";
		String[] localArr = {};
		String userProfile = "no";
		String currentLocal = "";
		
		//로그인 여부
		String isLogin = "N";
		isLogin = (String)request.getSession().getAttribute("isLogin");
		//로그인 되어 있을 경우,
		if(isLogin!=null) {
			String id = principal.getName();
			model.addAttribute("myId", id);
		} 
		
		if(principal != null) {
			userId = principal.getName();
			userType = memService.currentUserType(principal);
			userNickName = memService.currentUserNickName(principal);
			local = memService.getLocal(principal);
			localArr = local.split(",");
			currentLocal = memService.currentLocal(userId);
			userProfile=memService.getMemberId(userId).getProfile();
		}
		
		//조회수 증가
		if(key!=null) {
			service.updateReadCount(idx);
		}
		
		AdvertiseDTO dto=service.getData(idx);
		//이미지
		String []dbimg=dto.getPhoto().split(",");
		String maxReply = service.getMaxReply(idx);
		
		//게시글 닉네임, 이미지 불러오기
		String nick=memService.getNick(dto.getId());
		String profile=memService.getMemberId(dto.getId()).getProfile();
		
		//댓글관련
		List<AdreplyDTO> relist=service.getReplyList(idx);
		int recount=relist.size();
		
		for(AdreplyDTO reDto:relist) {
			reDto.setNickname(memService.getNick(reDto.getId()));
			reDto.setProfile(memService.getMemberId(reDto.getId()).getProfile());
		}
		mview.addObject("dto", dto);
		mview.addObject("currentPage", currentPage);
		mview.addObject("dbimg", dbimg);
		mview.addObject("nick", nick);
		mview.addObject("recount", recount);
		mview.addObject("relist", relist);		
		mview.addObject("userType", userType);
		mview.addObject("userNickName", userNickName);
		mview.addObject("userId", userId);
		mview.addObject("maxReply", maxReply);
		mview.addObject("localCnt", localArr.length);
		mview.addObject("localArr", localArr);
		mview.addObject("currentLocal", currentLocal);
		mview.addObject("isLogin", isLogin);
		mview.addObject("profile", profile);
		mview.addObject("userProfile", userProfile); //현재 로그인 된 유저 프로필
		
		mview.setViewName("/advertise/detail");
		return mview;
	}
	
	@GetMapping("/auth/updateform")
	public ModelAndView updateForm(@RequestParam String idx,
				@RequestParam(defaultValue = "1") int currentPage,
				Principal principal) {
		ModelAndView mview=new ModelAndView();
		
		String userId = "no";
		String local = "";
		String[] localArr = {};
		if(principal != null) {
			userId = principal.getName();
			local = memService.getLocal(principal);
			localArr = local.split(",");
		}
		AdvertiseDTO dto=service.getData(idx);
		
		mview.addObject("dto", dto);
		mview.addObject("currentPage", currentPage);
		mview.addObject("localCnt", localArr.length);
		mview.addObject("localArr", localArr);
		//이미지
		String []photoList=dto.getPhoto().split(",");
		mview.addObject("photoList", photoList);
		
		mview.setViewName("/advertise/updateForm");
		return mview;
	}
	
	@PostMapping("/auth/update")
	public @ResponseBody void update(
			@RequestParam String idx,
			MultipartHttpServletRequest multiRequest,
			HttpServletRequest request,
			HttpSession session
			) throws Exception
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
				dir.mkdirs();
			}
			
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

		AdvertiseDTO dto = service.getData(idx);
		dto.setIdx(idx);
		dto.setTitle(title);
		dto.setContent(content);
		dto.setPhoto(photoname);
		dto.setOriginal_photo(originalPhotoName);
		
		service.updateAdvertise(dto);
	}
	
	@GetMapping("/auth/delete")
	public String delete(@RequestParam String idx,
				@RequestParam String currentPage,
				HttpSession session, AdvertiseDTO dto) {
		//글삭제시 저장된 이미지도 삭제
		String path=session.getServletContext().getRealPath("/photo");
		//업로드된 이미지명
		String uploadimg=service.getData(dto.getIdx()).getPhoto();
		//File 객체 생성
		File file=new File(path+"\\"+uploadimg);
		//이미지 삭제
		file.delete();
		
		service.deleteAdvertise(idx);
		return "redirect:/advertise/list?currentPage="+currentPage;
	}
	
	//reply insert
	@PostMapping("/auth/reply/insert")
	public @ResponseBody void replyInsert(
			@ModelAttribute AdreplyDTO dto,
			@RequestParam String checkStep,
			Principal principal
			) 
		{
		System.out.println("checkStep =>" +checkStep);
		int regroup = dto.getRegroup();
		int restep = dto.getRestep();
		int relevel = dto.getRelevel();
		
		dto.setId(principal.getName());
		if(checkStep.equals("no")) {
			regroup = regroup+1;
			restep=0;
			relevel=0;
		}else {
			service.updateReplyStep(restep, regroup);
			
			restep++;
			relevel++;
		}

		dto.setRegroup(regroup);
		dto.setRestep(restep);
		dto.setRelevel(relevel);
		service.insertReplyData(dto);
	}
	
	@GetMapping("/auth/reply/delete")
	public @ResponseBody void delete(@RequestParam int idx) {
		System.out.println(idx);
		service.deleteReply(idx);
	}
}
