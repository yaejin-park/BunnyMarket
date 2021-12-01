package data.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import data.dto.ProductDTO;

@Mapper
public interface ProductMapper {
	public int getTotalCount(String category);
	public List<ProductDTO> getList(HashMap<String, Object> map);
	public ProductDTO getData(String idx);
	public void insertData(ProductDTO dto);
	public int getMaxIdx();
	public void updateReadcount(String idx);
	public void updateLikecount(String idx);
	public void updateLikeMinuscount(String idx);
	public int getLikeCount(String idx);
	public void updateChatcount(String idx);
	public int chatCheck(String idx);
	public void deleteData(String idx);
	public List<ProductDTO> getRelateList(String category, String idx);
}