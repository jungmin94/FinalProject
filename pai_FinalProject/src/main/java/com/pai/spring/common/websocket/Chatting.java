package com.pai.spring.common.websocket;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class Chatting extends TextWebSocketHandler{
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
	// **TODO** Auto-generated method stub

	super.afterConnectionEstablished(session);

	}

	@Override
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
	// **TODO** Auto-generated method stub

	super.handleMessage(session, message);

	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
	// **TODO** Auto-generated method stub

	super.handleTextMessage(session, message);

	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
	// **TODO** Auto-generated method stub

	super.afterConnectionClosed(session, status);

	}
}
