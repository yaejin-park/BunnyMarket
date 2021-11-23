package data.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

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
			@RequestParam(defaultValue = "1") int currentPage,
			@RequestParam String idx
			)
	{
		ModelAndView mview = new ModelAndView();
		
		CommunityDTO dto = mapper.getData(idx);
		String []photo = dto.getPhoto().split(",");
		dto.setPhoto(photo[0]);
		
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
		if(endPage>totalPage)
			endPage = totalPage;
		
		start = (currentPage-1) * perPage;
		List<CommunityDTO> paging=service.getList(start, perPage);
		
		//list에 각 글에 대한 작성자 추가해야함
		
		int no=totalCount-(currentPage-1)*perPage;
		
		List<CommunityDTO> list= service.getAllDatas();
		 
		
		 mview.addObject("commulist", list);
		 mview.addObject("dto",dto);
		 mview.addObject("startPage",startPage);
		 mview.addObject("endPage",endPage);
		 mview.addObject("totalPage",totalPage);
		 mview.addObject("no",no);
		 mview.addObject("currentPage",currentPage);
		 mview.addObject("totalCount",totalCount);
		 
		 mview.setViewName("/community/list");
		 return mview;
	}
	
	@GetMapping("/writeform")
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
		for(MultipartFile f:upload) {
			if(f.getOriginalFilename().equals("")) {
				dto.setPhoto("no");
			}else {
				UUID uuid = UUID.randomUUID();
				String photo= uuid.toString() + "_" +f.getOriginalFilename();
				
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
		}
		
		//콤마 제거하기
		fileadd += fileadd.substring(0,fileadd.length()-1);
		dto.setPhoto(fileadd);
		
		service.insert(dto);
		return "redirect:list";
		//return "redirect:content?num="+service.getMaxNum();
	}
	
	
	@GetMapping("/content")
	public ModelAndView content()
	{
		ModelAndView mview = new ModelAndView();
		
		
		return mview;
	}
}















