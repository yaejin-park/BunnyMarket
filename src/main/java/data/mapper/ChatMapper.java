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
	public void insertChat(String product_idx, String buyer_id, String seller_id, String chat_file, String last_msg);
	public List<ChatDTO> getAllList();
	public Integer getChatMaxIdx();
	public String getChatIdx(String product_idx, String id);
	public void updateChatTimeMsg(String product_idx, String id, String last_msg);
	public String getChatFile(String chat_idx);
	public void deleteChatList(String chat_idx, String id);
	public void deleteChat(String chat_idx);
	public int countList(String chat_idx);
	public List<ChatListDTO> getChatList(String id);
	public List<ChatListDTO> getChatListJoin(String id);
	public void updateChatState(String idx, String state);
}
