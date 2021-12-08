package data.controller;

import java.io.File;
import java.security.Principal;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import data.dto.EventDTO;
import data.dto.EventReplyDTO;
import data.service.EventService;
import data.service.MemberService;

@Controller
@RequestMapping("/event")
public class EventController {
	@Autowired
	EventService service;
	@Autowired
	MemberService memberService;
	
	@GetMapping("/list")
	public ModelAndView list(
		@RequestParam(defaultValue = "1") int currentPage,
		@RequestParam(defaultValue = "전체") String category,
		Principal principal
		) 
	{
		ModelAndView mview = new ModelAndView();
		String userType = "no";
		String userId = "no";
		String local ="";
		String[] localArr = {};
		if(principal != null) {
			userId = principal.getName();
			userType = memberService.currentUserType(principal);
			local = memberService.getLocal(principal);
			localArr = local.split(",");
		}
		
		List<String> categoryArr = service.getCategory();
		int total = service.getTotal(category);
		
		int perPage=10;
		int totalPage;
		int start;
		int perBlock=5;
		int startPage;
		int endPage;
		
		totalPage=total/perPage+(total%perPage==0?0:1);
		startPage=(currentPage-1)/perBlock*perBlock+1;
		endPage=startPage+perBlock-1;
		if(endPage>totalPage) {
			endPage=totalPage;
		}
		start=(currentPage-1)*perPage;
		
		List<EventDTO> list = service.getPageList(start , perPage, category);
		
		mview.addObject("totalCount", total);
		mview.addObject("eventList", list);
		mview.addObject("startPage", startPage);
		mview.addObject("endPage", endPage);
		mview.addObject("currentPage", currentPage);
		mview.addObject("userType", userType);
		mview.addObject("categoryArr", categoryArr);
		mview.addObject("selectCategory", category);
		mview.addObject("localCnt", localArr.length);
		mview.addObject("localArr", localArr);
		mview.setViewName("/event/list");
		return mview;
	}
	
	@GetMapping("/detail")
	public ModelAndView detail(
		@RequestParam String idx,
		@RequestParam(defaultValue = "1") int currentPage,
		@RequestParam(required = false) String key,
		@RequestParam Map<String, String> map,
		Principal principal
		) 
	{
		ModelAndView mview = new ModelAndView();
		String userId = "no";
		String userType = "no";
		String userNickName = "no";
		String local = "";
		String[] localArr = {};
		if(principal != null) {
			userId = principal.getName();
			userType = memberService.currentUserType(principal);
			userNickName = memberService.currentUserNickName(principal);
			local = memberService.getLocal(principal);
			localArr = local.split(",");
		}
		if(key != null) {
			service.updateReadCount(idx);
		}
		EventDTO dto = service.getData(idx);
		String[] photoList = dto.getPhoto().split(",");
		String maxReply = service.getMaxReply(idx);
		
		
		List<EventReplyDTO> relist = service.getReplyList(idx);
		int recount = relist.size();
		
		for(EventReplyDTO reDto:relist) {
			reDto.setNickname(memberService.getNick(reDto.getId()));
		}
		mview.addObject("dto", dto);
		mview.addObject("photoList", photoList);
		mview.addObject("userType", userType);
		mview.addObject("userNickName", userNickName);
		mview.addObject("relist", relist);
		mview.addObject("recount", recount);
		mview.addObject("maxReply", maxReply);
		mview.addObject("localCnt", localArr.length);
		mview.addObject("localArr", localArr);
		mview.addObject("currentPage", currentPage);
		
		mview.setViewName("/event/detail");
		
		return mview;
	}
	
	@GetMapping("/auth/insertform")
	public ModelAndView addForm(
			Principal principal
			) 
	{
		ModelAndView mview = new ModelAndView();
		String userId = "no";
		String local = "";
		String[] localArr = {};
		if(principal != null) {
			userId = principal.getName();
			local = memberService.getLocal(principal);
			localArr = local.split(",");
		}

		mview.addObject("localCnt", localArr.length);
		mview.addObject("localArr", localArr);
		mview.setViewName("/event/writeForm");
		return mview;
	}
	
	@PostMapping("/auth/insert")
	public @ResponseBody void insertData(
		MultipartHttpServletRequest multiRequest,
		HttpServletRequest request,
		HttpSession session
		) throws Exception
	{
		//System.out.println("fileList =>" + multiRequest.getFile("uploadFile"));
		List<MultipartFile> fileList = multiRequest.getFiles("uploadFile");
		String title = multiRequest.getParameter("title");
		String content = multiRequest.getParameter("content");
		String category = multiRequest.getParameter("category");
		Timestamp eventStart = Timestamp.valueOf(multiRequest.getParameter("eventStart"));
		Timestamp eventEnd = Timestamp.valueOf(multiRequest.getParameter("eventEnd"));
		/*
		System.out.println("title => " + title);
		System.out.println("content => " + content);
		System.out.println("filename=>" + fileList.get(0).getOriginalFilename());*/
		String photoname = "";
		String originalPhotoName = "";
		//System.out.println("file갯수=>" + fileList.size());
		if(fileList != null) {
			String path = session.getServletContext().getRealPath("/photo");
			
			System.out.println(path);

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
		EventDTO dto = new EventDTO();
		dto.setTitle(title);
		dto.setContent(content);
		dto.setPhoto(photoname);
		dto.setCategory(category);
		dto.setEvent_start(eventStart);
		dto.setEvent_end(eventEnd);
		dto.setOriginal_photo(originalPhotoName);
		
		service.insertData(dto);
	}
	
	@GetMapping("/auth/updateform")
	public ModelAndView updateForm(
		@RequestParam String idx,
		Principal principal
		) 
	{
		ModelAndView mview = new ModelAndView();
		String userId = "no";
		String local = "";
		String[] localArr = {};
		if(principal != null) {
			userId = principal.getName();
			local = memberService.getLocal(principal);
			localArr = local.split(",");
		}
		EventDTO dto = service.getData(idx);
		String[] photoList = dto.getPhoto().split(",");

		mview.addObject("localCnt", localArr.length);
		mview.addObject("localArr", localArr);
		mview.addObject("dto", dto);
		mview.addObject("photoList", photoList);
		mview.setViewName("/event/updateForm");
		return mview;
	}
	
	@PostMapping("/auth/update")
	public @ResponseBody void updateData(
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
		String category = multiRequest.getParameter("category");
		Timestamp eventStart = Timestamp.valueOf(multiRequest.getParameter("eventStart"));
		Timestamp eventEnd = Timestamp.valueOf(multiRequest.getParameter("eventEnd"));
		
		
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
					String saveFileName = "Test" + random + "_" + originalFileName;
					String savePath = path + "\\" + saveFileName;
					fileList.get(i).transferTo(new File(savePath));		
					
					photoname += saveFileName + ",";
					originalPhotoName += originalFileName + ","; 
				}
				
				photoname = photoname.substring(0, photoname.length()-1);
				originalPhotoName = originalPhotoName.substring(0, originalPhotoName.length()-1);
			}
		}

		EventDTO dto = service.getData(idx);
		dto.setTitle(title);
		dto.setContent(content);
		dto.setPhoto(photoname);
		dto.setCategory(category);
		dto.setEvent_start(eventStart);
		dto.setEvent_end(eventEnd);
		dto.setOriginal_photo(originalPhotoName);
		
		service.updateData(dto);
	}
	
	@GetMapping("/auth/delete")
	public String deleteData(
		@RequestParam String idx,
		@RequestParam String currentPage
		) 
	{
		service.deleteData(idx);
		
		return "redirect:../list?currentPage=" + currentPage;
	}
	
	@PostMapping("/auth/reply/insert")
	public @ResponseBody void replyInsert(
		@ModelAttribute EventReplyDTO dto,
		@RequestParam String checkStep,
		Principal principal
		) 
	{
		dto.setId(principal.getName());
		if(checkStep.equals("no")) {
			dto.setRegroup(dto.getRegroup() + 1);
		}else {
			dto.setRestep(dto.getRestep() + 1);
			dto.setRelevel(dto.getRelevel() + 1);
		}
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
