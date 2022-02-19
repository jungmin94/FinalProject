package com.pai.spring.market.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.pai.spring.market.model.vo.Cart;
import com.pai.spring.market.model.vo.Goods;
import com.pai.spring.market.model.vo.GoodsDetailImage;
import com.pai.spring.market.model.vo.GoodsDetails;
import com.pai.spring.market.model.vo.Order;
import com.pai.spring.market.model.vo.OrderDetail;
import com.pai.spring.market.model.vo.Review;
import com.pai.spring.member.model.vo.Member;

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
	
		return session.delete("market.deleteGoodDetails",param);
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
	
	@Override
	public int checkExistGoodDetail(SqlSessionTemplate session, GoodsDetails gd) {
		
		return session.selectOne("market.checkExistGoodDetail",gd);
	}
	
	@Override
	public int enrollGoodsDetails(SqlSessionTemplate session, GoodsDetails gd) {
		
		return session.insert("market.enrollGoodsDetails",gd);
	}
	
	@Override
	public int checkExistGoodName(SqlSessionTemplate session, Goods good) {
	
		return session.selectOne("market.checkExistGoodName",good);
	}
	
	@Override
	public int enrollGoods(SqlSessionTemplate session, Goods good) {
	
		return session.insert("market.enrollGoods",good);
	}
	
	@Override
	public List<GoodsDetails> sizeInvenList(SqlSessionTemplate session, GoodsDetails gd) {
		
		return session.selectList("market.sizeInvenList",gd);
	}
	
	@Override
	public GoodsDetails goodPrice(SqlSessionTemplate session, GoodsDetails gd) {

		return session.selectOne("market.goodPriceAndInven",gd);
	}
	
	@Override
	public int deleteTitleGood(SqlSessionTemplate session, Goods good) {
	
		return session.delete("market.deleteTitleGood",good);
	}
	
	@Override
	public int insertOrder(SqlSessionTemplate session, Order order) {
		
		return session.insert("market.insertOrder",order);
	}
	
	@Override
	public int insertOrderDetail(SqlSessionTemplate session, OrderDetail orderDetail) {
		
		return session.insert("market.insertOrderDetail",orderDetail);
	}
	
	@Override
	public int updateInven(SqlSessionTemplate session, GoodsDetails gd) {

		return session.update("market.updateInven",gd);
	}
	
	@Override
	public List<Order> orderDetailList(SqlSessionTemplate session, int cPage, int numPerPage,Member m) {
	
		return session.selectList("market.orderDetailList",m,new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public int selectOrderDetailCount(SqlSessionTemplate session,Member m) {
	
		return session.selectOne("market.selectOrderDetailCount",m);
	}
	
	@Override
	public int insertReview(SqlSessionTemplate session,Map<String, Object> param) {
	
		return session.insert("market.insertReview",param);
	}
	
	@Override
	public int reviewTotalCount(SqlSessionTemplate session, String goodsName) {
	
		return session.selectOne("market.reviewTotalCount",goodsName);
	}
	
	@Override
	public int updateAvgGrade(SqlSessionTemplate session, Goods good) {
	
		return session.update("market.updateAvgGrade",good);
	}
	
	@Override
	public int updateCheckReviewDo(SqlSessionTemplate session, Map<String, Object> param) {
		
		return session.update("market.updateCheckReviewDo",param);
	}
	
	@Override
	public List<Review> selectReviewList(SqlSessionTemplate session, int cPage, int numPerPage, Member m) {
	
		return session.selectList("market.selectReviewList",m,new RowBounds((cPage-1)*numPerPage,numPerPage));
	}

	@Override
	public int selectReviewCount(SqlSessionTemplate session, Member m) {
	
		return session.selectOne("market.selectReviewCount",m);
	}
	
	@Override
	public int updateReview(SqlSessionTemplate session, Review rv) {
		
		return session.update("market.updateReview",rv);
	}
	
	@Override
	public Review selectReviewUseNo(SqlSessionTemplate session, Review rv) {
	
		return session.selectOne("market.selectReviewUseNo",rv);
	}
	
	@Override
	public int deleteReview(SqlSessionTemplate session, Review rv) {
	
		return session.delete("market.deleteReview",rv);
	}
	
	@Override
	public int updateTotalCell(SqlSessionTemplate session, Goods good) {
		
		return session.update("market.updateTotalCell",good);
	}
	
	@Override
	public List<Review> selectReviewList(SqlSessionTemplate session, int cPage, int numPerPage, String goodsName) {
	
		return session.selectList("market.selectReviewMainList",goodsName,new RowBounds((cPage-1)*numPerPage,numPerPage));
	}
	
	@Override
	public int insertGoodsDetailImage(SqlSessionTemplate session, GoodsDetailImage gdi) {
		
		return session.insert("market.insertGoodsDetailImage",gdi);
	}
	
	@Override
	public int updateGoodsDetailImage(SqlSessionTemplate session, GoodsDetailImage gdi) {
		
		return session.update("market.updateGoodsDetailImage",gdi);
	}
	
	@Override
	public int updateGoodOutput(SqlSessionTemplate session, String goodsName) {
	
		return session.update("market.updateGoodOutput",goodsName);
	}
	
	@Override
	public int totalCartCount(SqlSessionTemplate session,String member_id) {
		
		return session.selectOne("market.totalCartCount",member_id);
	}

	@Override
	public Cart duplicateCheckCart(SqlSessionTemplate session, Cart cart) {
	
		return session.selectOne("market.duplicateCheckCart",cart);
	}

	@Override
	public int addCart(SqlSessionTemplate session, Cart cart) {
	
		return session.insert("market.insertCart",cart);
	}

	@Override
	public int updateCart(SqlSessionTemplate session, Cart cart) {
		
		return session.update("market.updateCart",cart);
	}
	
	@Override
	public List<Cart> selectCartList(SqlSessionTemplate session, String member_id) {
		
		return session.selectList("market.selectCartList",member_id);
	}
	
	@Override
	public int deleteCart(SqlSessionTemplate session, Cart cart) {
	
		return session.delete("market.deleteCart",cart);
	}
	
	
	
}
