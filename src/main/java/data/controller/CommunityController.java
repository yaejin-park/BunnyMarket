package data.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
	
	@GetMapping("/wform")
	public String form()
	{
		return "/community/writeform";
	}
	
	@PostMapping("/insert")
	public String insert()
	{
		return "redirect:content";
	}
	
	@GetMapping("/content")
	public ModelAndView content()
	{
		ModelAndView mview = new ModelAndView();
		
		
		return mview;
	}
}















