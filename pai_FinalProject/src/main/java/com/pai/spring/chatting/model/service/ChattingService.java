package com.pai.spring.chatting.model.service;

import com.pai.spring.chatting.model.vo.ChatMessage;

import java.util.List;

import com.pai.spring.chatting.model.vo.ChatAttendence;

public interface ChattingService {
	
	int enterChatRoom(ChatAttendence cr);
	
	int insertMessage(ChatMessage cMsg);
	
	int insertChatRoom(ChatMessage cMsg);
	
	List<String> attendenceList(String chatroomName);
	
	List<String> attendenceChatroom();
	
	int deleteChatRoom(ChatMessage cMsg);

}
