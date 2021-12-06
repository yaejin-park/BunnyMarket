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
			@RequestParam(defaultValue = "1") int currentPage
			)
	{
		ModelAndView mview = new ModelAndView();

		
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
		
			
		//페이징
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

	@GetMapping("/insertform")
	public String form()
	{
		return "/community/writeForm";
	}

	
	@PostMapping("/insert")
	   public String insert(@ModelAttribute CommunityDTO dto,
	         @RequestParam ArrayList<MultipartFile> upload,
	         HttpSession session)
	   {
	      //업로드할 폴더 지정
	      String path=session.getServletContext().getRealPath("/photo");
	      String fileadd="";
	      System.out.println(path);


	      //업로드 안한경우
	      ArrayList<String> fileArr = new ArrayList<String>();
	      if(upload.get(0).getOriginalFilename().equals(""))
	         dto.setPhoto("no");
	      else {
	         String photo="";
	         for(MultipartFile f:upload) {

	            UUID uuid = UUID.randomUUID();
	            photo= uuid.toString() + "_" +f.getOriginalFilename();

	            //실제로 업로드한다
	            try {
	               f.transferTo(new File(path+"\\"+photo));
	            } catch (IllegalStateException | IOException e) {
	               // TODO Auto-generated catch block
	               e.printStackTrace();
	            }

	            //콤마 넣기
	            fileadd+=photo+",";
	         }
	         //콤마 제거하기
	         fileadd = fileadd.substring(0,fileadd.length()-1);
	         dto.setPhoto(fileadd);
	      }

	      service.insert(dto);
	      return "redirect:list";
	      //return "redirect:content?idx="+service.getMaxNum();
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
			@RequestParam String currentPage
			) 
	{
		ModelAndView mview = new ModelAndView();
		CommunityDTO dto = service.getData(idx);
		
		mview.addObject("dto",dto);
		mview.addObject("currentPage",currentPage);
		mview.setViewName("/community/updateForm");
		return mview;
	}
	
	@PostMapping("/update")
	public String update(
			@ModelAttribute CommunityDTO dto,
			@RequestParam ArrayList<MultipartFile> upload,
			@RequestParam String currentPage,
			HttpSession session
			)
	{
		//업로드 폴더지정
		String path=session.getServletContext().getRealPath("/photo");
		String fileadd="";
		
		//업로드 안한경우
				ArrayList<String> fileArr = new ArrayList<String>();
				if(upload.get(0).getOriginalFilename().equals(""))
					dto.setPhoto("no");
				else {
					String photo="";
					for(MultipartFile f:upload) {

						UUID uuid = UUID.randomUUID();
						photo= uuid.toString() + "_" +f.getOriginalFilename();

						//실제로 업로드한다
						try {
							f.transferTo(new File(path+"\\"+photo));
						} catch (IllegalStateException | IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}

						//콤마 넣기
						fileadd+=photo+",";
					}
					//콤마 제거하기
					fileadd = fileadd.substring(0,fileadd.length()-1);
					dto.setPhoto(fileadd);
				}
		
		//수정
		service.update(dto);
		
		return "redirect:detail?idx="+dto.getIdx()+"&currentPage="+currentPage;
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















