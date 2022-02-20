package com.pai.spring.common.websocket;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.pai.spring.member.model.vo.Member;
import com.pai.spring.message.model.service.MessageService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class MessageServer extends TextWebSocketHandler {

	private static final Logger logger = LoggerFactory.getLogger(WebSocketHandler.class);
	//로그인 한 전체
	List<WebSocketSession> clients = new ArrayList<WebSocketSession>();
	// 1대1
	Map<String, WebSocketSession> clientMap = new HashMap<String, WebSocketSession>();

	@Autowired
	MessageService msgService;

	// private static Set<WebSocketSession> clients =
	// Collections.synchronizedSet(new HashSet<WebSocketSession>());

	// 클라이언트가 서버에 접속했을때 onOpen
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		
		//접속한 유저 httpSession을 조회하여 id를 얻음
		
//		if(sendId != null) {
//			log(sendId + "Socket 연결됨!!");
			//로그인 중인 개별 유저 저장
			clients.add(session);
			String memberId = getMemberId(session);
			clientMap.put(memberId, session);
//	}
//		clients.add(session);
//		System.out.println(clients);
//		
//		clientMap.put(sendId , session);
		
	}

	// 클라이언트가 웹소켓 서버로 메시지를 전송했을때 실행 onMessage
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String sendId = getMemberId(session);
		String msg = message.getPayload();
		session.getAttributes().put("data", message.getPayload());
		
		//Json 형태의 문자열을 jsonObject로 변환(값을 꺼내쓸 수 있게)
		//JsonObject convertedObj = new Gson().fromJson(msg, JsonObject.class);
		
		//send로 넘어온 값 map으로 변환 -> db저장을 위한 map값도 필요 -> jsonObject쓰면 한번 더 변환해야함...
		Map<String, String> sendData = new ObjectMapper().readValue(msg, Map.class);
		
		//타입값 문자열로 가져옴
		//String type = convertedObj.get("type").toString().replaceAll("\"", "");
		
		switch(sendData.get("type")) {
		
		//쪽지 알림
			case "message" :
			
				//db에 저장
				msgService.sendMessage(sendData);
				//받는사람 id 문자열로 만들고
				String recvId = sendData.get("recvId");
				
				WebSocketSession recvIdSession = clientMap.get(recvId);
				if(recvIdSession != null) {
					//TextMessage resultMsg = new TextMessage(sendData.get("sendNick")+"님이 쪽지를 보냈습니다.");
					TextMessage resultMsg = new TextMessage(message.getPayload());
					recvIdSession.sendMessage(resultMsg);
				}
			break;
			
			
		}

	}

	// 클라이언트가 연결을 끊었을때 실행 onClose
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {

		String sendId = getMemberId(session);
		
		if(sendId != null) {
			//웹소켓 close시 전체 접속자 아이디 해제
			clients.remove(session);
			
			//웹소켓 close시 개별접속 아이디 해제
			clientMap.remove(session.getId());
			
		}
		
		
	}
	
	
	
	//httpSession memberId값을 Map으로 WebSocketSession에 넣기 위함
	private String getMemberId(WebSocketSession session) {
		Map<String,Object> httpSession = session.getAttributes();
		Member loginMember = (Member)httpSession.get("loginMember");
		
		if(loginMember == null) {
			//로그인 id가 null일때
			return session.getId();
		} else {
			//로그인 id가 null이 아닐때
			return loginMember.getMember_id();
		}
	}
	
	

	 

}
