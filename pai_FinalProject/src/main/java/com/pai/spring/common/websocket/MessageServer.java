package com.pai.spring.common.websocket;

import java.util.ArrayList;
import java.util.Date;
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
import com.google.gson.Gson;
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
		String sendId = getMemberId(session);
		
		if(sendId != null) {
			log(sendId + "Socket 연결됨!!");
			//로그인 중인 개별 유저 저장
			clientMap.put(sendId, session);
		}
		
//		logger.info("Socket 연결");
//		
//		client.add(session);
//		
//		clientMap.put(sendId , session);
		
	}

	// 클라이언트가 웹소켓 서버로 메시지를 전송했을때 실행 onMessage
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("소켓 send한 데이터 : "+message.getPayload());
		session.getAttributes().put("data", message.getPayload());
		//메시지 저장 여기서 하거나 클로즈할때마다 저장?
		
		session.sendMessage(message);
		for(WebSocketSession client : clients) {
			if(client.isOpen()) {
				client.sendMessage(message);
			}
		}
//		ObjectMapper objectMapper = new ObjectMapper();
//		Map<String, String> sendData = objectMapper.readValue(message.getPayload(), Map.class);
//		System.out.println("sendData에서 꺼내보기"+sendData.get("sendId"));
//		String sendId = getMemberId(session);
//		
//		//특정 유저(recvId에게 가야함)
//		String msg = message.getPayload();
//		if(msg != null) {
//			Map param = new HashMap();
//			param.put("sendId", sendData.get("sendId"));
//			param.put("recvId", sendData.get("recvId"));
//			param.put("msgTitle", sendData.get("msgTitle"));
//			param.put("msgContent", sendData.get("msgContent"));
//			msgService.sendMessage(param);
//			
//			WebSocketSession recvIdSession = clientMap.get(sendData.get("recvId"));
//			
//			//상대방이 접속해 있는 경우
//			if(recvIdSession != null) {
//				TextMessage resultMsg = new TextMessage(sendData.get("sendId")+"님에게 쪽지가 도착했습니다");
//				//TextMessage tmpMsg = new TextMessage("<a target='_blank' href='"+ url +"'>[<b>" + type + "</b>] " + content + "</a>" );
//
//				recvIdSession.sendMessage(resultMsg);
//				
//			}
//			
//		}
		
		
		
//		  Map<String, Object> httpSession = session.getAttributes(); 
//		  String memberId  = (String) httpSession.get("member_id"); 
//		  
//		  int msgCount; 
//		  if (memberId != null) { 
//			  
//			  //접속한 유저의 읽지 않은 알림 데이터count 
//			  //msgCount =
//		  }
//		  msgService.selectUnreadMsg(memberId);
//		  System.out.println("msgCount"+msgCount); 
//		  WebSocketSession webSocketSession = clientMap.get(sendId); 
//		  Gson gson = new Gson(); 
//		   // 유저 알림데이터
//		  TextMessage textMessage = new TextMessage(gson.toJson(msgCount +
//		  "개의 쪽지가 도착했습니다.")); System.out.println("textMessage"+textMessage);
//		  
//		   webSocketSession.sendMessage(textMessage); 
//		   }
		 

		/*
		 * System.out.println("메시지 전송 : " + session.getId() + ":" + message);
		 * synchronized (clients) { for (WebSocketSession client : clients) { if
		 * (!client.equals(session)) { // 메시지 전송한 클라이언트는 제외하고 전달
		 * client.getBasicRemote().sendText(message); } } }
		 */
		
//		logger.info("ssesion"+getMemberId(session));
//		//String msg = message.getPayload();//자바스크립트에서 넘어온 Msg
//		
//		ObjectMapper objectMapper = new ObjectMapper();
//		Map<String, String> msg = objectMapper.readValue(message.getPayload(), Map.class);
//		logger.info("msg="+msg);
//
//		switch(msg.get("msgType")) {
//		
//		case "sendMessage":
//			Map<String, Object> map = new HashMap<String, Object>();
//			
//			map.put("recvId", msg.get("recvId"));
//			map.put("sendId", msg.get("sendId"));
//			map.put("sendNick", msg.get("sendNick"));
//			map.put("session", session);
//			sessionList.add(map);
//			
//			for(int i=0; i<sessionList.size(); i++) {
//				Map<String,Object> sessionMap = sessionList.get(i);
//				WebSocketSession recvSession = (WebSocketSession)sessionMap.get("session");
//				
//				recvSession.sendMessage(message);
//				
//			}
//			
//			
//			
//		
//		}
		
//		String senderEmail = getId(session);
		//모든 유저에게 보낸다 - 브로드 캐스팅
//		for (WebSocketSession sess : sessions) {
//			sess.sendMessage(new TextMessage(senderNickname + ": " +  message.getPayload()));
//		}
		
		//protocol : cmd , 댓글작성자, 게시글 작성자 , seq (reply , user2 , user1 , 12)
//		String msg = message.getPayload();
//		if(StringUtils.isNotEmpty(msg)) {
//			String[] strs = msg.split(",");
//			
//			if(strs != null && strs.length == 5) {
//				String cmd = strs[0];
//				String caller = strs[1]; 
//				String receiver = strs[2];
//				String receiverEmail = strs[3];
//				String seq = strs[4];
//				
//				//작성자가 로그인 해서 있다면
//				WebSocketSession boardWriterSession = userSessionsMap.get(receiverEmail);
//				
//				if("reply".equals(cmd) && boardWriterSession != null) {
//					TextMessage tmpMsg = new TextMessage(caller + "님이 " + 
//										"<a type='external' href='/mentor/menteeboard/menteeboardView?seq="+seq+"&pg=1'>" + seq + "</a> 번 게시글에 댓글을 남겼습니다.");
//					boardWriterSession.sendMessage(tmpMsg);
//				
//				}else if("follow".equals(cmd) && boardWriterSession != null) {
//					TextMessage tmpMsg = new TextMessage(caller + "님이 " + receiver +
//							 "님을 팔로우를 시작했습니다.");
//					boardWriterSession.sendMessage(tmpMsg);
//					
//				}else if("scrap".equals(cmd) && boardWriterSession != null) {
//					TextMessage tmpMsg = new TextMessage(caller + "님이 " +
//										//변수를 하나더 보낼수 없어서 receiver 변수에 member_seq를 넣어서 썼다.
//										"<a type='external' href='/mentor/essayboard/essayboardView?pg=1&seq="+seq+"&mentors="+ receiver +"'>" + seq + "</a>번 에세이를 스크랩 했습니다.");
//					boardWriterSession.sendMessage(tmpMsg);
//				}
//			}
//			// 모임 신청 했을때
//			if(strs != null && strs.length == 5) {
//				String cmd = strs[0];
//				String mentee_name = strs[1];
//				String mentor_email = strs[2];
//				String meetingboard_seq = strs[3];
//				String participation_seq = strs[4];
//				
//				// 모임 작성한 멘토가 로그인 해있으면
//				WebSocketSession mentorSession = userSessionsMap.get(mentor_email);
//				if(cmd.equals("apply") && mentorSession != null) {
//					TextMessage tmpMsg = new TextMessage(
//							mentee_name + "님이 모임을 신청했습니다. " +"<a type='external' href='/mentor/participation/participationView?mseq="+ meetingboard_seq +"&pseq="+ participation_seq +"'>신청서 보기</a>");
//					mentorSession.sendMessage(tmpMsg);
//				}
//			}
//		}
		
		//JsonObject convertedObj = new Gson().fromJson(msg,JsonObject.class);
		
		//String status = convertedObj.get("status").toString().replaceAll("\"", "");
//		
//		if (!StringUtils.isEmpty(msg)) {
//			logger.info("if문 들어옴?");
//			String[] strs = msg.split(",");
//			if(strs != null && strs.length == 6) {
//				
//				String cmd = strs[0];
//				String replyWriter = strs[1];
//				String boardWriter = strs[2];
//				String bno = strs[3];
//				String title = strs[4];
//				String bgno = strs[5];
//				logger.info("length 성공?"+cmd);
//				
//				WebSocketSession replyWriterSession = userSessionsMap.get(replyWriter);
//				WebSocketSession boardWriterSession = userSessionsMap.get(boardWriter);
//				logger.info("boardWriterSession="+userSessionsMap.get(boardWriter));
//				logger.info("boardWirterSession"+boardWriterSession);
//				
//				//댓글
//				if ("reply".equals(cmd) && boardWriterSession != null) {
//					logger.info("onmessage되나?");
//					TextMessage tmpMsg = new TextMessage(replyWriter + "님이 "
//							+ "<a href='/board/readView?bno="+ bno +"&bgno="+bgno+"'  style=\"color: black\">"
//							+ title+" 에 댓글을 달았습니다!</a>");
//					boardWriterSession.sendMessage(tmpMsg);
//				}
//				
//				//스크랩
//				else if("scrap".equals(cmd) && boardWriterSession != null) {
//					//replyWriter = 스크랩누른사람 , boardWriter = 게시글작성자
//					TextMessage tmpMsg = new TextMessage(replyWriter + "님이 "
//							+ "<a href='/board/readView?bno=" + bno + "&bgno="+bgno+"'  style=\"color: black\"><strong>"
//							+ title+"</strong> 에 작성한 글을 스크랩했습니다!</a>");
//
//					boardWriterSession.sendMessage(tmpMsg);
//					
//				}
//				
//				//좋아요
//				else if("like".equals(cmd) && boardWriterSession != null) {
//					//replyWriter = 좋아요누른사람 , boardWriter = 게시글작성자
//					TextMessage tmpMsg = new TextMessage(replyWriter + "님이 "
//							+ "<a href='/board/readView?bno=" + bno + "&bgno="+bgno+"'  style=\"color: black\"><strong>"
//							+ title+"</strong> 에 작성한 글을 좋아요했습니다!</a>");
//
//					boardWriterSession.sendMessage(tmpMsg);
//					
//				}
//				
//				//DEV
//				else if("Dev".equals(cmd) && boardWriterSession != null) {
//					//replyWriter = 좋아요누른사람 , boardWriter = 게시글작성자
//					TextMessage tmpMsg = new TextMessage(replyWriter + "님이 "
//							+ "<a href='/board/readView?bno=" + bno + "&bgno="+bgno+"'  style=\"color: black\"><strong>"
//							+ title+"</strong> 에 작성한 글을 DEV했습니다!</a>");
//
//					boardWriterSession.sendMessage(tmpMsg);
//					
//				}
//				
//				//댓글채택
//				else if("questionCheck".equals(cmd) && replyWriterSession != null) {
//					//replyWriter = 댓글작성자 , boardWriter = 글작성자
//					TextMessage tmpMsg = new TextMessage(boardWriter + "님이 "
//							+ "<a href='/board/readView?bno=" + bno + "&bgno="+bgno+"'  style=\"color: black\"><strong>"
//							+ title+"</strong> 에 작성한 댓글을 채택했습니다!</a>");
//
//					replyWriterSession.sendMessage(tmpMsg);
//					
//				}
//				
//				//댓글좋아요
//				else if("commentLike".equals(cmd) && replyWriterSession != null) {
//					logger.info("좋아요onmessage되나?");
//					logger.info("result=board="+boardWriter+"//"+replyWriter+"//"+bno+"//"+bgno+"//"+title);
//					//replyWriter=댓글작성자 , boardWriter=좋아요누른사람 
//					TextMessage tmpMsg = new TextMessage(boardWriter + "님이 "
//							+ "<a href='/board/readView?bno=" + bno + "&bgno="+bgno+"'  style=\"color: black\"><strong>"
//							+ title+"</strong> 에 작성한 댓글을 추천했습니다!</a>");
//
//					replyWriterSession.sendMessage(tmpMsg);
//				}
//				
//				
//				//댓글DEV
//				else if("commentDev".equals(cmd) && replyWriterSession != null) {
//					logger.info("좋아요onmessage되나?");
//					logger.info("result=board="+boardWriter+"//"+replyWriter+"//"+bno+"//"+bgno+"//"+title);
//					//replyWriter=댓글작성자 , boardWriter=좋아요누른사람 
//					TextMessage tmpMsg = new TextMessage(boardWriter + "님이 "
//							+ "<a href='/board/readView?bno=" + bno + "&bgno="+bgno+"'  style=\"color: black\"><strong>"
//							+ title+"</strong> 에 작성한 댓글을 DEV했습니다!</a>");
//
//					replyWriterSession.sendMessage(tmpMsg);
//				}
//				
//				
//					
//				
//			}
//			
//		}

	}

	// 클라이언트가 연결을 끊었을때 실행 onClose
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {

		String sendId = getMemberId(session);
		
		if(sendId != null) {
			logger.info("Socket 끊음");
			System.out.println("afterConnectionClosed " + session + ", " + status);
			//웹소켓 close시 전체 접속자 아이디 해제
			clients.remove(session);
			
			//웹소켓 close시 개별접속 아이디 해제
			clientMap.remove(session.getId());
			
		}
		
		
	}
	
	//웹소켓 memberId 가져오기
	private String getMemberId(WebSocketSession session) {
		Map<String,Object> httpSession = session.getAttributes();
		String memberId = (String)httpSession.get("member_id");
		
		if(memberId == null) {
			//랜덤 아이디 생성, 사이트 접속한 사람 전체 ex) vmsklfmw, 5jsiodmk
			System.out.println("로그인 id가 null인경우 : " + session.getId());
			return session.getId();
		} else {
			//로그인한 id 반환
			System.out.println("로그인 id가 null이 아닐때:" + memberId);
			return memberId;
		}
	}
	
	
	// 로그 메시지
		private void log(String logmsg) {
			System.out.println(new Date() + " : " + logmsg);
		}
	
	

	 

}
