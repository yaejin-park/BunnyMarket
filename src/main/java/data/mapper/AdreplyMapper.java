package data.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import data.dto.AdreplyDTO;

@Mapper
public interface AdreplyMapper {
	public int getTotalCount();
	public int getMaxIdx();
	public void updateRestep(HashMap<String, Integer> map);
	
	//insert
	public void insertReply(AdreplyDTO dto);
	//update
	public void updateReply(AdreplyDTO dto);
	//delet
	public void deleteReply(int idx);
	//dto 반환
	public AdreplyDTO getReply(int idx);
	//list
	public List<AdreplyDTO> getReplyList(int idx);
}
