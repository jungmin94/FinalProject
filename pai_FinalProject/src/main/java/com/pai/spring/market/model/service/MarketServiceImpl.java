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
	public List<Goods> selectOnlyGoodsList(int cPage, int numPerPage) {
	
		return dao.selectOnlyGoodsList(session,cPage,numPerPage);
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
	public int searchGoodCount(Map<String, Object> param) {
	
		return dao.searchGoodCount(session,param);
	}
	
	@Override
	public List<Goods> searchList(Map<String, Object> param, int cPage, int numPerPage) {
		
		return dao.searchList(session,param,cPage,numPerPage);
	}
	
	@Override
	public List<Goods> selectSearchGood(Map<String, Object> param, int cPage, int numPerPage) {
		
		return dao.selectSearchGood(session,param,cPage,numPerPage);
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
	
	@Override
	public int deleteGood(Map<String, Object> param) {
	
		return dao.deleteGood(session,param);
	}
	
	@Override
	public int selectGoodsDetailsCount(Map<String, Object> param) {
		
		return dao.selectGoodsDetailsCount(session,param);
	}

	@Override
	public List<GoodsDetails> searchEnrolledList(Map<String, Object> param, int cPage, int numPerPage) {
	
		return dao.searchEnrolledList(session,param,cPage,numPerPage);
	}
	
	@Override
	public int enrollGoodImage(Goods good) {
		
		return dao.enrollGoodImage(session,good);
	}
	
	@Override
	public int checkExistGoodDetail(GoodsDetails gd) {
		
		return dao.checkExistGoodDetail(session,gd);
	}
	
	@Override
	public int enrollGoodsDetails(GoodsDetails gd) {
		
		return dao.enrollGoodsDetails(session,gd);
	}
	
	@Override
	public int checkExistGoodName(Goods good) {
		
		return dao.checkExistGoodName(session, good);
	}
	
	@Override
	public int enrollGoods(Goods good) {
		
		return dao.enrollGoods(session, good);
	}
	
}
