package com.pai.spring.common.websocket;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.util.StringUtils;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.pai.spring.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class MessageServer extends TextWebSocketHandler{

	private List<WebSocketSession> clients = new ArrayList<>();
	Map<String, WebSocketSession> userSessions = new HashMap<>();

	//클라이언트가 서버에 접속했을때 onOpen
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.debug("{}",session.getId());
		clients.add(session);
		String senderId = getId(session);
		userSessions.put(senderId, session);
	}

	//클라이언트가 웹소켓 서버로 메시지를 전송했을때 실행 onMessage
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		log.debug(message.getPayload()); // session이 보낸 데이터 출력
		//jackson을 이용해서 메시지 클래스로 관리하기
//		session.getAttributes().put("data", message.getPayload());
		//메시지 저장 여기서 하거나 클로즈할때마다 저장?
		String senderId = getId(session);
//		session.sendMessage(message);
//		for(WebSocketSession client : clients) {
//			if(client.isOpen()&&!client.equals(session)) {
//				client.sendMessage(message);
//			}
//		}
		//protocol : cmd,보낸사람, 받는사람 (reply,user2,user1)
		String msg = message.getPayload();
		
//		if(StringUtils.isNotEmpty(msg)) {
		if(!StringUtils.isEmpty(msg)) {
			String[] strs = msg.split(",");
			if(strs != null && strs.length == 3) {
				String cmd = strs[0];
				String send_id = strs[1];
				String recv_id = strs[2];
				
				WebSocketSession recv_idSession = userSessions.get(recv_id);
				if("reply".equals(cmd) && recv_idSession != null) {
					TextMessage tmpMsg = new TextMessage(send_id + "님이 쪽지를 보냈습니다.");
					recv_idSession.sendMessage(tmpMsg);
				}
			}
		}

	}
	
	private String getId(WebSocketSession session) {
		Map<String, Object> httpSession = session.getAttributes();
		Member member_id = (Member)httpSession.get(httpSession);
		
		if(null == member_id)
			return session.getId();
		else
			return member_id.getMember_id();
	}

	//클라이언트가 연결을 끊었을때 실행 onClose
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("close" + session + " : " + status);
		super.afterConnectionClosed(session, status);
	}
	
	
	
}
