package com.pai.spring.common.websocket;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.pai.spring.message.model.service.MessageService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class MessageServer extends TextWebSocketHandler{
	
	@Autowired
	MessageService service;
	
	private List<WebSocketSession> members;
	private Map<String, Object> memberMap;
	
	public MessageServer() {
		members = new ArrayList<WebSocketSession>();
		memberMap = new HashMap<String,Object>();
	}
	
	
//	private final ObjectMapper objectMapper = new ObjectMapper();

	/*
	 * private Map<String, WebSocketSession> clientSession = new HashMap<>();
	 * private List<WebSocketSession> clients = new ArrayList<WebSocketSession>();
	 * private static Logger logger = LoggerFactory.getLogger(MessageServer.class);
	 * 
	 * //SockJS가 연결되면 WebSocektSession으로 들어옴 // -> 연결된 클라이언트의 Session을 다룰 수 있음
	 * private Set<WebSocketSession> sessions = Collections.synchronizedSet(new
	 * HashSet<WebSocketSession>());
	 */


	//클라이언트가 서버에 접속했을때 onOpen
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		members.add(session);
		/*
		 * // session : 접속한 사람의 세션 정보가 담겨있음. HttpSession 정보가 담겨있다
		 * 
		 * // Set에 접속한 사람의 정보를 모아둠 sessions.add(session);
		 * 
		 * System.out.println(session.getId()+"연결됨");
		 * System.out.println(((Member)session.getAttributes().get("loginMember")).
		 * getMember_id());
		 * 
		 * //log.debug("{}",session.getId()); // clients.add(session); //
		 * logger.info("{} 연결됨", session.getId()); // String senderId = getId(session);
		 * // userSessions.put(senderId, session);
		 */	}

	//클라이언트가 웹소켓 서버로 메시지를 전송했을때 실행 onMessage
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		System.out.println("message수신 : " + message.getPayload());
		JSONObject obj = new JSONObject(message.getPayload());
		String type = obj.getString("type");
		
		if(type!=null && type.equals("register")) {
			String user = obj.getString("memberId");
			memberMap.put(user, session);
		}
		
		/*
		 * // logger.info("{}로 부터 {} 받음", session.getId(), message.getPayload()); //
		 * log.debug(message.getPayload()); // session이 보낸 데이터 출력 //
		 * for(WebSocketSession sess : clients){ // sess.sendMessage(new
		 * TextMessage(message.getPayload())); // }
		 * 
		 * //jackson을 이용해서 메시지 클래스로 관리하기
		 * 
		 * //발송한 쪽지 데이터 // String data = message.getPayload(); //
		 * session.getAttributes().put("data", data); // Message msg =
		 * objectMapper.readValue(data,Message.class); // String sendId =
		 * getId(session); // JsonObject convertedObj = new
		 * Gson().fromJson(message.getPayload(),JsonObject.class); //
		 * System.out.println("data : " + data); // System.out.println("msg : " + msg);
		 * // System.out.println("convertedObj" + convertedObj); //
		 * session.sendMessage(message); // for(WebSocketSession client : clients) { //
		 * if(client.isOpen()&&!client.equals(session)) { //
		 * client.sendMessage(message); // } // }
		 * 
		 * //쪽지 db 저장 // int a = service.insertMessage(msg);
		 * 
		 * // session : 텍스트를 입력한 사람의 SocketJS가 들어옴 // message : JSON으로 전환된 문자열이 담겨있다.
		 * 
		 * //SockJs로 들어온 내용 출력 System.out.println("메시지"+ message.getPayload());
		 * JsonObject convertedObj = new
		 * Gson().fromJson(message.getPayload(),JsonObject.class);
		 * 
		 * //세션에 저장된 회원정보 가져오기 Member loginMember =
		 * (Member)session.getAttributes().get("loginMember"); String sendId =
		 * loginMember.getMember_id(); System.out.println(sendId);
		 * 
		 * String status = convertedObj.get("status").toString().replaceAll("\"", "");
		 * 
		 * switch(status) {
		 * 
		 * case "newAlim": String allimContent =
		 * convertedObj.get("allimContent").toString();
		 * 
		 * 
		 * }
		 */
		
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
		/*
		 * // System.out.println("close" + session + " : " + status); //
		 * super.afterConnectionClosed(session, status); clients.remove(session);
		 * logger.info("{} 연결 끊김.", session.getId());
		 */
	}
	
	
	
}
