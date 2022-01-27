package com.pai.spring.market.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.pai.spring.market.model.vo.Goods;

@Repository
public class MarketDaoImpl implements MarketDao {

	@Override
	public List<Goods> bestSell(SqlSessionTemplate session) {
		
		return session.selectList("market.bestSell");
	}

	@Override
	public List<Goods> bestReview(SqlSessionTemplate session) {
	
		return session.selectList("market.bestReview");
	}

	
	
}
