package data.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import data.dto.ProductDTO;
import data.service.ProductLikeService;

@Controller
@RequestMapping("/auth")
public class ProductLikeController {
	@Autowired
	ProductLikeService service;

	
	@GetMapping("/productlike/list")
	public ModelAndView productLikeList(
			@RequestParam (defaultValue = "1") int currentPage, HttpSession session) { 
	ModelAndView mview = new ModelAndView();
	
    String id = (String)session.getAttribute("myid");
	int totalCount = service.getTotalCount(id);
	
	//페이징 처리에 필요한 변수 선언
	int perPage = 20;
	int totalPage;
	int start;
	int perBlock = 5;
	int startPage;
	int endPage;
	
	//총 페이지 갯수 구하기
	totalPage = totalCount/perPage+(totalCount%perPage==0?0:1);
	//각 블럭의 시작 페이지
	startPage = (currentPage-1)/perBlock*perBlock +1;
	//각 블럭의 마지막 페이지
	endPage = startPage + perBlock -1;
	
	if(endPage > totalPage) {
		endPage = totalPage;
	}
	
	//각 페이지에서 불러올 시작번호
	start = (currentPage-1)*perPage;
	
	List<ProductDTO> list = service.getList(start, perPage, id);
	
	//각 페이지에 출력할 시작번호
	int no = totalCount-(currentPage-1)*perPage;
	
	//출력에 필요한 변수들을 request에 저장
	mview.addObject("list",list);
	mview.addObject("startPage", startPage);
	mview.addObject("endPage", endPage);
	mview.addObject("totalPage", totalPage);
	mview.addObject("no", no);
	mview.addObject("currentPage", currentPage);
	mview.addObject("totalCount", totalCount);
	
	mview.setViewName("/productlike/list");
		  
	return mview; 
	}
	 

}
