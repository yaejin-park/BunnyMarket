package data.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import data.dto.EventDTO;
import data.dto.EventReplyDTO;
import data.mapper.EventMapper;

@Service
public class EventService {
	@Autowired
	EventMapper mapper;
	public int getTotal(String category) {
		return mapper.getTotal(category);
	}
	public List<EventDTO> getAllList(){
		return mapper.getAllList();
	}
	public List<EventDTO> getPageList(int start, int perPage, String category){
		return mapper.getPageList(start, perPage, category);
	}
	public EventDTO getData(String idx) {
		return mapper.getData(idx);
	}
	public List<String> getCategory(){
		return mapper.getCategory();
	}
	public void insertData(EventDTO dto) {
		mapper.insertData(dto);
	}
	public void deleteData(String idx) {
		mapper.deleteData(idx);
	}
	public void updateData(EventDTO dto) {
		mapper.updateData(dto);
	}
	public void updateReadCount(String idx) {
		mapper.updateReadCount(idx);
	}
	public void insertReplyData(EventReplyDTO dto) {
		mapper.insertReplyData(dto);
	}
	public List<EventReplyDTO> getReplyList(String idx) {
		return mapper.getReplyList(idx);
	}
	public String getMaxReply(String idx) {
		return mapper.getMaxReply(idx);
	}
	public void deleteReply(String idx) {
		mapper.deleteReply(idx);
	}
}
