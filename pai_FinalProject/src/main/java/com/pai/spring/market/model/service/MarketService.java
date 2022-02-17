package com.pai.spring.market.model.service;

import java.util.List;
import java.util.Map;

import com.pai.spring.market.model.vo.Goods;
import com.pai.spring.market.model.vo.GoodsDetailImage;
import com.pai.spring.market.model.vo.GoodsDetails;
import com.pai.spring.market.model.vo.Order;
import com.pai.spring.market.model.vo.OrderDetail;

public interface MarketService {

	List<Goods> bestSell();
	
	List<Goods> bestReview();

	List<Goods> selectGoodsList(int cPage,int numPerPage);

	List<Goods> selectOnlyGoodsList(int cPage,int numPerPage);
	
	int selectGoodsCount();

	int selectGoodsDetailsCount();
	
	int selectGoodsCount(Map<String,Object> param);

	int selectGoodsDetailsCount(Map<String,Object> param);
	
	int searchGoodCount(Map<String,Object> param);

	List<Goods> searchList(Map<String,Object> param,int cPage,int numPerPage);

	List<Goods> selectSearchGood(Map<String,Object> param,int cPage,int numPerPage);
	
	List<GoodsDetails> selectColorList(String goodsName);
	
	List<GoodsDetailImage> selectImageList(String goodsName);
	
	Goods selectGood(String goodsName);
	
	List<GoodsDetails> selectEnrolledList(int cPage,int numPerPage);
	
	int updateGood(Map<String,Object> param);

	int deleteGood(Map<String,Object> param);
	
	List<GoodsDetails> searchEnrolledList(Map<String,Object> param,int cPage,int numPerPage);
	
	int enrollGoodImage(Goods good);
	
	int checkExistGoodDetail(GoodsDetails gd);

	int enrollGoodsDetails(GoodsDetails gd);

	int checkExistGoodName(Goods good);
	
	int enrollGoods(Goods good);
	
	List<GoodsDetails> sizeInvenList(GoodsDetails gd);
	
	GoodsDetails goodPrice(GoodsDetails gd);
	
	int deleteTitleGood(Goods good);
	
	int insertOrder(Order order);
	
	int insertOrderDetail(OrderDetail orderDetail);
	
	int updateInven(GoodsDetails gd);
	
	List<Order> orderDetailList(int cPage,int numPerPage);
	
	int selectOrderDetailCount();
	
}
