package com.pai.spring.taste.model.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.pai.spring.taste.model.vo.Taste;

public interface TasteDao {
	Taste selectTasteOne(SqlSessionTemplate session, String member_id);
	int insertTaste(SqlSessionTemplate session, Taste t);

}
