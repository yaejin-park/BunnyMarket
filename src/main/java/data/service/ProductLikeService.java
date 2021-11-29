package data.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
}
