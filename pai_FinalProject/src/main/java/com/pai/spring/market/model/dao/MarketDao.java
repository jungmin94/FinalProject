package com.pai.spring.market.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.pai.spring.market.model.vo.Goods;
import com.pai.spring.market.model.vo.GoodsDetailImage;
import com.pai.spring.market.model.vo.GoodsDetails;
import com.pai.spring.market.model.vo.Order;
import com.pai.spring.market.model.vo.OrderDetail;
import com.pai.spring.market.model.vo.Review;
import com.pai.spring.member.model.vo.Member;

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
	
	List<Order> orderDetailList(SqlSessionTemplate session,int cPage,int numPerPage,Member m);
	
	int selectOrderDetailCount(SqlSessionTemplate session,Member m);
	
	int insertReview(SqlSessionTemplate session,Map<String,Object> param);
	
	int reviewTotalCount(SqlSessionTemplate session,String goodsName);
	
	int updateAvgGrade(SqlSessionTemplate session,Goods good);
	
	int updateCheckReviewDo(SqlSessionTemplate session,Map<String,Object> param);
	
	List<Review> selectReviewList(SqlSessionTemplate session,int cPage,int numPerPage,Member m);
	
	int selectReviewCount(SqlSessionTemplate session,Member m);
	
	int updateReview(SqlSessionTemplate session,Review rv);
	
	Review selectReviewUseNo(SqlSessionTemplate session,Review rv);
	
	int deleteReview(SqlSessionTemplate session,Review rv);
	
	int updateTotalCell(SqlSessionTemplate session,Goods good);
	
	List<Review> selectReviewList(SqlSessionTemplate session,int cPage,int numPerPage,String goodsName);
	
	int insertGoodsDetailImage(SqlSessionTemplate session,GoodsDetailImage gdi);

	int updateGoodsDetailImage(SqlSessionTemplate session,GoodsDetailImage gdi);
	
	int updateGoodOutput(SqlSessionTemplate session,String goodsName);
	
}
