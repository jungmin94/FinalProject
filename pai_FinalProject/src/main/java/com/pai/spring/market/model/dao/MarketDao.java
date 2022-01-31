package com.pai.spring.market.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.pai.spring.market.model.vo.Goods;
import com.pai.spring.market.model.vo.GoodsDetailImage;
import com.pai.spring.market.model.vo.GoodsDetails;

public interface MarketDao {

	List<Goods> bestSell(SqlSessionTemplate session);
	
	List<Goods> bestReview(SqlSessionTemplate session);

	List<Goods> selectGoodsList(SqlSessionTemplate session,int cPage,int numPerPage);
	
	int selectGoodsCount(SqlSessionTemplate session);
	
	int selectGoodsCount(SqlSessionTemplate session,Map<String, Object> param);
	
	List<Goods> searchList(SqlSessionTemplate session,Map<String, Object> param, int cPage, int numPerPage);
	
	List<GoodsDetails> selectColorList(SqlSessionTemplate session,String goodsName);
	
	List<GoodsDetailImage> selectImageList(SqlSessionTemplate session,String goodsName);
	
	Goods selectGood(SqlSessionTemplate session,String goodsName);
	
}
