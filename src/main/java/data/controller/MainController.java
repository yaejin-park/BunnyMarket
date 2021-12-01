package data.controller;

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {
	@GetMapping({"/", "/index"})
	public String home() {
		return "/layout/main";
	}
	
	@GetMapping("/sub")
	public String sub() {
		return "/layout/content";
	}
}
