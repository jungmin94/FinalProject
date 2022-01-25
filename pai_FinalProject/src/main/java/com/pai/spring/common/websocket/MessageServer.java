package com.pai.spring.common.websocket;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class MessageServer extends TextWebSocketHandler{

	private List<WebSocketSession> clients = new ArrayList();

	//클라이언트가 서버에 접속했을때 onOpen
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.debug("{}",session.getId());
		clients.add(session);
	}

	//클라이언트가 웹소켓 서버로 메시지를 전송했을때 실행 onMessage
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		log.debug(message.getPayload()); // session이 보낸 데이터 출력
		//jackson을 이용해서 메시지 클래스로 관리하기
		session.getAttributes().put("data", message.getPayload());
		//메시지 저장 여기서 하거나 클로즈할때마다 저장?
		
		session.sendMessage(message);
		for(WebSocketSession client : clients) {
			if(client.isOpen()&&!client.equals(session)) {
				client.sendMessage(message);
			}
		}
	}

	//클라이언트가 연결을 끊었을때 실행 onClose
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// TODO Auto-generated method stub
		super.afterConnectionClosed(session, status);
	}
	
	
	
}
