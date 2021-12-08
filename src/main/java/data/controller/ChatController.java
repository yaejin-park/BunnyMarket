package data.controller;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import data.dto.ChatDTO;
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

	@GetMapping("/auth/room")
	public ModelAndView chatList(@RequestParam String idx, @RequestParam String id, Principal principal, HttpSession session) throws IOException  {
		ModelAndView mview = new ModelAndView();
		//채팅 리스트 존재 여부(제품 idx & 로그인 아이디 통해 찾기)
		ChatListDTO chdto = service.getAChatList(idx, id);

		int roomNumber = 1;

		//채팅리스트 존재하면,
		if(chdto != null) {
			System.out.println("채팅리스트 존재");
			//파일 경로
			String path = session.getServletContext().getRealPath("/chatFile");
			//chat테이블에서 chat_file 찾기
			String chat_idx = service.getChatIdx(idx, id);
			String chat_file = service.getChatFile(chat_idx);

			String pathName = path + "/" + chat_file;

			//DB에 저장된 chat.txt 파일을 읽어옴 
	        BufferedReader br = new BufferedReader(new FileReader(pathName));
			
	        ChatDTO chatmsg = new ChatDTO();
	        List<ChatDTO> chatHistory = new ArrayList<ChatDTO>();
	   
	        String chatLine;
	        int num = 1;
	        
	        while ((chatLine = br.readLine()) != null) {
	            //1개 메시지는 3줄(보낸사람,메시지내용,보낸시간)로 구성돼있음
	            int answer = num % 3;
	            if (answer == 1) {
	            	//보낸시간
	            	chatmsg.setTime(chatLine);
	            	num++;
	            } else if (answer == 2) {
	                //메시지내용
	            	chatmsg.setMsg(chatLine);
	            	num++;
	            } else {
	            	//보낸사람
	            	chatmsg.setSender(chatLine);
	                
	                //메시지 담긴 ChatRoom 객체 List에 저장
	                chatHistory.add(chatmsg);
	                //객체 초기화, 줄(row)인덱스 초기화
	                chatmsg = new ChatDTO();
	                num = 1;
	            }  
	        }
	        mview.addObject("chatHistory", chatHistory);
	        
			//채팅리스트테이블의 채팅 idx 보내기
			roomNumber= Integer.parseInt(chdto.getChat_idx());
		} else {
			System.out.println("채팅방 없음");

			//채팅 테이블의 가장큰 idx+1 보내기
			//채팅이 아예 없으면
			if(service.getChatMaxIdx()==null) { 
				roomNumber = 1;
			} else {
				roomNumber = service.getChatMaxIdx()+1;
			}
			System.out.println(roomNumber+"!!!");
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
	@PostMapping("/auth/firstSend")
	public Map<String, String> firstSend(@RequestParam String idx, @RequestParam String seller, @RequestParam String roomNumber,
			@RequestParam String msg,HttpSession session, Principal principal) throws IOException {

		Map<String, String> map = new HashMap<String, String>();

		String id = principal.getName();

		//채팅 테이블에서 채팅방 존재 여부(product_idx, buyer_id)
		int checkChat = service.checkChatByIdx(idx, id);


		//채팅방 존재X
		if(checkChat==0) {
			//채팅파일 UUID 랜덤 생성
			UUID uuid = UUID.randomUUID();
			String chat_file = uuid.toString() + "_chat" + roomNumber+".txt";

			//파일 저장 위치
			String path = session.getServletContext().getRealPath("/chatFile");

			String pathName = path + "/" + chat_file;

			System.out.println("first"+pathName);
			//File 클래스에 pathName 할당
			File txtFile = new File(pathName);
			//로컬경로에 파일 생성
			txtFile.createNewFile();

			//현재 시간
			SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
			String now = format1.format (System.currentTimeMillis());

			BufferedOutputStream bs = null;
			try {
				bs = new BufferedOutputStream(new FileOutputStream(pathName));
				String str = now + "\n";
				str += msg + "\n";
				str += id + "\n";
				bs.write(str.getBytes()); //Byte형으로만 넣을 수 있음
			} catch (Exception e) {
				e.getStackTrace();
				// TODO: handle exception
			} finally {
				bs.close();
			} 

			//채팅방 만들기
			service.insertChat(idx, id, seller, chat_file);
			//채팅방 찾기
			service.getChatIdx(idx, id);
			//채팅 count 올라가게
			pservice.updateChatcount(idx);
		} else {
			//파일 저장 위치
			String path = session.getServletContext().getRealPath("/chatFile");

			String product_idx = service.getChatIdx(idx, id);
			String chat_file = service.getChatFile(product_idx);

			String pathName = path + "/" + chat_file;

			System.out.println("first"+pathName);

			/*
			 * //File 클래스에 pathName 할당 File txtFile = new File(pathName);
			 */

			//현재 시간
			SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
			String now = format1.format (System.currentTimeMillis());

			BufferedOutputStream bs = null;
			try {
				bs = new BufferedOutputStream(new FileOutputStream(pathName, true));
				String str = now + "\n";
				str += msg + "\n";
				str += id + "\n";
				bs.write(str.getBytes()); //Byte형으로만 넣을 수 있음
			} catch (Exception e) {
				e.getStackTrace();
				// TODO: handle exception
			} finally {
				bs.close();
			} 
		}


		//채팅 리스트 존재 여부(제품 idx & 로그인 아이디 통해 찾기)
		ChatListDTO cldto = service.getAChatList(idx, id);
		ChatListDTO cldto_seller = service.getAChatList(idx, seller);

		//채팅방의 채팅 idx 가져오기 
		String chat_idx = service.getChatIdx(idx, id);

		//채팅 리스트 존재X 
		if(cldto == null) { 
			//채팅리스트 만들기
			service.insertChatList(chat_idx,id,idx); 
		}

		if(cldto_seller == null) {
			//채팅리스트 만들기
			service.insertChatList(chat_idx,seller,idx); 
		}

		map.put("chat_idx", chat_idx);

		return map;
	}



	@ResponseBody
	@PostMapping("/auth/send")
	public void sendMsg(@ModelAttribute ChatDTO dto, @RequestParam String chat_idx, HttpSession session) throws IOException {
		//chat테이블에서 chat_file 찾기
		String chat_file = service.getChatFile(chat_idx);
		System.out.println(chat_file);

		//파일 저장 위치
		String path = session.getServletContext().getRealPath("/chatFile");

		String pathName = path + "/" + chat_file;

		System.out.println("send"+pathName);

		//현재 시간 
		SimpleDateFormat format1 = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss"); 
		String now = format1.format(System.currentTimeMillis());

		BufferedOutputStream bs = null; 
		try { 
			bs = new BufferedOutputStream(new FileOutputStream(pathName, true)); 
			String str = now +"\n"; 
			str += dto.getMsg()+"\n"; 
			str += dto.getSender()+"\n"; 
			bs.write(str.getBytes()); //Byte형으로만 넣을수 있음
		} catch (Exception e) { 
			e.getStackTrace();
		}finally {
			bs.close(); 
		}

		//chat_dto에서 시간 update하기
		service.updateChatTime(dto.getProduct_idx(), dto.getBuyer_id());
	}


	@GetMapping("/auth/deleteChat")
	public ModelAndView deleteChatList(@RequestParam String chat_idx, @RequestParam String id, @RequestParam String idx) {
		ModelAndView mview = new ModelAndView();

		service.deleteChatList(chat_idx, id);
		mview.setViewName("../../product/detail?idx="+idx);
		return mview;
	}


}