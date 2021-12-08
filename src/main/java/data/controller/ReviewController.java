package data.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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
	
	@GetMapping("/insertForm")
	public ModelAndView insertForm(String nickname,Principal principal) {
		ModelAndView mview = new ModelAndView();
		
		String seller=principal.getName();
		System.out.println(seller);
		System.out.println(nickname);
		
		mview.addObject("seller", seller);
		mview.addObject("nickname", nickname);
		mview.setViewName("/review/insertForm");
		
		return mview;
		
		
		
		
	}
	
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
	public ModelAndView insert(@ModelAttribute ReviewDTO rdto,String nickname)
	{	
		ModelAndView mview = new ModelAndView();
		
		
	
		Rservice.ReviewInsert(rdto);
		
		
		mview.setViewName("/product/list");
		return mview; 
	}
	
	
	
	
}
