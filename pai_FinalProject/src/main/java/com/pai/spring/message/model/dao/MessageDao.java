package com.pai.spring.message.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.pai.spring.message.model.vo.Message;

public interface MessageDao{
	
	int insertMessage(SqlSessionTemplate session, Message msg);
	
	List<Message> selectRecvMessage(SqlSessionTemplate session, String memberId, int cPage, int numPerpage);
	
	int selectRecvMessageCount(SqlSessionTemplate session, String memberId);
	
	Map selectRecvMsgDetail(SqlSessionTemplate session, int msgNo);
	
	List<Message> selectSendMsg(SqlSessionTemplate session, String sendId, int cPage, int numPerpage);
	
	int selectSendMessageCount(SqlSessionTemplate session, String sendId);
	
	Map selectSendMSgDetail(SqlSessionTemplate session, int msgNo);
	
	
	int deleteRecvMsg(SqlSessionTemplate session, int msgNo);

	int deleteSendMsg(SqlSessionTemplate session, int msgNo);
	
	void oldMessageDelete(SqlSessionTemplate session);
	
	void perDelete(SqlSessionTemplate session);
	
	int selectUnreadMsg(SqlSessionTemplate session, String memberId);
	
	int sendMessage(SqlSessionTemplate session, Map param);
	
	int recvMsgRead(SqlSessionTemplate session, int msgNo);
	
	int cancelSendMsg(SqlSessionTemplate session, int msgNo);
}
