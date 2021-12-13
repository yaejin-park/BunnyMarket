 package data.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import data.service.MemberService;


@Controller
@RequestMapping("/intro")
public class IntroController {
	
	
	@Autowired
	MemberService Mservice;
	
	@GetMapping("/main")
	public ModelAndView intro(Principal principal )
	{	
		
		
		ModelAndView mview = new ModelAndView();
		
		//지역 가져오기
	      String userId = "no";
	      String local = "";
	      String[] localArr = {};
	      String currentLocal="";
	      
	      if(principal != null) {
	         userId = principal.getName();
	         local =Mservice.getLocal(principal);
	         currentLocal=Mservice.currentLocal(userId);
	         localArr = local.split(",");
	      }
	      mview.addObject("localCnt",localArr.length);
	      mview.addObject("localArr",localArr);
	      mview.addObject("curretLocal",currentLocal);
	      mview.setViewName("/intro/main");
	      
	      return mview;
	}

}
