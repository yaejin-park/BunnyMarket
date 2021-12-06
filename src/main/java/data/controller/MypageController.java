package data.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("mypage")
public class MypageController {
	
	

	@GetMapping("/my")
	public String writeform() {
		return "/mypage/test";
	}

}
