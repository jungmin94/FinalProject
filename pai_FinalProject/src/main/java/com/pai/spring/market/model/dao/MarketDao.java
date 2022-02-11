package com.pai.spring.market.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.pai.spring.market.model.vo.Goods;
import com.pai.spring.market.model.vo.GoodsDetailImage;
import com.pai.spring.market.model.vo.GoodsDetails;
import com.pai.spring.market.model.vo.Order;
import com.pai.spring.market.model.vo.OrderDetail;

public interface MarketDao {

	List<Goods> bestSell(SqlSessionTemplate session);
	
	List<Goods> bestReview(SqlSessionTemplate session);

	List<Goods> selectGoodsList(SqlSessionTemplate session,int cPage,int numPerPage);

	List<Goods> selectOnlyGoodsList(SqlSessionTemplate session,int cPage,int numPerPage);
	
	int selectGoodsCount(SqlSessionTemplate session);

	int selectGoodsDetailsCount(SqlSessionTemplate session);
	
	int selectGoodsCount(SqlSessionTemplate session,Map<String, Object> param);
	
	int selectGoodsDetailsCount(SqlSessionTemplate session,Map<String,Object> param);
	
	int searchGoodCount(SqlSessionTemplate session,Map<String,Object> param);
	
	List<Goods> searchList(SqlSessionTemplate session,Map<String, Object> param, int cPage, int numPerPage);
	
	List<Goods> selectSearchGood(SqlSessionTemplate session,Map<String,Object> param,int cPage,int numPerPage);
	
	List<GoodsDetails> selectColorList(SqlSessionTemplate session,String goodsName);
	
	List<GoodsDetailImage> selectImageList(SqlSessionTemplate session,String goodsName);
	
	Goods selectGood(SqlSessionTemplate session,String goodsName);
	
	List<GoodsDetails> selectEnrolledList(SqlSessionTemplate session,int cPage,int numPerPage);
	
	int updateGood(SqlSessionTemplate session,Map<String,Object> param);

	int deleteGood(SqlSessionTemplate session,Map<String,Object> param);
	
	List<GoodsDetails> searchEnrolledList(SqlSessionTemplate session,Map<String,Object> param,int cPage,int numPerPage);
	
	int enrollGoodImage(SqlSessionTemplate session,Goods good);
	
	int checkExistGoodDetail(SqlSessionTemplate session,GoodsDetails gd);
	
	int enrollGoodsDetails(SqlSessionTemplate session,GoodsDetails gd);
	
	int checkExistGoodName(SqlSessionTemplate session,Goods good);
	
	int enrollGoods(SqlSessionTemplate session,Goods good);
	
	List<GoodsDetails> sizeInvenList(SqlSessionTemplate session,GoodsDetails gd);
	
	GoodsDetails goodPrice(SqlSessionTemplate session,GoodsDetails gd);
	
	int deleteTitleGood(SqlSessionTemplate session,Goods good);
	
	int insertOrder(SqlSessionTemplate session,Order order);
	
	int insertOrderDetail(SqlSessionTemplate session,OrderDetail orderDetail);
	
	int updateInven(SqlSessionTemplate session,GoodsDetails gd);
	
	List<Order> orderDetailList(SqlSessionTemplate session,int cPage,int numPerPage);
	
	int selectOrderDetailCount(SqlSessionTemplate session);
	
}
