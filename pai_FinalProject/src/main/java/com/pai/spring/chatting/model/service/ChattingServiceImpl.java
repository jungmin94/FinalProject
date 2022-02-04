package com.pai.spring.chatting.model.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pai.spring.chatting.model.dao.ChattingDao;
import com.pai.spring.chatting.model.vo.ChatMessage;
import com.pai.spring.chatting.model.vo.ChatAttendence;
@Service
public class ChattingServiceImpl implements ChattingService {

	@Autowired
	private ChattingDao chattingDao;
	
	@Autowired
	SqlSessionTemplate session;
	
	@Override
	public int enterChatRoom(ChatAttendence cr) {
		return chattingDao.enterChatRoom(cr, session);
	}
	
	@Override
	public int insertMessage(ChatMessage cMsg) {
		return chattingDao.insertMessage(cMsg, session);
	}
	
	@Override
	public int insertChatRoom(ChatMessage cMsg) {
		int result = chattingDao.insertChatRoom(cMsg, session);
		if (result > 0) {
			return chattingDao.insertChatAttendence(cMsg, session);
		} else {
			return 0;
		}
	}

	@Override
	public List<String> attendenceList(String chatroomUser) {
		// TODO Auto-generated method stub
		List<String> result = chattingDao.attendenceList(chatroomUser, session);
		return result;
	}
	
	@Override
	public int deleteChatRoom(ChatMessage cMsg) {
		return chattingDao.deleteChatAttendence(cMsg, session);
	}
}
