package com.pai.spring.market.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.pai.spring.market.model.vo.Goods;

public interface MarketDao {

	List<Goods> bestSell(SqlSessionTemplate session);
	
	List<Goods> bestReview(SqlSessionTemplate session);

	List<Goods> selectGoodsList(SqlSessionTemplate session,int cPage,int numPerPage);
	
	int selectGoodsCount(SqlSessionTemplate session);
	
	
}
