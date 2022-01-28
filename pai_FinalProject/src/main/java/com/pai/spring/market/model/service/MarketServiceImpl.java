package com.pai.spring.market.model.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pai.spring.market.model.dao.MarketDao;
import com.pai.spring.market.model.vo.Goods;

@Service
public class MarketServiceImpl implements MarketService {


	@Autowired
	private SqlSessionTemplate session;
	
	@Autowired
	private MarketDao dao;
	
	@Override
	public List<Goods> bestSell() {
	
		return dao.bestSell(session);
	}

	@Override
	public List<Goods> bestReview() {
		
		return dao.bestReview(session);
	}

	@Override
	public List<Goods> selectGoodsList(int cPage, int numPerPage) {
	
		return dao.selectGoodsList(session,cPage,numPerPage);
	}

	@Override
	public int selectGoodsCount() {
		
		return dao.selectGoodsCount(session);
	}
	
	@Override
	public int selectGoodsCount(Map<String, Object> param) {
	
		return dao.selectGoodsCount(session,param);
	}
	
	@Override
	public List<Goods> searchList(Map<String, Object> param, int cPage, int numPerPage) {
		
		return dao.searchList(session,param,cPage,numPerPage);
	}
	
	
	
}
