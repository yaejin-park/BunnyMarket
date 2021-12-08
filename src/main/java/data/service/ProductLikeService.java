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
	
	
	}
}
