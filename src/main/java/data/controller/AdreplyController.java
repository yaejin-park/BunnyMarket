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

import data.dto.AdreplyDTO;
import data.service.AdreplyService;

@Controller
@RequestMapping("/advertise")
public class AdreplyController {
	@Autowired
	AdreplyService service;
	
//	@GetMapping("/detail")
//	public ModelAndView form(
//			@RequestParam Map<String, String> map
//			) {
//		ModelAndView mview=new ModelAndView();
//		
//		String idx=map.get("idx");
//		String regroup=map.get("regroup");
//		String restep=map.get("restep");
//		String relevel=map.get("relevel");
//		
//		mview.addObject("idx", idx==null?"0":idx);
//		mview.addObject("regroup", regroup==null?"0":regroup);
//		mview.addObject("restep", restep==null?"0":restep);
//		mview.addObject("relevel", relevel==null?"0":relevel);
//		
//		mview.setViewName("/advertise/detail");
//		return mview;
//	}
	
	@PostMapping("/reinsert")
	public String insert(@ModelAttribute AdreplyDTO dto, HttpSession session) {
		//세션에 로그인한 아이디 얻기

		//아이디에 대한 작성자 얻기
		
		//dto에 넣기
		
		
		//insert
		service.insertReply(dto);
		return "/relist";
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
	public void delete(int idx) {
		service.deleteReply(idx);
	}
}
