package data.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import data.dto.ProductDTO;

@Mapper
public interface ProductLikeMapper {
	public int plikeCheck(String id, String product);
	public void insertPlike(String id, String product);
	public void deletePlike(String id, String product);
	public int getTotalCount(String id);
	public List<ProductDTO> getList(HashMap<String, Object> map);
}
