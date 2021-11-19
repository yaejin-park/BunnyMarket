package data.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	
	@GetMapping("/list")
	public String notice()
	{
		return "/notice/list";
	}

	
	@GetMapping("/writeform")
	public String writeform()
	{
		return "/notice/writeform";
	}
	
	@GetMapping("/content")
	public String content()
	{
		return "/notice/content";
	}
	
	@GetMapping("/update")
	public String update()
	{
		return "/notice/updateform";
	}
	

}
