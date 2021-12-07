package data.service;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import data.dto.FaqDTO;
import data.mapper.FaqMapper;

@Service
public class FaqService {
	@Autowired
	FaqMapper mapper;

	public void insertFaq(FaqDTO dto) {
		mapper.insertFaq(dto);
	}
	public int getTotalCount() {
		return mapper.getTotalCount();
	}
	public FaqDTO getData(String num) {
		return mapper.getData(num);
	}
	public List<FaqDTO> getList(int start, int perpage) {
		HashMap<String, Integer> map=new HashMap<String, Integer>();
		map.put("start", start);
		map.put("perpage", perpage);
		return mapper.getList(map);
	}
	public List<FaqDTO> getListByCategory(String category, int start, int perpage) {
		HashMap<String, Object> map=new HashMap<String, Object>();
		map.put("category", category);
		map.put("start", start);
		map.put("perpage", perpage);
		return mapper.getListByCategory(map);
	}
	public void updateFaq(FaqDTO dto) {
		mapper.updateFaq(dto);
	}
	public int getMaxNum() {
		return mapper.getMaxNum();
	}
	public void deleteFaq(String num) {
		mapper.deleteFaq(num);
	}
}
