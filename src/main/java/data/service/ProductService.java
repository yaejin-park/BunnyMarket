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
	
	public List<ProductDTO> getList(@RequestParam int start, @RequestParam int perpage) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("start", start);
		map.put("perpage", perpage);
		
		return mapper.getList(map);
	}
	
	public ProductDTO getData(@RequestParam String idx) {
		return mapper.getData(idx);
	}

	public void insertData(@ModelAttribute ProductDTO dto) {
		mapper.insertData(dto);
	}
	
	public int getMaxIdx() {
		return mapper.getMaxIdx();
	}
	
	public void updateReadcount(@RequestParam String idx) {
		mapper.updateReadcount(idx);
	}
	
	public void deleteData(@RequestParam String idx) {
		mapper.deleteData(idx);
	}
	
}
