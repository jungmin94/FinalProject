package com.pai.spring.market.model.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pai.spring.market.model.dao.MarketDao;
import com.pai.spring.market.model.vo.Goods;
import com.pai.spring.market.model.vo.GoodsDetailImage;
import com.pai.spring.market.model.vo.GoodsDetails;

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
	public int selectGoodsDetailsCount() {
		
		return dao.selectGoodsDetailsCount(session);
	}
	
	@Override
	public int selectGoodsCount(Map<String, Object> param) {
	
		return dao.selectGoodsCount(session,param);
	}
	
	@Override
	public List<Goods> searchList(Map<String, Object> param, int cPage, int numPerPage) {
		
		return dao.searchList(session,param,cPage,numPerPage);
	}
	
	
	@Override
	public List<GoodsDetails> selectColorList(String goodsName) {
	
		return dao.selectColorList(session, goodsName);
	}
	
	
	@Override
	public List<GoodsDetailImage> selectImageList(String goodsName) {

		return dao.selectImageList(session,goodsName);
	}
	
	@Override
	public Goods selectGood(String goodsName) {
		
		return dao.selectGood(session,goodsName);
	}
	
	@Override
	public List<GoodsDetails> selectEnrolledList(int cPage, int numPerPage) {
		
		return dao.selectEnrolledList(session,cPage,numPerPage);
	}
	
	@Override
	public int updateGood(Map<String, Object> param) {
	
		return dao.updateGood(session,param);
	}
	
}
