package data.mapper;


import java.util.HashMap;
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
	public int checkWrite(String id, String idx);
	public int checkReviewee(String id, String idx);
	public int getTotalCount();
	public List<ReviewDTO> getMyReviewList(HashMap<String, Object> map);
	public List<ReviewDTO> getOtherReviewList(HashMap<String, String> map);

}
