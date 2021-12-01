package data.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import data.dto.MemberDTO;
import data.mapper.MemberMapper;
import data.service.MemberService;

@Controller
@RequestMapping("/find")
public class FindMemberController {
	@Autowired
	MemberService memberService;
	
	@GetMapping("/idform")
	public String getIdForm() {
		return "/findMember/idForm";
	}
	
	@GetMapping("/pwform")
	public String getPwForm() {
		return "/findMember/pwForm";
	}
	
	@PostMapping("/checkid")
	public String checkId(
			@ModelAttribute MemberDTO dto
			) 
	{
		HashMap<String, String> map = new HashMap<String, String>();
		String name = dto.getName();
		String hp = dto.getHp();
		map.put("name", name);
		map.put("hp", hp);
		
		String id = memberService.getIdFindMember(map);
		System.out.println(id);
		
		return id;
	}
}
