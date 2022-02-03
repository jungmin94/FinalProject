package com.pai.spring.market.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.pai.spring.market.model.vo.Goods;
import com.pai.spring.market.model.vo.GoodsDetailImage;
import com.pai.spring.market.model.vo.GoodsDetails;

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
	public List<Goods> selectOnlyGoodsList(SqlSessionTemplate session, int cPage, int numPerPage) {
	
		return session.selectList("market.onlyGoodsList",null,new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public int selectGoodsCount(SqlSessionTemplate session) {
	
		return session.selectOne("market.selectGoodsCount");
	}
	
	@Override
	public int selectGoodsDetailsCount(SqlSessionTemplate session) {
	
		return session.selectOne("market.selectGoodsDetailsCount");
	}
	
	@Override
	public int selectGoodsCount(SqlSessionTemplate session,Map<String, Object> param) {
	
		return session.selectOne("market.selectSearchGoodsCount",param);
	}
	
	@Override
	public int searchGoodCount(SqlSessionTemplate session,Map<String, Object> param) {
	
		return session.selectOne("market.searchGoodCount",param);
	}
	
	@Override
	public List<Goods> searchList(SqlSessionTemplate session, Map<String, Object> param, int cPage, int numPerPage) {
		
		return session.selectList("market.searchList",param,new RowBounds((cPage-1)*numPerPage,numPerPage));
	}
	
	@Override
	public List<Goods> selectSearchGood(SqlSessionTemplate session, Map<String, Object> param, int cPage, int numPerPage) {
		
		return session.selectList("market.searchGood",param,new RowBounds((cPage-1)*numPerPage,numPerPage));
	}
	
	@Override
	public List<GoodsDetails> selectColorList(SqlSessionTemplate session, String goodsName) {
		
		return session.selectList("market.selectColorList",goodsName);
	}
	
	@Override
	public List<GoodsDetailImage> selectImageList(SqlSessionTemplate session, String goodsName) {
	
		return session.selectList("market.selectImageList",goodsName);
	}

	@Override
	public Goods selectGood(SqlSessionTemplate session,String goodsName) {
		
		return session.selectOne("market.selectGood",goodsName);
	}
	
	@Override
	public List<GoodsDetails> selectEnrolledList(SqlSessionTemplate session, int cPage, int numPerPage) {
		
		return session.selectList("market.selectEnrolledList",null,new RowBounds((cPage-1)*numPerPage,numPerPage));
	}
	
	@Override
	public int updateGood(SqlSessionTemplate session, Map<String, Object> param) {
	
		return session.update("market.updateGood",param);
	}
	
	@Override
	public int deleteGood(SqlSessionTemplate session, Map<String, Object> param) {
	
		return session.delete("market.deleteGood",param);
	}
	
	@Override
	public int selectGoodsDetailsCount(SqlSessionTemplate session, Map<String, Object> param) {
		
		return session.selectOne("market.selectSearchGoodsDetailsCount",param);
	}

	@Override
	public List<GoodsDetails> searchEnrolledList(SqlSessionTemplate session, Map<String, Object> param, int cPage,
			int numPerPage) {
		
		return session.selectList("market.searchEnrolledList",param,new RowBounds((cPage-1)*numPerPage,numPerPage));
	}
	
	@Override
	public int enrollGoodImage(SqlSessionTemplate session, Goods good) {
		
		return session.update("market.enrollGoodImage",good);
	}
	
}
