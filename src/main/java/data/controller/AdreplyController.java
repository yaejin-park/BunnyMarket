package data.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import data.dto.AdreplyDTO;
import data.service.AdreplyService;

@Controller
@RequestMapping("/advertise")
public class AdreplyController {
	@Autowired
	AdreplyService service;
	
	@GetMapping("/reply")
	public ModelAndView detail(@RequestParam Map<String, String> map) {
		ModelAndView mview=new ModelAndView();
	
		//댓글
		String currentPage=map.get("currentPage");
		String idx=map.get("idx");
		String regroup=map.get("regroup");
		String restep=map.get("restep");
		String relevel=map.get("relevel");
		
		mview.addObject("currentPage", currentPage==null?"1":currentPage);
		mview.addObject("idx", idx==null?"0":idx);
		mview.addObject("regroup", regroup==null?"0":regroup);
		mview.addObject("restep", restep==null?"0":restep);
		mview.addObject("relevel", relevel==null?"0":relevel);
		
		mview.setViewName("/advertise/detail");
		return mview;
	}
	
	@PostMapping("/auth/reinsert")
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
	
	@PostMapping("/auth/reupdate")
	public void aupdate(@ModelAttribute AdreplyDTO dto) {
		service.updateReply(dto);
	}
	
	@GetMapping("/auth/redelete")
	public void delete(@RequestParam int idx) {
		System.out.println(idx);
		service.deleteReply(idx);
	}
}
