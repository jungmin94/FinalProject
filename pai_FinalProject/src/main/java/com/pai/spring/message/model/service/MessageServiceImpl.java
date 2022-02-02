package com.pai.spring.message.model.service;

import java.util.List;
import java.util.Map;

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
	public List<Message> selectRecvMessage(String memberId, int cPage, int numPerpage) {
		return dao.selectRecvMessage(session,memberId, cPage, numPerpage);
	}

	@Override
	public int selectRecvMessageCount(String memberId) {
		return dao.selectRecvMessageCount(session, memberId);
	}

	@Override
	public Message selectRecvMsgDetail(int msgNo) {
		return dao.selectRecvMsgDetail(session, msgNo);
	}
	
	
	
	
}
