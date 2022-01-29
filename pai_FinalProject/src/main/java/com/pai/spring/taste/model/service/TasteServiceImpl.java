package com.pai.spring.taste.model.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pai.spring.member.model.vo.Member;
import com.pai.spring.taste.model.dao.TasteDao;
import com.pai.spring.taste.model.vo.Taste;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class TasteServiceImpl implements TasteService{
	
	@Autowired
	private SqlSessionTemplate session;
	
	@Autowired
	private TasteDao dao;

	@Override
	public int insertTaste(Map param) {
		return dao.insertTaste(session,param);
		
	}

	@Override
	public Taste selectTasteOne(String member_id) {
		return dao.selectTasteOne(session,member_id);
	
	}

	@Override
	public List<Member> selectTasteList(Map param) {
		return dao.selectTasteList(session, param);
	}

	@Override
	public int updateTaste(Map param) {
		return dao.updateTaste(session, param);
	}
	
	
	
	

}
