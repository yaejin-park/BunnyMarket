package data.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import data.dto.ChatDTO;
import data.dto.ChatListDTO;
import data.mapper.ChatMapper;

@Service
public class ChatService {
	@Autowired
	ChatMapper mapper;
	
	public ChatListDTO getAChatList(@RequestParam String idx, @RequestParam String id) {
		return mapper.getAChatList(idx, id);
	}
	
	public int checkChatByIdx(@RequestParam String product_idx, @RequestParam String buyer_id) {
		return mapper.checkChatByIdx(product_idx, buyer_id);
	}
	
	public void insertChatList(@RequestParam String chat_idx, @RequestParam String id, @RequestParam String idx) {
		mapper.insertChatList(chat_idx, id, idx);
	}
	
	public void insertChat(@RequestParam String product_idx, @RequestParam String buyer_id, @RequestParam String seller_id, @RequestParam String chat_file) {
		mapper.insertChat(product_idx, buyer_id, seller_id, chat_file);
	}
	
	public List<ChatDTO> getAllList() {
		return mapper.getAllList();
	}
	
	public Integer getChatMaxIdx() {
		return mapper.getChatMaxIdx();
	}
	
	public String getChatIdx(@RequestParam String product_idx, @RequestParam String buyer_id) {
		return mapper.getChatIdx(product_idx, buyer_id);
	}
	
}
