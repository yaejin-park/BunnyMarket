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
@RequestMapping("/product_like")
public class ProductLikeController {
	@Autowired
	ProductLikeService service;

	
	@GetMapping("/list")
	public ModelAndView productLikeList(
			@RequestParam (defaultValue = "1") int currentPage, HttpSession session) { 
	ModelAndView mview = new ModelAndView();
	

	
	//페이징 처리에 필요한 변수 선언
	int perPage = 20;
	int totalPage;
	int start;
	int perBlock = 5;
	int startPage;
	int endPage;
	
	//각 블럭의 시작 페이지
	startPage = (currentPage-1)/perBlock*perBlock +1;
	//각 블럭의 마지막 페이지
	endPage = startPage + perBlock -1;
	
	

	}
	 

}
