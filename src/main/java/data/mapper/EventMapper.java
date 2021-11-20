package data.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import data.dto.EventDTO;

@Mapper
public interface EventMapper {
	public List<EventDTO> getList();
	public String getTitle();
}
