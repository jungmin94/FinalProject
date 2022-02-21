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
	public void oldMessageDelete(SqlSessionTemplate session) {
		session.delete("message.oldMessageDelete");
	}
	
	
	

	@Override
	public void perDelete(SqlSessionTemplate session) {
		session.delete("message.perDelete");
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

	@Override
	public List<Message> selectSaveMessage(SqlSessionTemplate session, String memberId, int cPage, int numPerpage) {
		RowBounds rb=new RowBounds((cPage-1)*numPerpage,numPerpage);
		return session.selectList("message.selectSaveMessage", memberId, rb);
	}

	@Override
	public int selectSaveMessageCount(SqlSessionTemplate session, String memberId) {
		return session.selectOne("message.selectSaveMessageCount",memberId);
	}

	@Override
	public int saveMsgPut(SqlSessionTemplate session, int msgNo) {
		return session.update("message.saveMsgPut", msgNo);
	}

	@Override
	public Map selectSaveMsgDetail(SqlSessionTemplate session, int msgNo) {
		return session.selectOne("message.selectSaveMsgDetail",msgNo);
	}

	@Override
	public int saveMsgRead(SqlSessionTemplate session, int msgNo) {
		return session.update("message.saveMsgRead",msgNo);
	}

	@Override
	public int deleteSaveMsg(SqlSessionTemplate session, int msgNo) {
		return session.update("message.deleteSaveMsg", msgNo);
	}

	@Override
	public int saveMsgExport(SqlSessionTemplate session, int msgNo) {
		return session.update("message.saveMsgExport",msgNo);
	}

	@Override
	public List<Message> selectRecvMsgSearch(SqlSessionTemplate session, Map param, int cPage, int numPerpage) {
		RowBounds rb=new RowBounds((cPage-1)*numPerpage,numPerpage);
		return session.selectList("message.selectRecvMsgSearch", param, rb);
	}

	@Override
	public int selectRecvMsgSearchCount(SqlSessionTemplate session, Map param) {
		return session.selectOne("message.selectRecvMsgSearchCount",param);
	}

	@Override
	public List<Message> selectSendMsgSearch(SqlSessionTemplate session, Map param, int cPage, int numPerpage) {
		RowBounds rb=new RowBounds((cPage-1)*numPerpage,numPerpage);
		return session.selectList("message.selectSendMsgSearch", param, rb);
	}

	@Override
	public int selectSendMsgSearchCount(SqlSessionTemplate session, Map param) {
		return session.selectOne("message.selectSendMsgSearchCount", param);
	}

	@Override
	public List<Message> selectSaveMsgSearch(SqlSessionTemplate session, Map param, int cPage, int numPerpage) {
		RowBounds rb=new RowBounds((cPage-1)*numPerpage,numPerpage);
		return session.selectList("message.selectSaveMsgSearch", param, rb);
	}

	@Override
	public int selectSaveMsgSearchCount(SqlSessionTemplate session, Map param) {
		return session.selectOne("message.selectSaveMsgSearchCount", param);
	}


	
	
	
	
	
}
