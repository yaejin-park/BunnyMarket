package data.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import data.service.ChatService;

@Controller
@RequestMapping("/chat")
public class ChatController {
	
	@Autowired
	ChatService service;
	
	@Autowired
	
	
	@GetMapping("/list")
	public ModelAndView chatList(@RequestParam String idx) {
		ModelAndView mview = new ModelAndView();
		
		//채팅 리스트 존재 여부
		int chatList = service.checkChatList(idx);
		
		
		//채팅리스트 존재하지 않을때,
		if(chatList==0) {
			
			//채팅방 만들기
			//service.insertChat(null)
			//채팅리스트 만들기
			//service.insertChatList()
			
		} else{
			//채팅 리스트 들고오기
			
		}
		
		mview.setViewName("/chat/chat");
		return mview;
	}
	
	
}