package data.controller;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import data.dto.ProductDTO;
import data.service.MemberService;
import data.service.ProductService;

@Controller
@RequestMapping("/mypage")
public class MypageController {
	@Autowired
	MemberService memService;
	@Autowired
	ProductService pservice;
	
	@GetMapping("/detail")
	public String detail() {
		
		return "/mypage/detail";
	}
	
	@GetMapping("/updateform")
	public String update() {
		return "/mypage/test_updateForm";
	}
	
	@GetMapping("/profile_updateform")
	public String pupdate() {
		return "/mypage/profile_updateForm";
	}
	
	@GetMapping("/unregister")
	public String register() {
		return "/mypage/unregister_member";
	}
	
	@PostMapping("/auth/sell_list")
	public @ResponseBody ModelAndView sell_list
		(
		@RequestParam(defaultValue = "1") int currentPage,
		@RequestParam (defaultValue = "전체") String category,
		HttpServletRequest request,
		HttpServletResponse response,
		Model model,
		Principal principal) throws Exception
	{
		ModelAndView mview = new ModelAndView();
		
		//지역 가져오기
		String userId = "no";
		String local = "";
		String[] localArr = {};
		if(principal != null) {
			userId = principal.getName();
			local = memService.getLocal(principal);
			localArr = local.split(",");
		}
		mview.addObject("localCnt",localArr.length);
		mview.addObject("localArr",localArr);
		
		int totalCount = pservice.getTotalCount(category); 
		//페이징 처리에 필요한 변수
		int perPage = 15; 
		int totalPage;
		int start; 
		int perBlock=5; 
		int startPage; 
		int endPage;
		//총 페이지 갯수
		totalPage = totalCount/perPage + (totalCount%perPage==0?0:1);
		//각 블럭의 시작페이지
		startPage = (currentPage-1)/perBlock * perBlock +1; 
		//각 블럭 마지막페이지
		endPage = startPage + perBlock-1;
		if(endPage>totalPage){ endPage = totalPage; }
		//각 페이지에서 불러올 시작번호
		start = (currentPage-1) * perPage; 
		
		List<ProductDTO> list = pservice.getList(startPage, perPage, category, local);
		
		
		//request에서 getParameter로 kind 값을 불러오기
		String kind = request.getParameter("kind");
		
		//출력에 필요한 변수들을 request에 저장
		mview.addObject("list",list);
		mview.addObject("kind",kind);
		mview.addObject("startPage",startPage);
		mview.addObject("endPage",endPage);
		mview.addObject("totalPage",totalPage);
		mview.addObject("currentPage",currentPage);
		mview.addObject("totalCount",list.size());
		
		mview.setViewName("/mypage/sell_list");
		return mview;
	}
	
}
