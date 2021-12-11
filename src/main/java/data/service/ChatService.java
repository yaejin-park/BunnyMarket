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
	
	public void insertChat(@RequestParam String product_idx, @RequestParam String buyer_id, @RequestParam String seller_id, @RequestParam String chat_file, @RequestParam String last_msg) {
		mapper.insertChat(product_idx, buyer_id, seller_id, chat_file, last_msg);
	}
	
	public List<ChatDTO> getAllList() {
		return mapper.getAllList();
	}
	
	public Integer getChatMaxIdx() {
		return mapper.getChatMaxIdx();
	}
	
	public String getChatIdx(@RequestParam String product_idx, @RequestParam String id) {
		return mapper.getChatIdx(product_idx, id);
	}
	
	public void updateChatTimeMsg(@RequestParam String product_idx, @RequestParam String id, @RequestParam String last_msg) {
		mapper.updateChatTimeMsg(product_idx, id, last_msg);
	}
	
	public String getChatFile(String chat_idx) {
		return mapper.getChatFile(chat_idx);
	}
	
	public void deleteChatList(@RequestParam String chat_idx, @RequestParam String id) {
		mapper.deleteChatList(chat_idx, id);
	}
	
	public void deleteChat(@RequestParam String chat_idx) {
		mapper.deleteChat(chat_idx);
	}
	
	public int countList(@RequestParam String chat_idx) {
		return mapper.countList(chat_idx);
	}
	
	public List<ChatListDTO> getChatList(@RequestParam String id){
		return mapper.getChatList(id);
	}
	
	public List<ChatListDTO> getChatListJoin(@RequestParam String id){
		return mapper.getChatListJoin(id);
	}
	
	public void updateChatState(@RequestParam String product_idx, @RequestParam String state) {
		mapper.updateChatState(product_idx, state);
	}
}
