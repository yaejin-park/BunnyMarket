package data.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import data.dto.ProductDTO;
import data.mapper.ProductLikeMapper;

@Service
public class ProductLikeService {
	@Autowired
	ProductLikeMapper mapper;
	
	public int plikeCheck(String id, String product) {
		return mapper.plikeCheck(id, product);
	}
	
	public void insertPlike(String id, String product) {
		mapper.insertPlike(id, product);
	}
	
	public void deletePlike(String id, String product) {
		mapper.deletePlike(id, product);
	}
	
	public int getTotalCount(String user_id) {
		return mapper.getTotalCount(user_id);
	}
	
	public List<ProductDTO> getList(int start, int perpage, String user_id) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("perpage", perpage);
		map.put("id", user_id);
		
		return mapper.getList(map);
	}
}
