package data.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import data.service.MemberService;

@Controller
@RequestMapping("/term")
public class TermController {
	@Autowired
	MemberService memService;
	
	@GetMapping("/use")
	public ModelAndView use(Principal principal) {
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
		
		mview.setViewName("/term/use");
		return mview;
	}
	
	@GetMapping("/privacy")
	public ModelAndView privacy(Principal principal) {
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
		
		mview.setViewName("/term/privacy");
		return mview;
	}
	
	@GetMapping("/location")
	public ModelAndView location(Principal principal) {
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
		
		mview.setViewName("/term/location");
		return mview;
	}
}
