package data.service;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import data.dto.ChatDTO;
import data.dto.ReviewDTO;
import data.mapper.ReviewMapper;

@Service
public class ReviewService {

	@Autowired
	ReviewMapper rmapper;



	public List<ChatDTO> getList(String idx) {
		return rmapper.getList(idx);
	}
	
	public void ReviewInsert(ReviewDTO rdto) {
		rmapper.ReviewInsert(rdto);
	}
	
	public int getCount(String id) {
		return rmapper.getCount(id);
	}
}
