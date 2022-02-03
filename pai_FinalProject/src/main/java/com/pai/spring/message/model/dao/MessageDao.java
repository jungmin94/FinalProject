package com.pai.spring.message.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.pai.spring.message.model.vo.Message;

public interface MessageDao{
	
	int insertMessage(SqlSessionTemplate session, Message msg);
	
	List<Message> selectRecvMessage(SqlSessionTemplate session, String memberId, int cPage, int numPerpage);
	
	int selectRecvMessageCount(SqlSessionTemplate session, String memberId);
	
	Message selectRecvMsgDetail(SqlSessionTemplate session, int msgNo);
}
