package com.pai.spring.market.model.service;

import java.util.List;
import java.util.Map;

import com.pai.spring.market.model.vo.Goods;
import com.pai.spring.market.model.vo.GoodsDetails;

public interface MarketService {

	List<Goods> bestSell();
	
	List<Goods> bestReview();

	List<Goods> selectGoodsList(int cPage,int numPerPage);
	
	int selectGoodsCount();
	
	int selectGoodsCount(Map<String,Object> param);
	
	List<Goods> searchList(Map<String,Object> param,int cPage,int numPerPage);
	
	List<GoodsDetails> selectColorList(String goodsName);
	
}
