package data.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import data.mapper.FollowMapper;


@Service
public class FollowService {
	@Autowired
	FollowMapper mapper;
	
	public int followCheck(@RequestParam String followee, @RequestParam String follower) {
		return mapper.followCheck(followee, follower);
	}
	
	public void insertFollow(@RequestParam String followee, @RequestParam String follower) {
		mapper.insertFollow(followee, follower);
	}
	
	public void deleteFollow(@RequestParam String followee, @RequestParam String follower) {
		mapper.deleteFollow(followee, follower);
	}
}
