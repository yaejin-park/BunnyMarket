package data.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import data.dto.ProductDTO;
import data.service.ChatService;
import data.service.ProductService;

@Controller
@RequestMapping("/chat")
public class ChatController {
	
	@Autowired
	ChatService service;
	
	@Autowired
	ProductService pservice;
	
	@GetMapping("/room")
	public ModelAndView chatList(@RequestParam String idx, @RequestParam String id) {
		ModelAndView mview = new ModelAndView();
		//채팅 리스트 존재 여부
		int chatList = service.checkChatList(idx, id);
		
		//채팅리스트 존재하면,
		if(chatList != 0) {
			//채팅파일 불러오기
			
		}
		
		//제품 정보 채팅방 상단에 출력
		ProductDTO dto = pservice.getData(idx);
		
		mview.addObject("dto", dto);
		mview.setViewName("/chat/chat");
		return mview;
	}
	
	
}