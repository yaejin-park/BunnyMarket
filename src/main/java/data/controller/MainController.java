package data.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import data.mapper.MainMapper;

@Controller
public class MainController {
	@Autowired
	MainMapper mapper;
	
	@GetMapping("/")
	public String home() {
		return "/main/layout/main";
	}
	
	@GetMapping("/sub")
	public String sub() {
		return "/layout/content";
	}
}
