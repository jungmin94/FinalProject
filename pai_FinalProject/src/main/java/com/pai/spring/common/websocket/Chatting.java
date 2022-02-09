package com.pai.spring.common.websocket;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.pai.spring.chatting.model.service.ChattingService;
import com.pai.spring.chatting.model.vo.ChatMessage;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class Chatting extends TextWebSocketHandler{
	
//	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	private List<Map<String, Object>> sessionList = new ArrayList<Map<String, Object>>();
	
	@Autowired
	private ChattingService chattingService;
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
	// **TODO** Auto-generated method stub

		log.debug("open");
		Map<String, WebSocketSession> users = new ConcurrentHashMap<String, WebSocketSession>();

	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
	// **TODO** Auto-generated method stub
		
		super.handleTextMessage(session, message);
		
		
		ObjectMapper objectMapper = new ObjectMapper();
//		session.sendMessage(message);

//		ChatRoom cr = objectMapper.readValue(message.getPayload(),ChatRoom.class);
//		int openRoomResult = chattingService.enterChatRoom(cr);
//		
//		ChatMessage cMsg = objectMapper.readValue(message.getPayload(), ChatMessage.class);
		
		Map<String, String> mapReceive = objectMapper.readValue(message.getPayload(), Map.class);
		
	
		switch (mapReceive.get("chatType")) {
		
		// CLIENT 입장
		case "enter":
			// 세션 리스트에 저장
			ChatMessage cMsg = ChatMessage.builder().senderId(mapReceive.get("senderId")).chatMessage(mapReceive.get("chatMessage")).build();
			int result = chattingService.insertMessage(cMsg);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("chatRoomName", mapReceive.get("chatRoomName"));
			map.put("session", session);
			map.put("senderId", mapReceive.get("senderId"));
			sessionList.add(map);
			
			// 같은 채팅방에 입장 메세지 전송
			for (int i = 0; i < sessionList.size(); i++) {
				Map<String, Object> mapSessionList = sessionList.get(i);
				String chatRoomName = (String) mapSessionList.get("chatRoomName");
				String senderId = (String) mapSessionList.get("senderId");
				WebSocketSession sess = (WebSocketSession) mapSessionList.get("session");
				
				if(chatRoomName.equals(mapReceive.get("chatRoomName"))) {
//					Map<String, String> mapToSend = new HashMap<String, String>();
//					mapToSend.put("chatRoomName", chatRoomName);
//					mapToSend.put("senderId", senderId);
//					mapToSend.put("chatType", "msg");
//					mapToSend.put("msg", senderId +  "님이 입장 하였습니다.");
//					
//					String jsonStr = objectMapper.writeValueAsString(mapToSend);
//					sess.sendMessage(new TextMessage(jsonStr));
					sess.sendMessage(message);
				}
			}
			break;
			
		case "enter-all":
			// 세션 리스트에 저장
			ChatMessage cMsg2 = ChatMessage.builder().senderId(mapReceive.get("senderId")).chatMessage(mapReceive.get("chatMessage")).build();
			int result2 = chattingService.insertMessage(cMsg2);
			Map<String, Object> map2 = new HashMap<String, Object>();
			map2.put("chatRoomName", mapReceive.get("chatRoomName"));
			map2.put("session", session);
			map2.put("senderId", mapReceive.get("senderId"));
			sessionList.add(map2);
						
			// 모든 채팅방에 입장 메세지 전송
			for (int i = 0; i < sessionList.size(); i++) {
				Map<String, Object> mapSessionList = sessionList.get(i);
				String chatRoomName = (String) mapSessionList.get("chatRoomName");
				String senderId = (String) mapSessionList.get("senderId");
				WebSocketSession sess = (WebSocketSession) mapSessionList.get("session");
				sess.sendMessage(message);
						
			}
			break;
			
		// CLIENT 메세지
		case "msgEveryone":
			ChatMessage cMsg3 = ChatMessage.builder().senderId(mapReceive.get("senderId")).chatMessage(mapReceive.get("msg")).uploadFile(mapReceive.get("uploadFile")).build();
			int result3 = chattingService.insertMessage(cMsg3);
			
			// 같은 채팅방에 메세지 전송
			for (int i = 0; i < sessionList.size(); i++) {
				Map<String, Object> mapSessionList = sessionList.get(i);
				String chatRoomName = (String) mapSessionList.get("chatRoomName");
				String senderId = (String) mapSessionList.get("senderId");
				String chatTime = (String) mapSessionList.get("chatTime");
				WebSocketSession sess = (WebSocketSession) mapSessionList.get("session");
				
				
				if (chatRoomName.equals(mapReceive.get("chatRoomName"))) {
//					Map<String, String> mapToSend = new HashMap<String, String>();
//					mapToSend.put("chatRoomName", chatRoomName);
//					mapToSend.put("chatType", "msg");
//					mapToSend.put("senderId", senderId);
//					mapToSend.put("chatTime", chatTime);
//					mapToSend.put("msg", mapReceive.get("msg"));
//					
//					String jsonStr = objectMapper.writeValueAsString(mapToSend);
//					sess.sendMessage(new TextMessage(jsonStr));
					sess.sendMessage(message);
				}
			}
			
			break;
			
		case "msgDm" :
			ChatMessage cMsg4 = ChatMessage.builder().senderId(mapReceive.get("senderId")).receiverId(mapReceive.get("receiverId")).uploadFile(mapReceive.get("uploadFile")).chatMessage(mapReceive.get("msg")).build();
			int result4 = chattingService.insertMessage(cMsg4);
			
			String receiveId = mapReceive.get("receiverId");
			//해당 아이디에 귓속말 보내기
			for (int i = 0; i < sessionList.size(); i++) {
				Map<String, Object> mapSessionList = sessionList.get(i);
				String chatRoomName = (String) mapSessionList.get("chatRoomName");
				String senderId = (String) mapSessionList.get("senderId");
				String chatTime = (String) mapSessionList.get("chatTime");
				WebSocketSession sess = (WebSocketSession) mapSessionList.get("session");
				
				
				if (sessionList.get(i).containsValue(receiveId) || sessionList.get(i).containsValue(senderId)) {
					sess.sendMessage(message);
				}
			}
			
		}
			
//		int sendMsgResult = chattingService.insertMessage(cMsg);
//		
//		int sendChatRoomResult = chattingService.insertChatRoom(cMsg);
//		
//		session.sendMessage(message);
//		for(WebSocketSession client:sessionList) {
//			if(client.isOpen()&&!client.equals(session)) {
//				client.sendMessage(message);
//			}
//		}
//		
		
		// 방입장
		// 방 생성
		//	-> 이미 방이 있는 경우
		//	-> 실제로 방을 생성 하는 경우
		
		
		
		
		
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
	// **TODO** Auto-generated method stub

	super.afterConnectionClosed(session, status);
//	sessionList.remove(session);
    
	ObjectMapper objectMapper = new ObjectMapper();
	String now_chatRoomName = "";
	String chatUser = "";
	
	
	// 사용자 세션을 리스트에서 제거
	for (int i = 0; i < sessionList.size(); i++) {
		Map<String, Object> map = sessionList.get(i);
		String chatRoomName = (String) map.get("chatRoomName");
		chatUser = (String) map.get("senderId");
		WebSocketSession sess = (WebSocketSession) map.get("session");
		
		if(session.equals(sess)) {
			now_chatRoomName = chatRoomName;
			sessionList.remove(map);
			break;
		}	
	}
	
	// 같은 채팅방에 퇴장 메세지 전송 
	for (int i = 0; i < sessionList.size(); i++) {
		Map<String, Object> mapSessionList = sessionList.get(i);
		String chatRoomName = (String) mapSessionList.get("chatRoomName");
		WebSocketSession sess = (WebSocketSession) mapSessionList.get("session");

		if (chatRoomName.equals(now_chatRoomName)) {
			Map<String, String> mapToSend = new HashMap<String, String>();
			mapToSend.put("chatRoomName", chatRoomName);
			mapToSend.put("chatType", "exit");
			mapToSend.put("senderId", chatUser);

			String jsonStr = objectMapper.writeValueAsString(mapToSend);
			sess.sendMessage(new TextMessage(jsonStr));
		}
	}

	}
}
