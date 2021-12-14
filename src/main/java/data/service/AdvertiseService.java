package data.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import data.dto.AdreplyDTO;
import data.dto.AdvertiseDTO;
import data.dto.EventReplyDTO;
import data.mapper.AdvertiseMapper;

@Service
public class AdvertiseService {
	@Autowired
	AdvertiseMapper mapper;
	
	public int getTotalCount(@RequestParam String keyword,
			@RequestParam String location) {
		return mapper.getTotalCount(keyword, location);
	}
	
	//목록
	public List<AdvertiseDTO> getList(
			@RequestParam int start,
			@RequestParam int perpage,
			@RequestParam String keyword,
			@RequestParam String location) {
		HashMap<String, Object> map=new HashMap<String, Object>();
		map.put("start", start);
		map.put("perpage", perpage);
		map.put("keyword", keyword);
		map.put("location", location);
		
		return mapper.getList(map);
	}
	
	//조회수
	public void updateReadCount(String idx) {
		mapper.updateReadCount(idx);
	}
	
	public AdvertiseDTO getData(String idx) {
		return mapper.getData(idx);
	}
	public int getMaxIdx() {
		return mapper.getMaxIdx();
	}
	
	//insert
	public void insertAdvertise(AdvertiseDTO dto) {
		mapper.insertAdvertise(dto);
	}
	//update
	public void updateAdvertise(AdvertiseDTO dto) {
		mapper.updateAdvertise(dto);
	}
	//delete
	public void deleteAdvertise(String idx) {
		mapper.deleteAdvertise(idx);
	}
	
	//reply
	public void insertReplyData(AdreplyDTO dto) {
		mapper.insertReplyData(dto);
	}
	public void updateReplyStep(int restep, int regroup) {
		mapper.updateReplyStep(restep, regroup);
	}
	public List<AdreplyDTO> getReplyList(String idx) {
		return mapper.getReplyList(idx);
	}
	public String getMaxReply(String idx) {
		return mapper.getMaxReply(idx);
	}
	public void deleteReply(int idx) {
		mapper.deleteReply(idx);
	}
}
