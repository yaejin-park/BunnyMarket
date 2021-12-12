package data.service;



import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import data.dto.ChatDTO;
import data.mapper.ReviewMapper;

@Service
public class ReviewService {

	@Autowired
	ReviewMapper rmapper;

	
	public List<ChatDTO> getList(String idx) {
		return rmapper.getList(idx);
	}
	
	public void ReviewInsert(Map<String, String> map) {
		rmapper.ReviewInsert(map);
	}
	
	public int getCount(String id) {
		return rmapper.getCount(id);
	}
	
	public int checkWrite(String id, String idx) {
		return rmapper.checkWrite(id, idx);
	}
	
	public int checkReviewee(String id, String idx) {
		return rmapper.checkReviewee(id, idx);
	}
}
