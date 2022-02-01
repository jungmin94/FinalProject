package com.pai.spring.message.model.service;

import java.util.List;

import com.pai.spring.message.model.vo.Message;

public interface MessageService {
	int insertMessage(Message msg);
	List<Message> selectRecvMessage(String memberId);

}
