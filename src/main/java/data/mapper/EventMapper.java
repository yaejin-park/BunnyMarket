package data.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import data.dto.EventDTO;
import data.dto.EventReplyDTO;

@Mapper
public interface EventMapper {
	public int getTotal(String category, String status);
	public List<EventDTO> getAllList();
	public List<EventDTO> getPageList(int start, int perPage, String category, String status);
	public EventDTO getData(String idx);
	public List<String> getCategory();
	public void insertData(EventDTO dto);
	public void deleteData(String idx);
	public void updateData(EventDTO dto);
	public void updateReadCount(String idx);
	public void insertReplyData(EventReplyDTO dto);
	public void updateReplyStep(int restep, int regroup);
	public List<EventReplyDTO> getReplyList(String idx);
	public String getMaxReply(String idx);
	public void deleteReply(String idx);
}
