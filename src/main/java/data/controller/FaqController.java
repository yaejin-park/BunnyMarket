package data.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/faq")
public class FaqController {
	
	@GetMapping("/list")
	public String list() {
		return "/faq/list";
	}
	@GetMapping("/writeform")
	public String writeform() {
		return "/faq/writeForm";
	}
	@GetMapping("/updateform")
	public String updateform() {
		return "/faq/updateForm";
	}
}
