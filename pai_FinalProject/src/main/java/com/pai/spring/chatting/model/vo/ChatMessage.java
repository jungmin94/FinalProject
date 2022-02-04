package com.pai.spring.chatting.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ChatMessage {

	private String chatType;
	private String senderId;
	private String receiverId;
	private String uploadFile;
	private Date chatTime;
	private String chatMessage;
	private String senderMbti;
	private String chatRoomName;
	
}