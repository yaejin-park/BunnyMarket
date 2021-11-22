package data.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {
	@GetMapping("/")
	public String home() {
<<<<<<< HEAD
		return "/layout/main";
=======
		return "/main/layout/main";
>>>>>>> jmk
	}
	
	@GetMapping("/sub")
	public String sub() {
		return "/layout/content";
	}
}
