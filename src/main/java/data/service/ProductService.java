package data.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;

import data.dto.ProductDTO;
import data.mapper.ProductMapper;

@Service
public class ProductService {
	@Autowired
	ProductMapper mapper;
	
	public int getTotalCount(@RequestParam String category, @RequestParam String keyword, @RequestParam String location) {
		return mapper.getTotalCount(category, keyword, location);
	}
	
	public List<ProductDTO> getList(
			@RequestParam int start, @RequestParam int perpage, 
			@RequestParam String category, 
			@RequestParam String keyword,
			@RequestParam String location) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("start", start);
		map.put("perpage", perpage);
		map.put("category", category);
		map.put("keyword", keyword);
		map.put("location", location);
		
		return mapper.getList(map);
	}
	
	public ProductDTO getData(@RequestParam String idx) {
		return mapper.getData(idx);
	}

	public void insertData(@ModelAttribute ProductDTO dto) {
		mapper.insertData(dto);
	}
	
	public void updateData(@ModelAttribute ProductDTO dto) {
		mapper.updateData(dto);
	}
	
	public int getMaxIdx() {
		return mapper.getMaxIdx();
	}
	
	public void updateReadcount(@RequestParam String idx) {
		mapper.updateReadcount(idx);
	}
	
	public void updateLikecount(@RequestParam String idx) {
		mapper.updateLikecount(idx);
	}
	
	public void updateLikeMinuscount(@RequestParam String idx) {
		mapper.updateLikeMinuscount(idx);
	}
	
	public int getLikeCount(@RequestParam String idx) {
		return mapper.getLikeCount(idx);
	}
	
	public void updateChatcount(@RequestParam String idx) {
		mapper.updateChatcount(idx);
	}
	
	public int chatCheck(String idx) {
		return mapper.chatCheck(idx);
	}
	
	public void deleteData(@RequestParam String idx) {
		mapper.deleteData(idx);
	}
	
	public List<ProductDTO> getRelateList(@RequestParam String category, @RequestParam String idx){
		return mapper.getRelateList(category, idx);
	}
	
	public void updateStatus(@RequestParam String idx, @RequestParam String status) {
		HashMap<String, String> map = new HashMap<String, String>();
		
		map.put("idx", idx);
		map.put("status", status);
		
		mapper.updateStatus(map);
	}
}
