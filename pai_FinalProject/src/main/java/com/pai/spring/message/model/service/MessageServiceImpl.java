package com.pai.spring.message.model.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pai.spring.message.model.dao.MessageDao;
import com.pai.spring.message.model.vo.Message;

@Service
public class MessageServiceImpl implements MessageService {

	@Autowired
	private SqlSessionTemplate session;
	
	@Autowired
	private MessageDao dao;

	@Override
	public int insertMessage(Message msg) {
		return dao.insertMessage(session,msg);
	}

	@Override
	public List<Message> selectRecvMessage(String memberId) {
		return dao.selectRecvMessage(session,memberId);
	}
	
	
	
	
}
