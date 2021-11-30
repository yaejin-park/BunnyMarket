package data.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

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
import data.dto.CommunityDTO;
import data.mapper.CommunityMapper;
import data.service.CommunityService;

@Controller
@RequestMapping("/community")
public class CommunityController {

	@Autowired
	CommunityService service;

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
		//int no = totalCount-(currentPage-1)*perPage;
		start = (currentPage-1) * perPage; 
		
		//list에 각 글에 대한 작성자 추가해야함

		
		List<CommunityDTO> list= service.getList(start, perPage);

		mview.addObject("commulist", list); 
		mview.addObject("startPage",startPage);
		mview.addObject("endPage",endPage);
		mview.addObject("totalPage",totalPage);
		//mview.addObject("no",no);
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
			@RequestParam(defaultValue = "1") int currentPage,
			@RequestParam(required = false) String key
			)
	{
		ModelAndView mview = new ModelAndView();

		if(key!=null)
			service.updateReadCount(idx);

		CommunityDTO dto = service.getData(idx);
		String []photo = dto.getPhoto().split(",");

		mview.addObject("dto",dto);
		mview.addObject("photo",photo);
		mview.addObject("currentPage",currentPage);
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
	
	
	
	
	
}















