package data.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import data.dto.AdreplyDTO;
import data.service.AdreplyService;

@Controller
@RequestMapping("/advertise")
public class AdreplyController {
	@Autowired
	AdreplyService service;	
	
	@PostMapping("/reinsert")
	public String insert(@ModelAttribute AdreplyDTO dto, HttpSession session,
			@RequestParam(value = "currentPage", required = false) String currentPage) {
		//세션에 로그인한 아이디 얻기

		//아이디에 대한 작성자 얻기
		
		//dto에 넣기
		
		//insert
		service.insertReply(dto);
		return "redirect:detail?idx="+dto.getNum()+"&currentPage="+currentPage;
	}
	
	@GetMapping("/relist")
	public List<AdreplyDTO> relist(int num) {
		return service.getReplyList(num);
	}
	
	@GetMapping("/redata")
	public AdreplyDTO data(int idx) {
		return service.getReply(idx);
	}
	
	@PostMapping("/reupdate")
	public void aupdate(@ModelAttribute AdreplyDTO dto) {
		service.updateReply(dto);
	}
	
	@GetMapping("/redelete")
	public @ResponseBody String delete(@RequestParam int idx) {
		System.out.println(idx);
		service.deleteReply(idx);
		return "delete";
	}
}
