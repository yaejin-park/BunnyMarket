package data.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AdvertiseController {
	
	@GetMapping("/advertise/list")
	public ModelAndView list() {
		ModelAndView mview=new ModelAndView();
		//mview.addObject("list", list);
		mview.setViewName("/advertise/list");
		return mview;
	}
	
	@GetMapping("/advertise/form")
	public String from() {
		return "/advertise/writeForm";
	}
}
