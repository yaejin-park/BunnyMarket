package data.mapper;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import data.dto.ChatDTO;
import data.dto.ReviewDTO;



@Mapper
public interface ReviewMapper {
	
	
	public List<ChatDTO> getList(String idx);
	public void ReviewInsert(Map<String, String> map);
	public int getCount(String id);

	

}
