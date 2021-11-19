package data.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;


import data.mapper.CommunityMapper;
import data.service.CommunityService;

@Controller
public class CommunityController {

	@Autowired
	CommunityService service;
	
	@Autowired
	CommunityMapper mapper;
	
	@GetMapping("/community/list")
	public ModelAndView list()
	{
		ModelAndView mview = new ModelAndView();
		
		
		return mview;
	}
	
	@GetMapping("/community/wform")
	public String form()
	{
		return "/community/writeform";
	}
	
	@PostMapping("/community/insert")
	public String insert()
	{
		return "redirect:content";
	}
	
	@GetMapping("/community/content")
	public ModelAndView content()
	{
		ModelAndView mview = new ModelAndView();
		
		
		return mview;
	}
}















