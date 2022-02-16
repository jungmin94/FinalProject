package com.pai.spring.message.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.pai.spring.message.model.vo.Message;

@Repository
public class MessageDaoImpl implements MessageDao {

	@Override
	public int insertMessage(SqlSessionTemplate session, Message msg) {
		return session.insert("message.insertMessage",msg);
	}

	@Override
	public List<Message> selectRecvMessage(SqlSessionTemplate session, String memberId, int cPage, int numPerpage) {
		RowBounds rb=new RowBounds((cPage-1)*numPerpage,numPerpage);
		return session.selectList("message.selectRecvMessage", memberId, rb);
	}

	@Override
	public int selectRecvMessageCount(SqlSessionTemplate session, String memberId) {
		return session.selectOne("message.selectRecvMessageCount",memberId);
	}

	@Override
	public Map selectRecvMsgDetail(SqlSessionTemplate session, int msgNo) {
		return session.selectOne("message.selectRecvMsgDetail",msgNo);
	}

	@Override
	public List<Message> selectSendMsg(SqlSessionTemplate session, String sendId, int cPage, int numPerpage) {
		RowBounds rb=new RowBounds((cPage-1)*numPerpage,numPerpage);
		return session.selectList("message.selectSendMessage", sendId, rb);
	}

	@Override
	public int selectSendMessageCount(SqlSessionTemplate session, String sendId) {
		return session.selectOne("message.selectSendMessageCount", sendId);
	}

	
	
	
	
	@Override
	public Map selectSendMSgDetail(SqlSessionTemplate session, int msgNo) {
		return session.selectOne("message.selectSendMsgDetail", msgNo);
	}

	@Override
	public int deleteRecvMsg(SqlSessionTemplate session, int msgNo) {
		return session.update("message.deleteRecvMsg",msgNo);
	}
	
	
	@Override
	public int deleteSendMsg(SqlSessionTemplate session, int msgNo) {
		return session.update("message.deleteSendMsg",msgNo);
	}

	@Override
	public void autoMessageDelete(SqlSessionTemplate session) {
		session.delete("message.autoMessageDelete");
	}

	@Override
	public int selectUnreadMsg(SqlSessionTemplate session, String memberId) {
		return session.selectOne("message.selectUnreadMsg",memberId);
	}

	@Override
	public int sendMessage(SqlSessionTemplate session, Map param) {
		return session.insert("message.sendMessage",param);
	}

	@Override
	public int recvMsgRead(SqlSessionTemplate session, int msgNo) {
		return session.update("message.recvMsgRead",msgNo);
	}

	@Override
	public int cancelSendMsg(SqlSessionTemplate session, int msgNo) {
		return session.delete("message.cancelSendMsg",msgNo);
	}


	
	
	
	
}
