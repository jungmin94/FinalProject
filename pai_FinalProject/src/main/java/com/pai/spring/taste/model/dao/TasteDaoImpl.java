package com.pai.spring.taste.model.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.pai.spring.taste.model.vo.Taste;

@Repository
public class TasteDaoImpl implements TasteDao {

	
	
	@Override
	public Taste selectTasteOne(SqlSessionTemplate session, String member_id) {
		return session.selectOne("taste.selectTasteOne", member_id);
	}

	@Override
	public int insertTaste(SqlSessionTemplate session, Taste t) {
		return session.insert("taste.insertTaste",t);
	}

}
