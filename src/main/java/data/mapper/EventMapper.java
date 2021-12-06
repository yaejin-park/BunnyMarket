package data.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import data.dto.EventDTO;

@Mapper
public interface EventMapper {
	public int getTotal();
	public List<EventDTO> getAllList();
	public List<EventDTO> getPageList(int start, int perPage);
	public EventDTO getData(String idx);
	public void insertData(EventDTO dto);
	public void updateReadCount(String idx);
}
