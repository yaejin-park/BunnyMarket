package data.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import data.dto.ComReplyDTO;



@Mapper
public interface ComreplyMapper {

	public int getTotalCount();
	public int getMaxIdx();
	public void updateRestep(HashMap<String, Integer> map);
	
	//insert
	public void insertReply(ComReplyDTO dto);
	//update
	public void updateReply(ComReplyDTO dto);
	//delete
	public void deleteReply(int idx);
	//dto 반환
	public ComReplyDTO getReply(int idx);
	//list
	public List<ComReplyDTO> getReplyList(int idx);
}
