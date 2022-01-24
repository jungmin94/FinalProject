package com.pai.spring.taste.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.pai.spring.member.model.vo.Member;
import com.pai.spring.taste.model.vo.Taste;

@Repository
public class TasteDaoImpl implements TasteDao {

	
	
	@Override
	public Taste selectTasteOne(SqlSessionTemplate session, String member_id) {
		return session.selectOne("taste.selectTasteOne", member_id);
	}

	@Override
	public int insertTaste(SqlSessionTemplate session, Map param) {
		return session.insert("taste.insertTaste",param);
	}

	@Override
	public List<Member> selectTasteList(SqlSessionTemplate session, Map param) {
		return session.selectList("taste.selectTasteList", param);
	}

	@Override
	public int updateTaste(SqlSessionTemplate session, Map param) {
		return session.update("taste.updateTaste",param);
	}
	
	

}
