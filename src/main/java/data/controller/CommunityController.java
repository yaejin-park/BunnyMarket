package data.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import data.service.ComreplyService;
import data.service.MemberService;

@Controller
@RequestMapping("/community")
public class CommunityController {

	@Autowired
	CommunityService service;
	@Autowired
	ComreplyService reservice;
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
		if(principal != null) {
			userId = principal.getName();
			local = mservice.getLocal(principal);
			localArr = local.split(",");
		}
		mview.addObject("localCnt",localArr.length);
		mview.addObject("localArr",localArr);

		//페이징 처리하기
		int totalCount = service.getTotalCount(); 
		int perPage = 15; 
		int totalPage;
		int start; 
		int perBlock=5; 
		int startPage; 
		int endPage;

		totalPage = totalCount/perPage + (totalCount%perPage==0?0:1);

		startPage = (currentPage-1)/perBlock * perBlock +1; 
		endPage = startPage + perBlock-1;
		if(endPage>totalPage){ endPage = totalPage; }
		start = (currentPage-1) * perPage; 
		
		List<CommunityDTO> list= service.getList(start, perPage);

		for(CommunityDTO d:list) {
			//댓글
			List<ComReplyDTO> relist=reservice.getReplyList(Integer.parseInt(d.getIdx()));
			d.setAcount(relist.size());
		}
		
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
		if(principal != null) {
			userId = principal.getName();
			local = mservice.getLocal(principal);
			localArr = local.split(",");
		}
		mview.addObject("localCnt",localArr.length);
		mview.addObject("localArr",localArr);
		mview.setViewName("/community/writeForm");
		return mview;
	}

	
	@PostMapping("/auth/insert")
	   public @ResponseBody void insert(
				MultipartHttpServletRequest multiRequest,
				HttpServletRequest request,
				HttpSession session,
				Principal principal
				)throws Exception
	   {
		
		//로그인중이 아닐 경우 종료
		String isLogin=(String)request.getSession().getAttribute("isLogin");
		if(isLogin==null) {
			return;
		}
		
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
				String savePath = path + "\\" + saveFileName;
				fileList.get(i).transferTo(new File(savePath));		
						
				photoname += saveFileName + ",";
				originalPhotoName += originalFileName + ","; 
				}
				
				//마지막 사진 콤마제거
				photoname = photoname.substring(0, photoname.length()-1);
				originalPhotoName = originalPhotoName.substring(0, originalPhotoName.length()-1);
				}
	      }
	      
	      //아이디 얻어서 dto에 저장
	      String id = principal.getName();
	      CommunityDTO dto = new CommunityDTO();
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
			@RequestParam(required = false) String key,
			HttpServletRequest request,
			Principal principal,
			@RequestParam Map<String, String> map
			)
	{
		ModelAndView mview = new ModelAndView();
		
		//커뮤니티DTO 데이터 가져오기 
		CommunityDTO dto = service.getData(idx);
		
		//멤버DTO 데이터 가져오기 
		MemberDTO mdto =service.getMemData(idx);
		 
		//닉네임 가져오기
		String nick = mservice.getNick(dto.getId());
		
		//로그인 여부
		String isLogin = "N";
		isLogin = (String)request.getSession().getAttribute("isLogin");
		
		//로그인 되어있을때 
		if(isLogin!=null) {
			//로그인 아이디 가져오기
			String id = principal.getName();
			mview.addObject("myId",id);
			
			//공감 클릭여부
			int goodCheck = service.goodCheck(id, idx);
			mview.addObject("goodCheck",goodCheck);
		}
		
		//리스트에서 들어올 경우 조회수 증가하기
		if(key!=null)
			service.updateReadCount(idx);
		
		//,로 사진나누기 (대표이미지)
		String []photo = dto.getPhoto().split(",");
		
		//지역 가져오기
		String userId = "no";
		String local = "";
		String[] localArr = {};
		if(principal != null) {
			userId = principal.getName();
			local = mservice.getLocal(principal);
			localArr = local.split(",");
		}
		mview.addObject("localCnt",localArr.length);
		mview.addObject("localArr",localArr);
		
		mview.addObject("dto",dto);
		mview.addObject("mdto",mdto);
		mview.addObject("photo",photo);
		mview.addObject("isLogin",isLogin);
		mview.addObject("nick",nick);
		
		//댓글
		List<ComReplyDTO> relist=reservice.getReplyList(Integer.parseInt(idx));
		mview.addObject("recount", relist.size());
		mview.addObject("relist", relist);
		
		 //아래값은 답글일 경우만 넘어옴(num, currentPage도) 
		String currentPage=map.get("currentPage"); 
		String num=map.get("num"); 
		String regroup=map.get("regroup"); 
		String restep=map.get("restep"); 
		String relevel=map.get("relevel");
		  
		  //입력폼에 hidden 넣어줘야함 
		mview.addObject("num", num==null?"0":num);
		mview.addObject("currentPage",currentPage==null?"1":currentPage);
		mview.addObject("regroup",regroup==null?"0":regroup);
		mview.addObject("restep",restep==null?"0":restep);
		mview.addObject("relevel",relevel==null?"0":relevel);
		 
		mview.setViewName("/community/detail");
		
		return mview;
	}
	
	@GetMapping("/delete")
	public String delete(
			@RequestParam String idx,
			@RequestParam String currentPage,
			HttpSession session
			)
	{
		//실제 업로드 폴더경로 구하기
		String path = session.getServletContext().getRealPath("/photo");
		System.out.println(path);
		
		//업로드 파일명 구하기
		String photo=service.getData(idx).getPhoto();
		
		//File 객체 생성
		File file = new File(path + "\\" + photo);
		
		//삭제하기
		file.delete();
		
		service.delete(idx);
		return "redirect:list?currentPage="+currentPage;
	}
	
	@GetMapping("/updateform")
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
		if(principal != null) {
			userId = principal.getName();
			local = mservice.getLocal(principal);
			localArr = local.split(",");
		}
		
		CommunityDTO dto = service.getData(idx);
		
		mview.addObject("dto",dto);
		mview.addObject("currentPage",currentPage);
		mview.addObject("localCnt", localArr.length);
		mview.addObject("localArr", localArr);
		mview.setViewName("/community/updateForm");
		return mview;
	}
	
	@PostMapping("/update")
	public @ResponseBody void update(
			MultipartHttpServletRequest multiRequest,
			HttpServletRequest request,
			HttpSession session,
			@RequestParam String idx,
			@RequestParam String currentPage,
			Principal principal
			)throws Exception
	{
		
		//로그인중이 아닐 경우 종료
		String isLogin=(String)request.getSession().getAttribute("isLogin");
		if(isLogin==null) {
			return;
		}
		 
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
	    
	    String id = principal.getName();
	    CommunityDTO dto = new CommunityDTO();
	    dto.setId(id);
	    dto.setIdx(idx);
	    dto.setTitle(title);
	    dto.setContent(content);
	    dto.setPhoto(photoname);
	    dto.setOriginal_photo(originalPhotoName);
		
		//수정
		service.update(dto);
		
	}
	
	@ResponseBody
	@PostMapping("/updateGoodcount")
	public int updateGoodcount(@RequestParam String idx, Principal principal) {
		String id = principal.getName();
		//goodcount +1 하기 
		service.updateGoodcount(idx);
		//데이터 추가
		service.insertGood(id, idx);
		
		return service.getGoodCount(idx);
	}
	
	@ResponseBody
	@PostMapping("/updateGoodCancel")
	public int updateGoodCancel(@RequestParam String idx, Principal principal) {
		String id = principal.getName();
		//goodcount -1하기
		service.updateGoodCancel(idx);
		//데이터 삭제
		service.deleteGood(id, idx);
		
		return service.getGoodCount(idx);
	}
	
}















