package com.pai.spring.message.model.dao;

import java.util.List;

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
	public List<Message> selectRecvMessage(SqlSessionTemplate session, String member_id) {
		return session.selectList("message.selectRecvMessage",member_id);
	}

	
}
