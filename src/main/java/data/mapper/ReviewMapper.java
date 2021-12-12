package data.mapper;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import data.dto.ChatDTO;
import data.dto.ReviewDTO;



@Mapper
public interface ReviewMapper {
	
	
	public List<ChatDTO> getList(String idx);
	public void ReviewInsert(ReviewDTO rdto);
	public int getCount(String id);
	

}
