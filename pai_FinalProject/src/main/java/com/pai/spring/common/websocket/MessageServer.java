package com.pai.spring.common.websocket;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.pai.spring.member.model.vo.Member;
import com.pai.spring.message.model.service.MessageService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class MessageServer extends TextWebSocketHandler {

	private static final Logger logger = LoggerFactory.getLogger(WebSocketHandler.class);
	//로그인 한 인원 전체
	private List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	// 1:1로 할 경우
	private Map<String, WebSocketSession> userSessionsMap = new HashMap<String, WebSocketSession>();
	
//	// 로그인 전체
//	List<WebSocketSession> clients = new ArrayList<WebSocketSession>();
//	// 1대1
//	Map<String, WebSocketSession> clientMap = new HashMap<String, WebSocketSession>();

	@Autowired
	MessageService msgService;

	// private static Set<WebSocketSession> clients =
	// Collections.synchronizedSet(new HashSet<WebSocketSession>());

	// 클라이언트가 서버에 접속했을때 onOpen
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		logger.info("Socket 연결");
		sessions.add(session);
		logger.info(currentUserName(session));//현재 접속한 사람
		String senderId = currentUserName(session);
		userSessionsMap.put(senderId,session);
		// 접속한 전체 유저 아이디
//		clients.add(session);
//
//		// 로그인한 개별 유저 아이디
//		String sendId = getId(session);
//
//		// Map에 개별 아이디 넣기
//		clientMap.put(sendId, session);

	}

	// 클라이언트가 웹소켓 서버로 메시지를 전송했을때 실행 onMessage
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {

//		String sendId = getId(session);
//		Map<String, Object> httpSession = session.getAttributes();
//
//		String memberId = (String) httpSession.get("member_id");
//
//		int msgCount;
//		if (memberId != null) {
//			// 접속한 유저의 읽지 않은 알림 데이터 count
//			msgCount = msgService.selectUnreadMsg(memberId);
//
//			WebSocketSession webSocketSession = clientMap.get(sendId);
//			Gson gson = new Gson();
//
//			// 유저 알림데이터
//			TextMessage textMessage = new TextMessage(gson.toJson(msgCount + "개의 쪽지가 도착했습니다."));
//
//			webSocketSession.sendMessage(textMessage);
//
//		}

		/*
		 * System.out.println("메시지 전송 : " + session.getId() + ":" + message);
		 * synchronized (clients) { for (WebSocketSession client : clients) { if
		 * (!client.equals(session)) { // 메시지 전송한 클라이언트는 제외하고 전달
		 * client.getBasicRemote().sendText(message); } } }
		 */
		
		logger.info("ssesion"+getMemberId(session));
		String msg = message.getPayload();//자바스크립트에서 넘어온 Msg
		logger.info("msg="+msg);
		
		if (!StringUtils.isEmpty(msg)) {
			logger.info("if문 들어옴?");
			String[] strs = msg.split(",");
			if(strs != null && strs.length == 6) {
				
				String cmd = strs[0];
				String replyWriter = strs[1];
				String boardWriter = strs[2];
				String bno = strs[3];
				String title = strs[4];
				String bgno = strs[5];
				logger.info("length 성공?"+cmd);
				
				WebSocketSession replyWriterSession = userSessionsMap.get(replyWriter);
				WebSocketSession boardWriterSession = userSessionsMap.get(boardWriter);
				logger.info("boardWriterSession="+userSessionsMap.get(boardWriter));
				logger.info("boardWirterSession"+boardWriterSession);
				
				//댓글
				if ("reply".equals(cmd) && boardWriterSession != null) {
					logger.info("onmessage되나?");
					TextMessage tmpMsg = new TextMessage(replyWriter + "님이 "
							+ "<a href='/board/readView?bno="+ bno +"&bgno="+bgno+"'  style=\"color: black\">"
							+ title+" 에 댓글을 달았습니다!</a>");
					boardWriterSession.sendMessage(tmpMsg);
				}
				
				//스크랩
				else if("scrap".equals(cmd) && boardWriterSession != null) {
					//replyWriter = 스크랩누른사람 , boardWriter = 게시글작성자
					TextMessage tmpMsg = new TextMessage(replyWriter + "님이 "
							+ "<a href='/board/readView?bno=" + bno + "&bgno="+bgno+"'  style=\"color: black\"><strong>"
							+ title+"</strong> 에 작성한 글을 스크랩했습니다!</a>");

					boardWriterSession.sendMessage(tmpMsg);
					
				}
				
				//좋아요
				else if("like".equals(cmd) && boardWriterSession != null) {
					//replyWriter = 좋아요누른사람 , boardWriter = 게시글작성자
					TextMessage tmpMsg = new TextMessage(replyWriter + "님이 "
							+ "<a href='/board/readView?bno=" + bno + "&bgno="+bgno+"'  style=\"color: black\"><strong>"
							+ title+"</strong> 에 작성한 글을 좋아요했습니다!</a>");

					boardWriterSession.sendMessage(tmpMsg);
					
				}
				
				//DEV
				else if("Dev".equals(cmd) && boardWriterSession != null) {
					//replyWriter = 좋아요누른사람 , boardWriter = 게시글작성자
					TextMessage tmpMsg = new TextMessage(replyWriter + "님이 "
							+ "<a href='/board/readView?bno=" + bno + "&bgno="+bgno+"'  style=\"color: black\"><strong>"
							+ title+"</strong> 에 작성한 글을 DEV했습니다!</a>");

					boardWriterSession.sendMessage(tmpMsg);
					
				}
				
				//댓글채택
				else if("questionCheck".equals(cmd) && replyWriterSession != null) {
					//replyWriter = 댓글작성자 , boardWriter = 글작성자
					TextMessage tmpMsg = new TextMessage(boardWriter + "님이 "
							+ "<a href='/board/readView?bno=" + bno + "&bgno="+bgno+"'  style=\"color: black\"><strong>"
							+ title+"</strong> 에 작성한 댓글을 채택했습니다!</a>");

					replyWriterSession.sendMessage(tmpMsg);
					
				}
				
				//댓글좋아요
				else if("commentLike".equals(cmd) && replyWriterSession != null) {
					logger.info("좋아요onmessage되나?");
					logger.info("result=board="+boardWriter+"//"+replyWriter+"//"+bno+"//"+bgno+"//"+title);
					//replyWriter=댓글작성자 , boardWriter=좋아요누른사람 
					TextMessage tmpMsg = new TextMessage(boardWriter + "님이 "
							+ "<a href='/board/readView?bno=" + bno + "&bgno="+bgno+"'  style=\"color: black\"><strong>"
							+ title+"</strong> 에 작성한 댓글을 추천했습니다!</a>");

					replyWriterSession.sendMessage(tmpMsg);
				}
				
				
				//댓글DEV
				else if("commentDev".equals(cmd) && replyWriterSession != null) {
					logger.info("좋아요onmessage되나?");
					logger.info("result=board="+boardWriter+"//"+replyWriter+"//"+bno+"//"+bgno+"//"+title);
					//replyWriter=댓글작성자 , boardWriter=좋아요누른사람 
					TextMessage tmpMsg = new TextMessage(boardWriter + "님이 "
							+ "<a href='/board/readView?bno=" + bno + "&bgno="+bgno+"'  style=\"color: black\"><strong>"
							+ title+"</strong> 에 작성한 댓글을 DEV했습니다!</a>");

					replyWriterSession.sendMessage(tmpMsg);
				}
				
				
					
				
			}
			
		}

	}

	// 클라이언트가 연결을 끊었을때 실행 onClose
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {

//		// 소켓 연결이 끊겼을때 개별접속아이디 해제
//		clientMap.remove(session.getId());
//
//		// 소켓 연결 끊겼을때 전체 접속자 아이디 해제
//		clients.remove(session);
		logger.info("Socket 끊음");
		sessions.remove(session);
		userSessionsMap.remove(getMemberId(session),session);
	}
	
	
	private String getId(WebSocketSession session) {
		Map<String,Object> httpSession = session.getAttributes();
		String memberId = (String)httpSession.get("member_id");
		if(memberId == null) {
			return session.getId();
		} else {
			return memberId;
		}
	}
	
	private String getMemberId(WebSocketSession session) {
		Map<String, Object> httpSession = session.getAttributes();
		Member memberId = (Member)httpSession.get("member_id");
		
		if(memberId == null) {
			String mid = session.getId();
			return mid;
		}
		String mid = memberId.getMember_id();
		return mid;
		
	}
	

	/*
	 * // 웹소켓 id 가져오기 private String getMemberId(WebSocketSession session) {
	 * 
	 * (String)request.getSession().getAttribute("loginId"); 또는 ,
	 * session.getAttribute("loginId"); 이렇게 세션값을 가져오나 여기 웹소켓에서는 세션값을
	 * WebSocketSession session 형태로 가져옵니다. 따라서 , 다음과 코드 형태로 세션값을 가져옵니다.
	 * 
	 * 
	 * Map<String, Object> httpSession = session.getAttributes(); String memberId =
	 * (String) httpSession.get("member_id"); if (memberId == null) {
	 * System.out.println("로그인 loginID 가 널일경우  :" + session.getId()); //랜덤 아이디 생성,
	 * 사이트 접속한 사람 전체 //ex ) vawpuj5h, 5qw40sff return session.getId(); } else {
	 * //로그인한 유저 반환 System.out.println("로그인 loginID 가 null아닐때  :" + memberId);
	 * return memberId; } }
	 */

}
