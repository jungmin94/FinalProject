package com.pai.spring.message.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.scheduling.annotation.Scheduled;

import com.pai.spring.message.model.vo.Message;

public interface MessageService {
	
	int insertMessage(Message msg);
	
	List<Message> selectRecvMessage(String memberId, int cPage, int numPerpage);
	
	int selectRecvMessageCount(String memberId);
	
	Map selectRecvMsgDetail(int msgNo);
	
	int recvMsgRead(int msgNo);
	
	List<Message> selectSendMsg(String sendId, int cPage, int numPerpage);
	
	int selectSendMessageCount(String sendId);

	Map selectSendMsgDetail(int msgNo);
	
	int deleteRecvMsg(int msgNo);
	
	int saveMsgPut(int msgNo);
	
	int deleteSendMsg(int msgNo);
	
	void oldMessageDelete();
	
	void perDelete();
	
	//받은편지중 읽지않은 쪽지 갯수
	int selectUnreadMsg(String memberId);
	
	int sendMessage(Map param);
	
	int cancelSendMsg(int msgNo);
	
	List<Message> selectSaveMessage(String memberId, int cPage, int numPerpage);
	
	int selectSaveMessageCount(String memberId);
	
	Map selectSaveMsgDetail(int msgNo);
	
	int saveMsgRead(int msgNo);
	
	int deleteSaveMsg(int msgNo);
	
	int saveMsgExport(int msgNo);
	
}
