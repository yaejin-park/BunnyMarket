package data.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import data.dto.EventDTO;
import data.dto.EventReplyDTO;

@Mapper
public interface EventMapper {
	public int getTotal(String category);
	public List<EventDTO> getAllList();
	public List<EventDTO> getPageList(int start, int perPage, String category);
	public EventDTO getData(String idx);
	public List<String> getCategory();
	public void insertData(EventDTO dto);
	public void updateReadCount(String idx);
	public void insertReplyData(EventReplyDTO dto);
	public List<EventReplyDTO> getReplyList(String idx);
}
