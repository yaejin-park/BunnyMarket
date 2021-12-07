package data.controller;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.security.Principal;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import data.dto.ChatListDTO;
import data.dto.ProductDTO;
import data.service.ChatService;
import data.service.MemberService;
import data.service.ProductService;

@Controller
@RequestMapping("/chat")
public class ChatController {

	@Autowired
	ChatService service;

	@Autowired
	ProductService pservice;

	@Autowired
	MemberService mservice;

	@GetMapping("/room")
	public ModelAndView chatList(@RequestParam String idx, @RequestParam String id, Principal principal, HttpSession session) {
		ModelAndView mview = new ModelAndView();
		//채팅 리스트 존재 여부(제품 idx & 로그인 아이디 통해 찾기)
		ChatListDTO chdto = service.getAChatList(idx, id);

		int roomNumber = 1;

		//채팅리스트 존재하면,
		if(chdto != null) {
			System.out.println("exist");
			//채팅파일 불러오기
			String path = session.getServletContext().getRealPath("/chatFile");
			//DB에 저장된 chat.txt 파일을 읽어옴 
			//BufferedReader br = new BufferedReader(new FileReader(path));

			//View에 ChatRoom 객체로 전달
			//ChatRoom chatRoomLines = new ChatRoom();
			//List<ChatRoom> chatHistory = new ArrayList<ChatRoom>();


			//채팅리스트테이블의 채팅 idx 보내기
			roomNumber= Integer.parseInt(chdto.getChat_idx());
		} else {
			System.out.println("none");
			//채팅 테이블의 가장큰 idx+1 보내기
			if(service.getChatMaxIdx()==null) {
				roomNumber = 1;
			} else {
				roomNumber = service.getChatMaxIdx()+1;
			}
		}

		//제품 정보(채팅방 상단)
		ProductDTO dto = pservice.getData(idx);

		//사진 ,로 split(대표 이미지)
		String []photo = dto.getUploadfile().split(",");
		String thumb = photo[0];

		String myId = principal.getName();
		String nick = mservice.getNick(myId);

		mview.addObject("dto", dto);
		mview.addObject("roomNumber", roomNumber);
		mview.addObject("photo", thumb);
		mview.addObject("myId", myId);
		mview.addObject("nick", nick);
		mview.setViewName("/chat/chat");

		return mview;	
	}

	@ResponseBody
	@PostMapping("/firstSend")
	public void firstSend(@RequestParam String idx,@RequestParam String seller, @RequestParam String roomNumber, Principal principal, HttpSession session) throws IOException {
		String id = principal.getName();
		//채팅 테이블에서 채팅방 존재 여부(product_idx, buyer_id)
		int checkChat = service.checkChatByIdx(idx, id);

		//채팅방 존재X
		if(checkChat==0) {
			//채팅파일 UUID 랜덤 생성
			UUID uuid = UUID.randomUUID();
			String chat_file = uuid.toString() + "_chat" + roomNumber;
			
			//파일 저장 위치
			String path = session.getServletContext().getRealPath("/chatFile");
			
			String pathName = path + "/" + chat_file;
			
			System.out.println(pathName);
			//File 클래스에 pathName 할당
	        File txtFile = new File(pathName);
	        //로컬경로에 파일 생성
	        txtFile.createNewFile();
			
	        BufferedOutputStream bs = null;
	    	try {
	    		bs = new BufferedOutputStream(new FileOutputStream(pathName));
	    		String str ="오늘 날씨는 아주 좋습니다.\n";
	    		str +="하이하이\n";
	    		bs.write(str.getBytes()); //Byte형으로만 넣을 수 있음
	    	} catch (Exception e) {
	                    e.getStackTrace();
	    		// TODO: handle exception
	    	}finally {
	    		bs.close();
	    	} 

			//채팅방 만들기
			service.insertChat(idx, id, seller, chat_file);
		}

		//채팅 리스트 존재 여부(제품 idx & 로그인 아이디 통해 찾기)
		ChatListDTO cldto = service.getAChatList(idx, id);

		//채팅 리스트 존재X 
		if(cldto == null) { //채팅방의 채팅 idx 가져오기 
			String chat_idx = service.getChatIdx(idx, id);
			//채팅리스트 만들기
			service.insertChatList(chat_idx,id,idx); 
		}


		//메세지 보내기
		//메세지 저장

	}


	/*
	 * @ResponseBody
	 * @PostMapping("/send") public void sendMsg(@RequestParam String msg) {
	 * 
	 * //채팅방 idx 보내기 String roomNumber = "";
	 * mview.addObject("roomNumber",roomNumber);
	 * 
	 * }
	 */



}