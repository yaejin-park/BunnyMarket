package data.controller;

import java.security.Principal;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import data.service.MemberService;

@Controller
@RequestMapping("/local")
public class LocalController {
	@Autowired
	MemberService memberService;
	
	@GetMapping("/auth/add")
	public ModelAndView addLocal(
		Principal principal
		) 
	{
		ModelAndView mview = new ModelAndView();
		String userId = "no";
		if(principal != null) {
			userId = principal.getName();
		}
		String local = memberService.getLocal(principal);
		String[] localArr = local.split(",");
		
		mview.addObject("localCnt", localArr.length);
		mview.addObject("localArr", localArr);
		mview.setViewName("/local/addLocal");
		return mview;
	}
	
	@PostMapping("/auth/update")
	public @ResponseBody void updateLocal(
		@RequestParam String local,
		Principal principal
		) 
	{
		HashMap<String, String> map = new HashMap<String, String>();
		String userId = principal.getName();
		map.put("id", userId);
		map.put("local", local);
		
		System.out.println(local);
		memberService.updateLocal(map);
	}
}
