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
	
	public List<EventDTO> getList(){
		List<EventDTO> list = mapper.getList();
		
		return list;
	}
	public String getTitle() {
		String title = mapper.getTitle();
		return title;
	}
}
