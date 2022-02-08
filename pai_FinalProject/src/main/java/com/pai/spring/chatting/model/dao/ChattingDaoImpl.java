package com.pai.spring.chatting.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.pai.spring.chatting.model.vo.ChatMessage;
import com.pai.spring.chatting.model.vo.ChatAttendence;

@Repository
public class ChattingDaoImpl implements ChattingDao{
	
	@Override
	public int enterChatRoom(ChatAttendence cr, SqlSessionTemplate session) {
		return session.insert("chatting.enterChatRoom", cr);
	}
	
	@Override
	public int insertMessage(ChatMessage cMsg, SqlSessionTemplate session) {
		return session.insert("chatting.insertMessage",cMsg);
	}
	
	@Override
	public int insertChatRoom(ChatMessage cMsg, SqlSessionTemplate session) {
		return session.insert("chatting.insertChatRoom", cMsg);
	}
	
	@Override
	public int insertChatAttendence(ChatMessage cMsg, SqlSessionTemplate session) {
		return session.insert("chatting.insertChatAttendence", cMsg);
	}

	@Override
	public List<String> attendenceList(String chatroomName, SqlSessionTemplate session) {
		// TODO Auto-generated method stub
		return session.selectList("chatting.selectAttendenceList", chatroomName);
	}
	
	@Override
	public List<String>attendenceChatroom (SqlSessionTemplate session) {
		return session.selectList("chatting.selectChatroomList");
	}
	
	@Override
	public int deleteChatAttendence(ChatMessage cMsg, SqlSessionTemplate session) {
		return session.delete("chatting.deleteChatAttendence", cMsg);
	}

}
