package com.pai.spring.message.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.pai.spring.message.model.vo.Message;

public interface MessageDao {
	int insertMessage(SqlSessionTemplate session, Message msg);
	List<Message> selectRecvMessage(SqlSessionTemplate session, String member_id);
}
