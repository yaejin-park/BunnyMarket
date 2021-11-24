package data.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import data.dto.ProductDTO;

@Mapper
public interface ProductMapper {
	public List<ProductDTO> getList(HashMap<String, Integer> map);
	public ProductDTO getData(String idx);
	public void insertData(ProductDTO dto);
	public int getMaxIdx();
	public void updateReadcount(String idx);
	public void deleteData(String idx);
}
