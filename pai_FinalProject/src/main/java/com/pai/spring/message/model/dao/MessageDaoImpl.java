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

	
	
	
	
}
