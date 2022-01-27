package com.pai.spring.market.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
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

	@Override
	public List<Goods> selectGoodsList(SqlSessionTemplate session, int cPage, int numPerPage) {
	
		return session.selectList("market.goodsList",null,new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public int selectGoodsCount(SqlSessionTemplate session) {
	
		return session.selectOne("market.selectGoodsCount");
	}
	
}
