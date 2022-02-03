package com.pai.spring.chatting.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.pai.spring.chatting.model.service.ChattingService;
import com.pai.spring.chatting.model.vo.ChatAttendence;
import com.pai.spring.chatting.model.vo.ChatMessage;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/chatting")
@Slf4j
public class ChattingController {
	
	@Autowired
	private ChattingService chattingService;

	@RequestMapping("/toSeeChatroomInfo.do")
	public String chatRoomInfo() {
		
		return "chatting/enterChattingRoom";
		
	}
	
	@RequestMapping("/toEnterChatroom.do")
	public String enterChattingRoom(String id) {
		return "chatting/chattingArea";
		
	}
	
	@RequestMapping(value = "/getAttendenceList.do", method = RequestMethod.POST)
	public @ResponseBody List<String> attendenceList (@RequestParam(value="chatroomUser") String chatroomUser, String chatroomName, String chatUserMbti) throws Exception {
		
		ChatMessage cMsg = ChatMessage.builder().senderId(chatroomUser).chatRoomName(chatroomName).senderMbti(chatUserMbti).build();
		
		int result = chattingService.insertChatRoom(cMsg);
		// 읽어오는 서비스 호출
		List<String> resultList = chattingService.attendenceList(chatroomUser);

		Map<String, String> resultMap = new HashMap<>();
		
		for (int i = 0; i < resultList.size(); i++) {
			resultMap.put("userId", chatroomUser);
		}
		
		
		return resultList;
	}
	
	@RequestMapping(value = "/removeAttendenceList.do", method = RequestMethod.POST)
	public @ResponseBody List<String> removeFromAttendenceList (@RequestParam(value="chatroomUser") String chatroomUser, String chatroomName, String chatUserMbti) throws Exception {
		
		ChatMessage cMsg = ChatMessage.builder().senderId(chatroomUser).chatRoomName(chatroomName).senderMbti(chatUserMbti).build();
		
		int result = chattingService.deleteChatRoom(cMsg);
		// 읽어오는 서비스 호출
		List<String> resultList = chattingService.attendenceList(chatroomUser);

		Map<String, String> resultMap = new HashMap<>();
		
		for (int i = 0; i < resultList.size(); i++) {
			resultMap.put("userId", chatroomUser);
		}
		
		
		return resultList;
	}
	
	

}
