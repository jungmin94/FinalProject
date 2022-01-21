package com.pai.spring.taste.model.dao;

import org.mybatis.spring.SqlSessionTemplate;

import com.pai.spring.taste.model.vo.Taste;

public interface TasteDao {
	int insertTaste(SqlSessionTemplate session, Taste t);

}
