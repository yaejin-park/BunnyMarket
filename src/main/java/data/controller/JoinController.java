package data.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller()
@RequestMapping("/join")
public class JoinController {
	@GetMapping("/main")
	public String login() {
		return "/join/joinForm";
	}	
}
