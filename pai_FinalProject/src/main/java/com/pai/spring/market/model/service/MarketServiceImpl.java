package com.pai.spring.market.model.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pai.spring.market.model.dao.MarketDao;
import com.pai.spring.market.model.vo.Cart;
import com.pai.spring.market.model.vo.Goods;
import com.pai.spring.market.model.vo.GoodsDetailImage;
import com.pai.spring.market.model.vo.GoodsDetails;
import com.pai.spring.market.model.vo.Order;
import com.pai.spring.market.model.vo.OrderDetail;
import com.pai.spring.market.model.vo.Review;
import com.pai.spring.member.model.vo.Member;

@Service
public class MarketServiceImpl implements MarketService {


	@Autowired
	private SqlSessionTemplate session;
	
	@Autowired
	private MarketDao dao;
	
	@Override
	public List<Goods> bestSell() {
	
		return dao.bestSell(session);
	}

	@Override
	public List<Goods> bestReview() {
		
		return dao.bestReview(session);
	}

	@Override
	public List<Goods> selectGoodsList(int cPage, int numPerPage) {
	
		return dao.selectGoodsList(session,cPage,numPerPage);
	}
	
	@Override
	public List<Goods> selectOnlyGoodsList(int cPage, int numPerPage) {
	
		return dao.selectOnlyGoodsList(session,cPage,numPerPage);
	}

	@Override
	public int selectGoodsCount() {
		
		return dao.selectGoodsCount(session);
	}
	
	@Override
	public int selectGoodsDetailsCount() {
		
		return dao.selectGoodsDetailsCount(session);
	}
	
	@Override
	public int selectGoodsCount(Map<String, Object> param) {
	
		return dao.selectGoodsCount(session,param);
	}
	
	@Override
	public int searchGoodCount(Map<String, Object> param) {
	
		return dao.searchGoodCount(session,param);
	}
	
	@Override
	public List<Goods> searchList(Map<String, Object> param, int cPage, int numPerPage) {
		
		return dao.searchList(session,param,cPage,numPerPage);
	}
	
	@Override
	public List<Goods> selectSearchGood(Map<String, Object> param, int cPage, int numPerPage) {
		
		return dao.selectSearchGood(session,param,cPage,numPerPage);
	}
	
	
	@Override
	public List<GoodsDetails> selectColorList(String goodsName) {
	
		return dao.selectColorList(session, goodsName);
	}
	
	
	@Override
	public List<GoodsDetailImage> selectImageList(String goodsName) {

		return dao.selectImageList(session,goodsName);
	}
	
	@Override
	public Goods selectGood(String goodsName) {
		
		return dao.selectGood(session,goodsName);
	}
	
	@Override
	public List<GoodsDetails> selectEnrolledList(int cPage, int numPerPage) {
		
		return dao.selectEnrolledList(session,cPage,numPerPage);
	}
	
	@Override
	public int updateGood(Map<String, Object> param) {
	
		return dao.updateGood(session,param);
	}
	
	@Override
	public int deleteGood(Map<String, Object> param) {
	
		return dao.deleteGood(session,param);
	}
	
	@Override
	public int selectGoodsDetailsCount(Map<String, Object> param) {
		
		return dao.selectGoodsDetailsCount(session,param);
	}

	@Override
	public List<GoodsDetails> searchEnrolledList(Map<String, Object> param, int cPage, int numPerPage) {
	
		return dao.searchEnrolledList(session,param,cPage,numPerPage);
	}
	
	@Override
	public int enrollGoodImage(Goods good) {
		
		return dao.enrollGoodImage(session,good);
	}
	
	@Override
	public int checkExistGoodDetail(GoodsDetails gd) {
		
		return dao.checkExistGoodDetail(session,gd);
	}
	
	@Override
	public int enrollGoodsDetails(GoodsDetails gd) {
		
		return dao.enrollGoodsDetails(session,gd);
	}
	
	@Override
	public int checkExistGoodName(Goods good) {
		
		return dao.checkExistGoodName(session, good);
	}
	
	@Override
	public int enrollGoods(Goods good) {
		
		return dao.enrollGoods(session, good);
	}
	
	@Override
	public List<GoodsDetails> sizeInvenList(GoodsDetails gd) {
	
		return dao.sizeInvenList(session, gd);
	}
	
	@Override
	public GoodsDetails goodPrice(GoodsDetails gd) {
		
		return dao.goodPrice(session, gd);
	}
	
	@Override
	public int deleteTitleGood(Goods good) {

		return dao.deleteTitleGood(session, good);
	}
	
	@Override
	public int insertOrder(Order order) {
		int result=0;
		result=dao.insertOrder(session, order);
		if(result>0 && !(order.getOrderDetail().isEmpty()) && order.getOrderDetail()!=null) {
			for(OrderDetail orderDetail : order.getOrderDetail()) {
				result=dao.insertOrderDetail(session, orderDetail);
			}
		}
		return result;
	}
	
	@Override
	public int insertOrderDetail(OrderDetail orderDetail) {
	
		return dao.insertOrderDetail(session,orderDetail);
	}
	
	@Override
	public int updateInven(GoodsDetails gd) {
	
		return dao.updateInven(session, gd);
	}
	
	@Override
	public List<Order> orderDetailList(int cPage, int numPerPage,Member m) {
		
		return dao.orderDetailList(session, cPage, numPerPage,m);
	}

	@Override
	public int selectOrderDetailCount(Member m) {
		
		return dao.selectOrderDetailCount(session,m);
	}
	
	@Override
	public int insertReview(Map<String, Object> param) {
		
		return dao.insertReview(session,param);
	}
	
	@Override
	public int reviewTotalCount(String goodsName) {
	
		return dao.reviewTotalCount(session, goodsName);
	}
	
	@Override
	public int updateAvgGrade(Goods good) {
	
		return dao.updateAvgGrade(session, good);
	}
	
	@Override
	public int updateCheckReviewDo(Map<String, Object> param) {
		
		return dao.updateCheckReviewDo(session, param);
	}
	
	@Override
	public List<Review> selectReviewList(int cPage, int numPerPage, Member m) {
	
		return dao.selectReviewList(session, cPage, numPerPage, m);
	}

	@Override
	public int selectReviewCount(Member m) {
	
		return dao.selectReviewCount(session, m);
	}
	
	@Override
	public int updateReview(Review rv) {
		
		return dao.updateReview(session, rv);
	}
	
	@Override
	public Review selectReviewUseNo(Review rv) {

		return dao.selectReviewUseNo(session, rv);
	}

	@Override
	public int deleteReview(Review rv) {

		return dao.deleteReview(session, rv);
	}
	
	@Override
	public int updateTotalCell(Goods good) {

		return dao.updateTotalCell(session, good);
	}
	
	@Override
	public List<Review> selectReviewList(int cPage, int numPerPage, String goodsName) {
		
		return dao.selectReviewList(session, cPage, numPerPage, goodsName);
	}
	
	@Override
	@Transactional
	public int insertGoodsDetailImage(List<GoodsDetailImage> filenames) {
		int result=0;
		if(!filenames.isEmpty()) {
			for(GoodsDetailImage gdi : filenames) {
				result = dao.insertGoodsDetailImage(session, gdi);
			}
		}
		return result;
	}
	
	@Override
	@Transactional
	public int updateGoodsDetailImage(List<GoodsDetailImage> filenames) {
		int result=0;
		if(!filenames.isEmpty()) {
			for(GoodsDetailImage gdi : filenames) {
				result = dao.updateGoodsDetailImage(session, gdi);
			}
		}
		return result;
	}
	
	@Override
	public int updateGoodOutput(String goodsName) {
		
		return dao.updateGoodOutput(session, goodsName);
	}
	
	@Override
	public int totalCartCount(String member_id) {
	
		return dao.totalCartCount(session,member_id);
	}

	@Override
	public Cart duplicateCheckCart(Cart cart) {
		
		return dao.duplicateCheckCart(session, cart);
	}

	@Override
	public int addCart(Cart cart) {
	
		return dao.addCart(session, cart);
	}

	@Override
	public int updateCart(Cart cart) {

		return dao.updateCart(session, cart);
	}
	
	@Override
	public List<Cart> selectCartList(String member_id) {
	
		return dao.selectCartList(session, member_id);
	}
	
	@Override
	public int deleteCart(Cart cart) {
		
		return dao.deleteCart(session, cart);
	}
	
}
