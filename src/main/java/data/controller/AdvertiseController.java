package data.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/advertise")
public class AdvertiseController {
	
	@GetMapping("/list")
	public ModelAndView list() {
		ModelAndView mview=new ModelAndView();
		
		mview.setViewName("/advertise/list");
		return mview;
	}
	
	@GetMapping("/form")
	public String from() {
		return "/advertise/writeForm";
	}
	
	@PostMapping("/insert")
	public String insert() {
		return "redirect:detail?num=";
	}
	
	@GetMapping("/updateform")
	public ModelAndView updateForm() {
		ModelAndView mview=new ModelAndView();
		mview.setViewName("/updateForm");
		return mview;
	}
	
	@PostMapping("/update")
	public String update() {
		return "redirect:detail?num=";
	}
	
	@GetMapping("/delete")
	public String delete() {
		return "redirect:list?currentPage=";
	}
}
