package data.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import data.service.FollowService;

@Controller
public class FollowController {
	@Autowired
	FollowService service;
	
	@ResponseBody
	@PostMapping("/follow")
	public void insertFollow(@RequestParam String followee, @RequestParam String follower) {
		service.insertFollow(followee, follower);
	}
	
	@ResponseBody
	@PostMapping("/unfollow")
	public void deleteFollow(@RequestParam String followee, @RequestParam String follower) {
		service.deleteFollow(followee, follower);
	}
	
	
}
