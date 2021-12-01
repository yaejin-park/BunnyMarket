package data.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/find")
public class FindMemberController {
	
	@GetMapping("/idform")
	public String getIdForm() {
		return "/findMember/idForm";
	}
	
	@GetMapping("/pwform")
	public String getPwForm() {
		return "/findMember/pwForm";
	}
}
