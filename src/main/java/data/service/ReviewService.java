package data.service;



import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public int getTotalCount() {
		return rmapper.getTotalCount();
	}
	public List<ReviewDTO> getMyReviewList(String start,String perpage,String reviewer){
		HashMap<String , String> map = new HashMap<String, String>();
		map.put("start", start);
		map.put("perpage", perpage);
		map.put("reviewer", reviewer);
		
		return rmapper.getMyReviewList(map);
	}
	public List<ReviewDTO> getOtherReviewList(String start,String perpage,String reviewee){
		HashMap<String , String> map = new HashMap<String, String>();
		map.put("start", start);
		map.put("perpage", perpage);
		map.put("reviewee", reviewee);
		
		return rmapper.getOtherReviewList(map);
	}
}
