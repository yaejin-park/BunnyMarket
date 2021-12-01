package data.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.web.bind.annotation.ModelAttribute;

import data.dto.ChatDTO;
import data.dto.ChatListDTO;

@Mapper
public interface ChatMapper {
	public int checkChatList(String product_idx);
	public void insertChatList(@ModelAttribute ChatListDTO cldto);
	public void insertChat(@ModelAttribute ChatDTO cdto);
}
