package data.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import data.dto.FaqDTO;
import data.service.FaqService;
import data.service.MemberService;

@Controller
@RequestMapping("/faq")
public class FaqController {
	
	@Autowired
	MemberService memService;
	
	@Autowired
	FaqService service;
	
	@GetMapping("/list")
	public ModelAndView list(
			@RequestParam(defaultValue = "1") int currentPage, Principal principal) {
		ModelAndView mview = new ModelAndView();
		
		//지역 가져오기
		String userId = "no";
		String local = "";
		String[] localArr = {};
		String currentLocal = "";
		if(principal != null) {
			userId = principal.getName();
			local = memService.getLocal(principal);
			currentLocal = memService.currentLocal(userId);
			localArr = local.split(",");
		}
		mview.addObject("localCnt",localArr.length);
		mview.addObject("localArr",localArr);
		mview.addObject("currentLocal", currentLocal);
				
		int totalCount=service.getTotalCount();
		int perPage=10;
		int totalPage;
		int start;
		int perBlock=5;
		int startPage;
		int endPage;
		
		totalPage=totalCount/perPage+(totalCount%perPage == 0?0:1);
		startPage=(currentPage-1)/perBlock*perBlock+1;
		endPage=startPage+perBlock-1;
		
		if(endPage>totalPage) {
			endPage=totalPage;
		}
		
		String admin="no";
		if(principal != null) {
			admin=memService.currentUserType(principal);
		}
		
		mview.addObject("admin", admin);
		start=(currentPage-1)*perPage;
		List<FaqDTO> list = service.getList(start, perPage);
		System.out.println("1:"+list.size());
		int no=totalCount-(currentPage-1)*perPage;
		
		mview.addObject("list", list);
		mview.addObject("startPage", startPage);
		mview.addObject("endPage", endPage);
		mview.addObject("totalPage", totalPage);
		mview.addObject("no", no);
		mview.addObject("currentPage", currentPage);
		
		mview.addObject("totalCount", totalCount);
		mview.setViewName("/faq/list");
		
		return mview;
	}
	
	@GetMapping("/list_by_category")
	@ResponseBody
	public Map<String, Object> listByCategory(
			@RequestParam(defaultValue = "1") int currentPage, @RequestParam(defaultValue = "all") String category, Principal principal) {
		Map<String, Object> result = new HashMap<String, Object>();
		System.out.println("currentPage="+currentPage);
		int totalCount=service.getTotalCount();
		int perPage=10;
		int totalPage;
		int start;
		int perBlock=5;
		int startPage;
		int endPage;
		
		totalPage=totalCount/perPage+(totalCount%perPage == 0?0:1);
		startPage=(currentPage-1)/perBlock*perBlock+1;
		endPage=startPage+perBlock-1;
		
		if(endPage>totalPage) {
			endPage=totalPage;
		}
		
		start=(currentPage-1)*perPage;
		List<FaqDTO> list = service.getListByCategory(category, start, perPage);
		System.out.println("size:"+list.size());
		int no=totalCount-(currentPage-1)*perPage;
		
		String admin="no";
		if(principal != null) {
			admin=memService.currentUserType(principal);
		}
		
		result.put("admin", admin);	
		
		result.put("list", list);
		result.put("category", category);
		result.put("startPage", startPage);
		result.put("endPage", endPage);
		result.put("totalPage", totalPage);
		result.put("no", no);
		result.put("currentPage", currentPage);
		result.put("totalCount", totalCount);

		return result;
	}

	
	
	@GetMapping("/insertform")
	public String wiriteform() {
		return "/faq/insertform";
	}
	
	@GetMapping("/updateform")
	public ModelAndView updateform(String idx, String currentPage, Principal principal) {
		ModelAndView mview=new ModelAndView();
		
		//지역 가져오기
		String userId = "no";
		String local = "";
		String[] localArr = {};
		String currentLocal = "";
		if(principal != null) {
			userId = principal.getName();
			local = memService.getLocal(principal);
			currentLocal = memService.currentLocal(userId);
			localArr = local.split(",");
		}
		mview.addObject("localCnt",localArr.length);
		mview.addObject("localArr",localArr);
		mview.addObject("currentLocal", currentLocal);
		
		FaqDTO dto=service.getData(idx);
		mview.addObject("dto", dto);
		mview.addObject("currnetPage", currentPage);
		mview.setViewName("/faq/updateform");
		return mview;
	}
	
	@PostMapping("/insert") 
	public String insert(@ModelAttribute FaqDTO dto) {
		service.insertFaq(dto);
		return "redirect:list";
	}
	
	@PostMapping("/update")
	public String update(@ModelAttribute FaqDTO dto,
			String currentPage, HttpSession session) {
		service.updateFaq(dto);
		return "redirect:list?idx="+dto.getIdx()+"&currentPage="+currentPage;
	}
	@GetMapping("/faqdelete")
	@ResponseBody
	public Map<String, Object> deleteFaq(String idx) {
		Map<String, Object> result = new HashMap<String, Object>();
		service.deleteFaq(idx);
		result.put("success", true);

		return result;
	}
}
