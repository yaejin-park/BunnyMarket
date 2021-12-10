package com.example.demo;


import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import data.service.ChatService;

@Component
public class SocketHandler extends TextWebSocketHandler {
	// TextWebSocketHandler는 handleTextMessage를 실행
	// 메시지 타입에따라 handleBinaryMessage또는 handleTextMessage가 실행
	//HashMap<String, WebSocketSession> sessionMap = new HashMap<>(); //웹소켓 세션을 담아둘 맵
	List<HashMap<String, Object>> rls = new ArrayList<>(); //웹소켓 세션을 담아둘 리스트 ---roomListSessions
	
	@Autowired
	ChatService service;
	
	//메시지 발송
	@Override
	public void handleTextMessage(WebSocketSession session, TextMessage message) {
		String msg = message.getPayload(); //메세지에 담긴 텍스트값 얻기
		JSONObject obj = jsonToObjectParser(msg); 
		String rN = (String) obj.get("roomNumber");
		HashMap<String, Object> temp = new HashMap<String, Object>();
		
		if(rls.size() > 0) {
			for(int i=0; i<rls.size(); i++) {
				String roomNumber = (String) rls.get(i).get("roomNumber"); //세션리스트의 저장된 방번호를 가져와서
				if(roomNumber.equals(rN)) { //같은값의 방이 존재한다면
					temp = rls.get(i); //해당 방번호의 세션리스트의 존재하는 모든 object값을 가져온다.
					break;
				}
			}
			
			//해당 방의 세션들만 찾아서 메시지를 발송해준다.
			for(String k : temp.keySet()) { 
				if(k.equals("roomNumber")) { //다만 방번호일 경우에는 건너뛴다.
					continue;
				}
				
				WebSocketSession wss = (WebSocketSession) temp.get(k);
				if(wss != null) {
					try {
						wss.sendMessage(new TextMessage(obj.toJSONString()));
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		}
	}
	
	//소켓 연결
	@SuppressWarnings("unchecked")
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		super.afterConnectionEstablished(session);
		System.out.println("소켓 연결1!!");
		boolean flag = false;
		
		//채팅방 url
		String url = session.getUri().toString();
		System.out.println("채팅방 ulr : "+url);
		String roomNumber = url.split("/chating/")[1];
		
		//세션의 채팅방의 갯수
		int idx = rls.size(); 
		
		//채팅방이 존재하면
		if(rls.size() > 0) { 
			//일치하는 채팅방 찾기
			for(int i=0; i<rls.size(); i++) {
				String rN = (String) rls.get(i).get("roomNumber");
				//일치하면
				if(rN.equals(roomNumber)) {
					flag = true;
					idx = i;
					break;
				}
			}
		}
		
		if(flag) { //존재하는 방이라면 세션만 추가한다.
			HashMap<String, Object> map = rls.get(idx);
			map.put(session.getId(), session);
		}else { //최초 생성하는 방이라면 방번호와 세션을 추가한다.
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("roomNumber", roomNumber);
			map.put(session.getId(), session);
			rls.add(map);
		}
		
		//아이디
		String sessionId = session.getPrincipal().getName();
		System.out.println("세션 아이디:"+sessionId);
		
		//세션등록이 끝나면 발급받은 세션ID값의 메시지를 발송한다.
		JSONObject obj = new JSONObject();
		obj.put("type", "sessionOpen");
		obj.put("sessionId", sessionId);
		session.sendMessage(new TextMessage(obj.toJSONString()));
	}

	//소켓 종료
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		if(rls.size() > 0) { //소켓이 종료되면 해당 세션값들을 찾아서 지운다.
			for(int i=0; i<rls.size(); i++) {
				rls.get(i).remove(session.getId());
			}
		}
		super.afterConnectionClosed(session, status);
	}
	
	private static JSONObject jsonToObjectParser(String jsonStr) {
		JSONParser parser = new JSONParser();
		JSONObject obj = null;
		try {
			obj = (JSONObject) parser.parse(jsonStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return obj;
	}
}
