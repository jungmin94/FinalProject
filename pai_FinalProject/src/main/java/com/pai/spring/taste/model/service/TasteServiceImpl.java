package com.pai.spring.taste.model.service;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	public int insertTaste(Taste t) {
		return dao.insertTaste(session,t);
		
	}

	@Override
	public Taste selectTasteOne(String member_id) {
		return dao.selectTasteOne(session,member_id);
	
	}
	
	

}
