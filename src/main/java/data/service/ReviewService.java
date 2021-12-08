package data.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import data.mapper.ReviewMapper;

@Service
public class ReviewService {
	
	@Autowired
	ReviewMapper rmapper;
	
	
	public List<String> getTime(String id)
	{
		return rmapper.getTime(id);
	}

}
