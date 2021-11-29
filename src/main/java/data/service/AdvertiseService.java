package data.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import data.dto.AdvertiseDTO;
import data.mapper.AdvertiseMapper;

@Service
public class AdvertiseService {
	@Autowired
	AdvertiseMapper mapper;
	
	//목록
	public List<AdvertiseDTO> getList(int start, int perpage) {
		HashMap<String, Integer> map=new HashMap<String, Integer>();
		map.put("start", start);
		map.put("perpage", perpage);
		return mapper.getList(map);
	}
	
	//조회수
	public void updateReadCount(String idx) {
		mapper.updateReadCount(idx);
	}
	
	public int getTotalCount() {
		return mapper.getTotalCount();
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
}
