package data.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import data.dto.EventDTO;
import data.mapper.EventMapper;

@Service
public class EventService {
	@Autowired
	EventMapper mapper;
	public int getTotal() {
		return mapper.getTotal();
	}
	public List<EventDTO> getAllList(){
		return mapper.getAllList();
	}
	public List<EventDTO> getPageList(int start, int perPage){
		return mapper.getPageList(start, perPage);
	}
	public EventDTO getData(String idx) {
		return mapper.getData(idx);
	}
	public void insertData(EventDTO dto) {
		mapper.insertData(dto);
	}
	public void updateReadCount(String idx) {
		mapper.updateReadCount(idx);
	}
}
