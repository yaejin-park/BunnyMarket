package data.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/term")
public class TermController {
	
	@GetMapping("/use")
	public String use() {
		return "/term/use";
	}
	
	@GetMapping("/privacy")
	public String privacy() {
		return "/term/privacy";
	}
	
	@GetMapping("/location")
	public String location() {
		return "/term/location";
	}
}
