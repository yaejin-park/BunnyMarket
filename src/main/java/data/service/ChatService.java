package data.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;

import data.dto.ChatDTO;
import data.dto.ChatListDTO;
import data.mapper.ChatMapper;

@Service
public class ChatService {
	@Autowired
	ChatMapper mapper;
	
	public int checkChatList(@RequestParam String idx) {
		return mapper.checkChatList(idx);
	}
	
	public void insertChatList(@ModelAttribute ChatListDTO cldto) {
		mapper.insertChatList(cldto);
	}
	
	public void insertChat(@ModelAttribute ChatDTO cdto) {
		mapper.insertChat(cdto);
	}
}
