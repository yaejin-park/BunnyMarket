package data.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
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
	public ModelAndView list()
	{
		ModelAndView mview = new ModelAndView();
		
		 List<CommunityDTO> list= service.getAllDatas();
		  
		 mview.addObject("commulist", list);
		
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
			@RequestParam MultipartFile upload,
			HttpSession session)
	{
		String path=session.getServletContext().getRealPath("/photo");
		System.out.println(path);
		
		UUID uuid = UUID.randomUUID();
		String photoname= uuid.toString()+"_"+upload.getOriginalFilename();
		dto.setPhoto(photoname);
		
		try {
			upload.transferTo(new File(path+"\\"+photoname));
			
			
		} catch (IllegalStateException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		mapper.insert(dto);
		return "redirect:content";
	}
	
	@GetMapping("/content")
	public ModelAndView content()
	{
		ModelAndView mview = new ModelAndView();
		
		
		return mview;
	}
}















