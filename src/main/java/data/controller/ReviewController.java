package data.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ReviewController {
	
	@GetMapping("/review/insertForm")
	public String insertForm() {
		return "/review/insertForm";
	}
}
