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
import data.service.AdreplyService;
import data.service.AdvertiseService;
import data.service.MemberService;

@Controller
@RequestMapping("/advertise")
public class AdvertiseController {
	@Autowired
	AdvertiseService service;
	
	@Autowired
	AdreplyService reService;
	
	@Autowired
	MemberService memService;
	
	@GetMapping("/list")
	public ModelAndView list(@RequestParam(defaultValue = "1") int currentPage,
			Principal principal) {
		ModelAndView mview=new ModelAndView();
		
		//지역가져올라면...
		String userId="no";
		if(principal != null) {
			userId=principal.getName();
		}
		
		String local=memService.getLocal(principal);
		String []localArr=local.split(",");
		
		mview.addObject("localCnt", localArr.length);
		mview.addObject("localArr", localArr);
		
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
		//return "redirect:/advertise/detail?idx="+service.getMaxIdx();
		//return "/advertise/list";
	}
	
	@GetMapping("/detail")
	public ModelAndView detail(@RequestParam String idx,
				@RequestParam(defaultValue = "1") int currentPage,
				@RequestParam(required = false) String key,
				@RequestParam Map<String, String> map,
				HttpServletRequest request, Principal principal) {
		ModelAndView mview=new ModelAndView();
		
		//조회수 증가
		if(key!=null) {
			service.updateReadCount(idx);
		}
		
		AdvertiseDTO dto=service.getData(idx);
		
		//닉네임 가져오기
		String nick = memService.getNick(dto.getId());
		
		//로그인 체크
		String isLogin="N";
		isLogin=(String)request.getSession().getAttribute("isLogin");
		
		//로그인 되어 있을 경우,
		if(isLogin!=null) {
			//로그인 아이디 가져오기
			String id = principal.getName();
			mview.addObject("myId", id);

			//공감
		}
		
		mview.addObject("dto", dto);
		mview.addObject("currentPage", currentPage);
		mview.addObject("isLogin", isLogin);
		mview.addObject("nick", nick);
		//이미지
		String []dbimg=dto.getPhoto().split(",");
		mview.addObject("dbimg", dbimg);
		
		//댓글관련
		List<AdreplyDTO> relist=reService.getReplyList(Integer.parseInt(idx));
		mview.addObject("recount", relist.size());
		mview.addObject("relist", relist);
		
		mview.setViewName("/advertise/detail");
		return mview;
	}
	
	@GetMapping("/auth/updateform")
	public ModelAndView updateForm(@RequestParam String idx,
				@RequestParam(defaultValue = "1") int currentPage) {
		ModelAndView mview=new ModelAndView();
		AdvertiseDTO dto=service.getData(idx);
		
		mview.addObject("dto", dto);
		mview.addObject("currentPage", currentPage);
		//이미지
		String []dbimg=dto.getPhoto().split(",");
		mview.addObject("dbimg", dbimg);
		
		mview.setViewName("/advertise/updateForm");
		return mview;
	}
	
	@PostMapping("/auth/update")
	public @ResponseBody void update(@ModelAttribute AdvertiseDTO dto, 
				HttpSession session, 
				HttpServletRequest request, 
				Principal principal,
				MultipartHttpServletRequest multiRequest,
				@RequestParam List<MultipartFile> photoupload,
				@RequestParam(defaultValue = "1") int currentPage) throws Exception {
		
		//로그인중이 아닐 경우 종료
		String isLogin=(String)request.getSession().getAttribute("isLogin");
		if(isLogin==null) {
			return;
		}
				
		//uuid 생성
		UUID uuid=UUID.randomUUID();

		photoupload = dto.getPhotoupload(); 
		String title=multiRequest.getParameter("title");
		String content=multiRequest.getParameter("contetn");

		String path=session.getServletContext().getRealPath("/photo");
		//이미지 업로드 안했을때
		if(photoupload.get(0).getOriginalFilename().equals("")) {
			dto.setPhoto("no");
		}else {	//이미지 업로드 했을때
			//이전 사진 삭제
			String ufile=service.getData(dto.getIdx()).getPhoto();
			File file=new File(path+"\\"+ufile);
			file.delete();
			
			//이미지 업로드 폴더 지정
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
		
		//update
		service.updateAdvertise(dto);
		//return "redirect:/advertise/detail?idx="+dto.getIdx()+"&currentPage="+currentPage;
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
}
