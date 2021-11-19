package data.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import data.dto.ProductDTO;
import data.service.ProductService;

@Controller
@RequestMapping("/product")
public class ProductController {
	@Autowired
	ProductService service;
	
	/*
	 * @GetMapping("/product/list") public ModelAndView productList(@RequestParam
	 * String start,@RequestParam String perpage) { ModelAndView mview = new
	 * ModelAndView();
	 * 
	 * ProductDTO dto = service.getList(start, perpage);
	 * 
	 * mview.addObject("dto", dto); mview.setViewName("/product/list");
	 * 
	 * return mview; 
	 * }
	 */
	
	
	@GetMapping("/detail")
	public ModelAndView productDetail(@RequestParam String idx) {
		ModelAndView mview = new ModelAndView();
		ProductDTO dto =  service.getData(idx);
		
		mview.addObject("dto", dto);
		mview.setViewName("/product/detail");
		
		return mview;
	}
	 
}


