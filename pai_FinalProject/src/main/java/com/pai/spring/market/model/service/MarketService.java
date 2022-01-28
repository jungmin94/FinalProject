package com.pai.spring.market.model.service;

import java.util.List;

import com.pai.spring.market.model.vo.Goods;

public interface MarketService {

	List<Goods> bestSell();
	
	List<Goods> bestReview();

	List<Goods> selectGoodsList(int cPage,int numPerPage);
	
	int selectGoodsCount();
	
}
