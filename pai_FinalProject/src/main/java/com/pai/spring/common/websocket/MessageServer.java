package com.pai.spring.common.websocket;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.pai.spring.message.model.service.MessageService;
import com.pai.spring.message.model.vo.Message;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class MessageServer extends TextWebSocketHandler{
	
	@Autowired
	MessageService service;
	
	private final ObjectMapper objectMapper = new ObjectMapper();

	private List<WebSocketSession> clients = new ArrayList<>();
	Map<String, WebSocketSession> userSessions = new HashMap<>();

	//클라이언트가 서버에 접속했을때 onOpen
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		//log.debug("{}",session.getId());
		clients.add(session);
//		String senderId = getId(session);
//		userSessions.put(senderId, session);
	}

	//클라이언트가 웹소켓 서버로 메시지를 전송했을때 실행 onMessage
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		log.debug(message.getPayload()); // session이 보낸 데이터 출력
		//jackson을 이용해서 메시지 클래스로 관리하기
		
		//발송한 쪽지 데이터
		String data = message.getPayload();
		session.getAttributes().put("data", data);
		Message msg = objectMapper.readValue(data,Message.class);
//		String sendId = getId(session);
		JsonObject convertedObj = new Gson().fromJson(message.getPayload(),JsonObject.class);
		System.out.println("data : " + data);
		System.out.println("msg : " + msg);
		System.out.println("convertedObj" + convertedObj);
		session.sendMessage(message);
		for(WebSocketSession client : clients) {
			if(client.isOpen()&&!client.equals(session)) {
				client.sendMessage(message);
			}
		}
		
		//쪽지 db 저장
		int a = service.insertMessage(msg);


	}
	
//	private String getId(WebSocketSession session) {
//		Map<String, Object> httpSession = session.getAttributes();
//		Member member_id = (Member)httpSession.get(httpSession);
//		
//		if(null == member_id)
//			return session.getId();
//		else
//			return member_id.getMember_id();
//	}

	//클라이언트가 연결을 끊었을때 실행 onClose
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("close" + session + " : " + status);
		super.afterConnectionClosed(session, status);
	}
	
	
	
}
