package com.pai.spring.chatting.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.pai.spring.chatting.model.vo.ChatMessage;
import com.pai.spring.chatting.model.vo.ChatAttendence;

public interface ChattingDao {
	
	int enterChatRoom(ChatAttendence cr, SqlSessionTemplate session);
	
	int insertMessage(ChatMessage cMsg, SqlSessionTemplate session);
	
	int insertChatRoom(ChatMessage cMsg, SqlSessionTemplate session);
	
	int insertChatAttendence(ChatMessage cMsg, SqlSessionTemplate session);

	List<String> attendenceList(String chatroomUser, SqlSessionTemplate session);

	int deleteChatAttendence(ChatMessage cMsg, SqlSessionTemplate session);
}
