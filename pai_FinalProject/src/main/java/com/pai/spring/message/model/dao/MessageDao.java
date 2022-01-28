package com.pai.spring.message.model.dao;

import org.mybatis.spring.SqlSessionTemplate;

import com.pai.spring.message.model.vo.Message;

public interface MessageDao {
	int insertMessage(SqlSessionTemplate session, Message msg);

}
