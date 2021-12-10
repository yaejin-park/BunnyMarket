package data.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import data.dto.ChatDTO;
import data.dto.ProductDTO;
import data.dto.ReviewDTO;
import data.service.MemberService;
import data.service.ReviewService;

@Controller
@RequestMapping("/review")
public class ReviewController {
	
	

	
	@Autowired 
	ReviewService Rservice;
	
	@Autowired
	MemberService Mservice;
	

	
	@GetMapping("/choose")
	public ModelAndView choose(Principal principal,@ModelAttribute ProductDTO pdto,String idx) {
		ModelAndView mview = new ModelAndView();
		
	
		List<ChatDTO> list=Rservice.getList(idx);
		
		
		mview.addObject("idx", idx);
		mview.addObject("list", list);
		mview.setViewName("/review/choose");
		
		
		return mview;
		
	}
	
	@PostMapping("/insert")
	public ModelAndView insert(@ModelAttribute ReviewDTO rdto)
	{	
		ModelAndView mview = new ModelAndView();
		
		
	
		Rservice.ReviewInsert(rdto);
		mview.setViewName("/product/list");
		return mview; 
	}
	
	@GetMapping("/insertForm")
	public ModelAndView insertForm(@RequestParam("nickname") String nickname,@RequestParam("id") String id,Principal principal) {
		ModelAndView mview = new ModelAndView();
		
		String seller=principal.getName();
		
		
		
		mview.addObject("nickname", nickname);
		mview.addObject("id", id);
		mview.addObject("seller", seller);
		mview.setViewName("/review/insertForm");
		
		return mview;
		
		
		
		
	}
	

}
