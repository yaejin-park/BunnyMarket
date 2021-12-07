package data.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import data.dto.ChatDTO;
import data.dto.ChatListDTO;

@Mapper
public interface ChatMapper {
	public ChatListDTO getAChatList(String product_idx, String id);
	public int checkChatByIdx(String product_idx, String buyer_id);
	public void insertChatList(String chat_idx, String id, String idx);
	public void insertChat(String product_idx, String buyer_id, String seller_id, String chat_file);
	public List<ChatDTO> getAllList();
	public Integer getChatMaxIdx();
	public String getChatIdx(String product_idx, String buyer_id);
}
