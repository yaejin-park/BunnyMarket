package data.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import data.dto.ProductDTO;
import data.service.MemberService;
import data.service.ProductService;

@Controller
public class MainController {
	@Autowired
	MemberService memberService;
	
	@Autowired
	ProductService productService;
	
	@GetMapping({"/", "/index"})
	public ModelAndView home(
		Principal principal
		) 
	{
		ModelAndView mview = new ModelAndView();
		String userId = "no";
		String local ="";
		String[] localArr = {};
		String currentLocal = "";
		if(principal != null) {
			userId = principal.getName();
			local = memberService.getLocal(principal);
			currentLocal = memberService.currentLocal(userId);
			localArr = local.split(",");
		}
		
		List<ProductDTO> productList = productService.getMainList();
				
		mview.addObject("localCnt", localArr.length);
		mview.addObject("localArr", localArr);
		mview.addObject("productList", productList);
		mview.addObject("productCnt", productList.size());
		mview.addObject("currentLocal", currentLocal);
		mview.setViewName("/layout/main");
		return mview;
	}
	
	@GetMapping("/sub")
	public String sub() {
		return "/layout/content";
	}
}
