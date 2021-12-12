package data.mapper;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import data.dto.ChatDTO;


@Mapper
public interface ReviewMapper {
	public List<ChatDTO> getList(String idx);
	public void ReviewInsert(Map<String, String> map);
	public int getCount(String id);
	public int checkWrite(String id, String idx);
	public int checkReviewee(String id, String idx);
}
