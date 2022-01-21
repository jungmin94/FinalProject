package com.pai.spring.taste.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.pai.spring.taste.model.vo.Taste;

@Repository
public class TasteDaoImpl implements TasteDao {

	@Override
	public int insertTaste(SqlSessionTemplate session, Taste t) {
		return session.insert("taste.insertTaste",t);
	}

}
