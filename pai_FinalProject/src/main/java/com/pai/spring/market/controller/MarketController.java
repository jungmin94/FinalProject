package com.pai.spring.market.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.pai.spring.board.model.vo.AttachFile;
import com.pai.spring.board.model.vo.Board;
import com.pai.spring.common.PageFactory;
import com.pai.spring.market.model.service.MarketService;
import com.pai.spring.market.model.vo.Goods;
import com.pai.spring.market.model.vo.GoodsDetailImage;
import com.pai.spring.market.model.vo.GoodsDetails;
import com.pai.spring.market.model.vo.Order;
import com.pai.spring.market.model.vo.OrderDetail;
import com.pai.spring.market.model.vo.Review;
import com.pai.spring.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/market")
@SessionAttributes({"loginMember"})
@Slf4j
public class MarketController {
	
	@Autowired
	private MarketService service;

	/*==============================================================================================
					ask-context.xml																			사용자 로직
	===============================================================================================*/
	
	/* 메인페이지 불러오기 */
	@RequestMapping("/mainView.do")
	public ModelAndView mainView(ModelAndView mv) {
		
		List<Goods> topSellList = service.bestSell();
		List<Goods> topGradeList = service.bestReview();
		
		mv.addObject("topSellList",topSellList);
		mv.addObject("topGradeList",topGradeList);
		mv.setViewName("market/mainView");
		
		return mv;
		
	}
	
	/* 전체상품 페이지 리스트 불러오기 */
	// 상세등록이 하나라도 되어 있어야 화면에 리스트로 출력이 된다
	// 즉, Goods는 등록되어있으나 GoodsDetails가 하나라도 등록되어있지 않다면 리스트 출력 X
	@RequestMapping("/goodsList.do")
	public ModelAndView goodsList(@RequestParam(value="cPage",defaultValue="1") int cPage,
			@RequestParam(value="numPerPage",defaultValue="12") int numPerPage,ModelAndView mv) {
		
	List<Goods> list = service.selectGoodsList(cPage,numPerPage);	
	
	int totalData = service.selectGoodsCount();
		
	mv.addObject("pageBar",PageFactory.getPageBar(totalData, cPage, numPerPage,5, "goodsList.do", null));	
	mv.addObject("goodsList",list);	
	
	mv.setViewName("market/marketList");
	
	return mv;
	}
	
	/* 전체상품 페이지 검색한 결과 불러오기 */
	@RequestMapping("/searchList.do")
	public ModelAndView searchList(@RequestParam Map<String,Object> param,@RequestParam(value="cPage",defaultValue="1") int cPage,
			@RequestParam(value="numPerPage",defaultValue="12") int numPerPage,ModelAndView mv) {
		
		System.out.println(param);
		List<Goods> list = service.searchList(param,cPage,numPerPage);
		
		int totalData = service.selectGoodsCount(param);
		
		mv.addObject("pageBar",PageFactory.getPageBar(totalData, cPage, numPerPage,5, "searchList.do", null));
		mv.addObject("goodsList",list);	
		
		System.out.println("디비 후 : "+list);
		
		mv.setViewName("market/marketList");
		
		return mv;
	}
	
	/* 상품 상세페이지 불러오기 */
	@RequestMapping("/goodsDetailView.do")
	public ModelAndView goodsDetailView(String goodsName,@RequestParam(value="cPage",defaultValue="1") int cPage,
			@RequestParam(value="numPerPage",defaultValue="10") int numPerPage,ModelAndView mv) {
		
		// 해당 제품 정보 가져오기
		Goods good = service.selectGood(goodsName);
		
		// 해당 제품 제품 상세 사진 가져오기
		List<GoodsDetailImage> imageList = service.selectImageList(goodsName);
	
		// 해당 제품 컬러 모두 가져오기
		List<GoodsDetails> colorList = service.selectColorList(goodsName);
		
		// 해당 제품 리뷰 가져오기
		List<Review> reviewList = service.selectReviewList(cPage, numPerPage,goodsName);
		
		int totalData =service.reviewTotalCount(goodsName);
		
		mv.addObject("pageBar",PageFactory.getPageBar(totalData, cPage, numPerPage,5, "goodsDetailView.do", null));	
		mv.addObject("reviewList",reviewList);
		
		mv.addObject("good",good);
		mv.addObject("imageList",imageList);
		mv.addObject("colorList",colorList);
		System.out.println(colorList);
		System.out.println(good);
		mv.setViewName("market/goodsDetailView");
		
		return mv;
		
	}
	
	/* 상품 상세 이미지 불러오기 */
	@RequestMapping("/goodDetailImageList.do")
	@ResponseBody
	public List<GoodsDetailImage> goodDetailImageList(String goodsName){
		
		List<GoodsDetailImage> imageList = service.selectImageList(goodsName);
		
		return imageList;
	}
	
	/* 상품상세페이지에서 색상 선택시 사이즈 및 재고 가져오기 */
	@RequestMapping("/sizeInvenList.do")
	@ResponseBody
	public List<GoodsDetails> sizeInvenList(GoodsDetails gd){
		
		List<GoodsDetails> gdList = service.sizeInvenList(gd);
		
		return gdList;
	}
	
	@RequestMapping("/goodPrice.do")
	@ResponseBody
	public GoodsDetails goodPrice(GoodsDetails gd) {
		GoodsDetails gds = service.goodPrice(gd);
		
		return gds;
	}
	
	@RequestMapping("/purchaseGood.do")
	public ModelAndView purchaseGood(OrderDetail orderDetail,ModelAndView mv) {

		mv.addObject("orderDetail",orderDetail);
		mv.setViewName("market/purchaseDetailView");
		return mv;
	}
	
	
	@RequestMapping("purchaseGoodEnd.do")
	@Transactional
	public ModelAndView purchaseGoodEnd(Order order,OrderDetail orderDetail,ModelAndView mv) {
		
		String msg="";
		String loc="";
		int insertOrderResult = service.insertOrder(order);
		if(insertOrderResult>0) {
			int insertOrderDetailResult = service.insertOrderDetail(orderDetail);
			
			if(insertOrderDetailResult>0) {
				GoodsDetails gd = new GoodsDetails();
				gd.setGoodsName(orderDetail.getGoodsName());
				gd.setColor(orderDetail.getOrderColor());
				gd.setSize(orderDetail.getOrderSize());
				int inven = service.goodPrice(gd).getInvenCount();
				int finalInven = inven-orderDetail.getOrderCount();
				gd.setInvenCount(finalInven);
				
				int updateInvenResult = service.updateInven(gd);
				
				String goodsName=orderDetail.getGoodsName();			
				Goods good = service.selectGood(goodsName);
				good.setTotalCell(good.getTotalCell()+1);
				
				int updateTotalCellResult = service.updateTotalCell(good);
				
				if(updateInvenResult>0 && updateTotalCellResult>0) {
					 msg="구매 완료되었습니다. 이용해주셔서 감사합니다";
					 loc="/market/goodsList.do";	
				}else {
					 msg="구매에 문제가 발생하였습니다. 다시 결제 부탁드립니다 :(";
					 loc="/market/goodsList.do";	
				}
				
			}else {
				 msg="구매에 문제가 발생하였습니다. 다시 결제 부탁드립니다 :(";
				 loc="/market/goodsDetailView.do?goodsName="+orderDetail.getGoodsName();	
			}
		}else {
			 msg="구매에 문제가 발생하였습니다. 다시 결제 부탁드립니다 :(";
			 loc="/market/goodsDetailView.do?goodsName="+orderDetail.getGoodsName();	
		}
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("common/msg");
		return mv;
	}
	
	@RequestMapping("/pay.do")
	public ModelAndView pay(Order order,OrderDetail orderDetail,ModelAndView mv) {

		mv.addObject("order",order);
		mv.addObject("orderDetail",orderDetail);
		mv.setViewName("market/pay");

		return mv;
		
	}
	
	@RequestMapping("/myOrderedView.do")
	public ModelAndView myOrderdView(@RequestParam(value="cPage",defaultValue="1") int cPage,
			@RequestParam(value="numPerPage",defaultValue="10") int numPerPage,HttpSession session,ModelAndView mv) {
	Member m = (Member)session.getAttribute("loginMember");
	System.out.println(m);
	
	List<Order> list = service.orderDetailList(cPage,numPerPage,m);	
	
	int totalOrderDetail = service.selectOrderDetailCount(m);
	
		
	mv.addObject("pageBar",PageFactory.getPageBar(totalOrderDetail, cPage, numPerPage,5, "myOrderdView.do", null));	
	mv.addObject("List",list);	
	
	mv.setViewName("market/myOrderedView");
	
	return mv;
	}
	
	
	@RequestMapping("/enrollReview.do")
	@Transactional
	public ModelAndView enrollReview(@RequestParam Map<String,Object> param,ModelAndView mv) {
		
		String msg="";
		String loc="";
		int grade = Integer.parseInt(param.get("grade").toString());
		
		int insertReviewResult = service.insertReview(param);
		if(insertReviewResult>0) {
			String goodsName = (String)(param.get("goodsName"));
			int reviewTotalCount = service.reviewTotalCount(goodsName);
			Goods good = service.selectGood(goodsName);
			int avgGrade=good.getAvgGrade();
			int updateGrade = Math.round((avgGrade*(reviewTotalCount-1)+grade)/reviewTotalCount);
			good.setAvgGrade(updateGrade);
			
			int updateAvgGrageResult = service.updateAvgGrade(good);
			int updateCheckReviewDo = service.updateCheckReviewDo(param);
			
			if(0<updateAvgGrageResult && updateCheckReviewDo>0) {
				 msg="리뷰등록이 완료되었습니다. 감사합니다 :)";
				 loc="/market/myOrderedView.do";	
			}else {
				 msg="리뷰등록에 문제가 발생하였습니다. 다시 입력 부탁드립니다. :(";
				 loc="/market/myOrderedView.do";	
			}	
		}else {
			 msg="리뷰등록에 문제가 발생하였습니다. 다시 입력 부탁드립니다. :(";
			 loc="/market/myOrderedView.do";	
		}
		
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("common/msg");
		
		return mv;
	}
	
	@RequestMapping("/myReviewList.do")
	public ModelAndView myReviewList(@RequestParam(value="cPage",defaultValue="1") int cPage,
			@RequestParam(value="numPerPage",defaultValue="5") int numPerPage,HttpSession session,ModelAndView mv) {
		Member m = (Member)session.getAttribute("loginMember");

		List<Review> reviewList = service.selectReviewList(cPage,numPerPage,m);
		
		int totalData = service.selectReviewCount(m);
		
		mv.addObject("pageBar",PageFactory.getPageBar(totalData, cPage, numPerPage,5, "myReviewList.do", null));	
		mv.addObject("reviewList",reviewList);	
		
		mv.setViewName("market/myReview");
		
		return mv;
	}
	
	@RequestMapping("/updateReview.do")
	@Transactional
	public ModelAndView updaterReview(Review rv,ModelAndView mv) {
		
		String msg="";
		String loc="";
		
		Review review = service.selectReviewUseNo(rv);
		String goodsName = review.getGoodsName();
		Goods good = service.selectGood(goodsName);
		int avgGrade=good.getAvgGrade();
		int reviewTotalCount = service.reviewTotalCount(goodsName);
		
		int updateGrade = Math.round(((avgGrade*reviewTotalCount)-review.getGrade()+rv.getGrade())/reviewTotalCount);
		good.setAvgGrade(updateGrade);
		
		int updateAvgGrageResult = service.updateAvgGrade(good);
		int updateReviewResult = service.updateReview(rv);
		
		 if(updateReviewResult>0 && updateAvgGrageResult>0) {
			 msg="리뷰 수정 성공";
			 loc="/market/myReviewList.do";			 
		 }else {
			 msg="리뷰 수정 실패";
			 loc="/market/myReviewList.do";	
		 }
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("common/msg");
		
		return mv;
		
	}
	
	@RequestMapping("/deleteReview.do")
	@Transactional
	public ModelAndView deleteReview(Review rv,ModelAndView mv) {
		
		String msg="";
		String loc="";
		
		Review review = service.selectReviewUseNo(rv);
		String goodsName = review.getGoodsName();
		Goods good = service.selectGood(goodsName);
		int avgGrade=good.getAvgGrade();
		int reviewTotalCount = service.reviewTotalCount(goodsName);
		
		int TotalCount = reviewTotalCount-1;
		if(TotalCount==0)TotalCount=1;
		
		int updateGrade = Math.round(((avgGrade*reviewTotalCount)-review.getGrade())/(TotalCount));
		good.setAvgGrade(updateGrade);
		
		int updateAvgGrageResult = service.updateAvgGrade(good);
		int deleteReviewResult = service.deleteReview(rv);
		
		 if(deleteReviewResult>0 && updateAvgGrageResult>0) {
			 msg="리뷰 삭제 성공";
			 loc="/market/myReviewList.do";			 
		 }else {
			 msg="리뷰 삭제 실패";
			 loc="/market/myReviewList.do";	
		 }
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("common/msg");
		
		return mv;
	}
	
	
	/*==============================================================================================
	 																			관리자 로직
	===============================================================================================*/
	
	/* 등록된 상품상세 리스트 불러오기 */
	@RequestMapping("/enrollManageList.do")
	public ModelAndView enrollManageList(@RequestParam(value="cPage",defaultValue="1") int cPage,
			@RequestParam(value="numPerPage",defaultValue="10") int numPerPage,ModelAndView mv) {
		
		List<GoodsDetails> list = service.selectEnrolledList(cPage,numPerPage);	
		
		int totalData = service.selectGoodsDetailsCount();
		
		mv.addObject("pageBar",PageFactory.getPageBar(totalData, cPage, numPerPage,5, "enrollManageList.do", null));	
		mv.addObject("enrolledList",list);
		mv.setViewName("market/enrollManageList");
		
		return mv;
		
	}
	
	/* 상품 수정 */
	@RequestMapping("/updateGood.do")
	public ModelAndView updateGood(@RequestParam Map<String,Object> param,ModelAndView mv) {
		
		int result = service.updateGood(param);
		
		 String msg="";
		 String loc="";
		 if(result>0) {
			 msg="상품 수정 성공";
			 loc="/market/enrollManageList.do";			 
		 }else {
			 msg="상품 수정 실패";
			 loc="/market/enrollManageList.do";		
		 }
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("common/msg");
	
		return mv;
	}
	
	/* 등록된 상품 검색하여 불러오기 */
	@RequestMapping("/enrolledGoodSearch.do")
	public ModelAndView enrolledGoodSearch(@RequestParam Map<String,Object> param,@RequestParam(value="cPage",defaultValue="1") int cPage,
			@RequestParam(value="numPerPage",defaultValue="10") int numPerPage,ModelAndView mv) {
		
		String searchOp = (String)param.get("searchOp");
		String searchText = (String)param.get("searchText");
		
		List<GoodsDetails> list = service.searchEnrolledList(param,cPage,numPerPage);
	
		int totalData = service.selectGoodsDetailsCount(param);
		
		mv.addObject("pageBar",PageFactory.getPageBar(totalData, cPage, numPerPage,5, "enrolledGoodSearch.do", "&searchOp="+searchOp+"&searchText="+searchText));
		mv.addObject("enrolledList",list);
		mv.setViewName("market/enrollManageList");
		
		return mv;
	}
	
	/* 상품 삭제 */
	@RequestMapping("/deleteGood.do")
	public ModelAndView deleteGood(@RequestParam Map<String,Object> param,ModelAndView mv) {
		
		System.out.println(param);
		System.out.println((String)param.get("delgoodno"));
		int result = service.deleteGood(param);
		
		String msg="";
		String loc="";
		 if(result>0) {
			 msg="상품 삭제 성공";
			 loc="/market/enrollManageList.do";				 
		 }else {
			 msg="상품 삭제 실패";
			 loc="/market/enrollManageList.do";		
		 }
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("common/msg");
		
		return mv;
		
	}
	
	/* 등록된 상품 불러오기 */
	@RequestMapping("/enrollGood.do")
	public ModelAndView enrollGood(@RequestParam(value="cPage",defaultValue="1") int cPage,
			@RequestParam(value="numPerPage",defaultValue="10") int numPerPage,ModelAndView mv) {
		
		List<Goods> list = service.selectOnlyGoodsList(cPage,numPerPage);	

		int totalData = service.selectGoodsCount();
			
		mv.addObject("pageBar",PageFactory.getPageBar(totalData, cPage, numPerPage,5, "enrollGood.do", null));	
		mv.addObject("goodsList",list);	
		
		mv.setViewName("market/enrollView");
		
		return mv;
	}
	
	/* 등록된 상품 검색하여 불러오기 */
	@RequestMapping("/goodSearch.do")
	public ModelAndView goodSearch(@RequestParam Map<String,Object> param,@RequestParam(value="cPage",defaultValue="1") int cPage,
			@RequestParam(value="numPerPage",defaultValue="10") int numPerPage,ModelAndView mv) {
		
		String searchOp = (String)param.get("searchOp");
		String searchText = (String)param.get("searchText");
		
		List<Goods> list = service.selectSearchGood(param,cPage,numPerPage);
	
		int totalData = service.searchGoodCount(param);
		
		mv.addObject("pageBar",PageFactory.getPageBar(totalData, cPage, numPerPage,5, "goodSearch.do", "&searchOp="+searchOp+"&searchText="+searchText));
		mv.addObject("goodsList",list);
		mv.setViewName("market/enrollView");
		
		return mv;
		
	}
	
	/* 대표 이미지 등록/수정하기 */
	// 기존에 상품객체 생성시 이미지 변수는 NULL값으로 먼저 생성을 하기 때문에
	// 등록 및 수정 모두 UPDATE문으로 실행 가능하다
	@RequestMapping("/enrollGoodImage.do")
	public ModelAndView enrollGoodImage(@RequestParam(value="upFile",required=false) MultipartFile[] upFile, 
			HttpServletRequest req,Goods good,ModelAndView mv) {
		
		String path=req.getServletContext().getRealPath("/resources/upload/market/");
		File file=new File(path);
		if(!file.exists()) file.mkdirs();
		for(MultipartFile mf : upFile) {
			if(!mf.isEmpty()) {
				try {
					mf.transferTo(new File(path+mf.getOriginalFilename()));
					good.setImage(mf.getOriginalFilename());
				}catch(IOException e) {
					e.printStackTrace();
				}
			}
		}
		
		int result = service.enrollGoodImage(good);
		
		String msg="";
		String loc="";
		 if(result>0) {
			 msg="이미지 등록 성공";
			 loc="/market/enrollGood.do";			 
		 }else {
			 msg="이미지 등록 실패";
			 loc="/market/enrollGood.do";		
		 }
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("common/msg");
		
		return mv;

	}
	
	
	/* 상품 상세 이미지 등록하기 */
	@RequestMapping("/enrollGoodDetailImage.do")
	public ModelAndView enrollGoodDetailImage(@RequestParam(value="upFile",required=false) MultipartFile[] upFile, 
			HttpServletRequest req,Goods good,ModelAndView mv) {
		
		String path=req.getServletContext().getRealPath("/resources/upload/market/");
		File file=new File(path);
		if(!file.exists()) file.mkdirs();
		for(MultipartFile mf : upFile) {
			if(!mf.isEmpty()) {
				try {
					mf.transferTo(new File(path+mf.getOriginalFilename()));
				}catch(IOException e) {
					e.printStackTrace();
				}
			}
		}
		
		List<GoodsDetailImage> filenames=new ArrayList();
		GoodsDetailImage gdi=null;
		for(int i=0;i<upFile.length;i++) {
			gdi=GoodsDetailImage.builder().filePath(upFile[i].getOriginalFilename()).goodsNo(good.getGoodsNo()).goodsName(good.getGoodsName()).build();
			filenames.add(gdi); 
		}
		
		int result=service.insertGoodsDetailImage(filenames);
		
		Goods g = service.selectGood(good.getGoodsName());
		if(g.getGoodsOutput().equals("Y"))service.updateGoodOutput(g.getGoodsName());
		
		String msg="";
		String loc="";
		 if(result>0) {
			 msg="상품상세 이미지 등록 성공";
			 loc="/market/enrollGood.do";				 
		 }else {
			 msg="상품상세 이미지 등록 실패";
			 loc="/market/enrollGood.do";	
		 }
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("common/msg");
		
		return mv;
	}
	
	/* 상품상세 이미지 수정하기 */
	@RequestMapping("/updateGoodDetailImage.do")
	public ModelAndView updateGoodDetailImage(@RequestParam(value="upFile",required=false) MultipartFile[] upFile, 
			@RequestParam(value="imgNo",required=false) String[] imgNo,HttpServletRequest req,Goods good,ModelAndView mv) {

		String path=req.getServletContext().getRealPath("/resources/upload/market/");
		File file=new File(path);
		if(!file.exists()) file.mkdirs();
		for(MultipartFile mf : upFile) {
			if(!mf.isEmpty()) {
				try {
					mf.transferTo(new File(path+mf.getOriginalFilename()));
				}catch(IOException e) {
					e.printStackTrace();
				}
			}
		}
	
		List<GoodsDetailImage> filenames=new ArrayList();
		GoodsDetailImage gdi=null;
		for(int i=0;i<upFile.length;i++) {
			if(!upFile[i].getOriginalFilename().equals("")) {	
			gdi=GoodsDetailImage.builder().filePath(upFile[i].getOriginalFilename()).imgNo(Integer.parseInt(imgNo[i])).build();
			filenames.add(gdi); 
			}
		}
		
		int result=service.updateGoodsDetailImage(filenames);
		
		String msg="";
		String loc="";
		 if(result>0) {
			 msg="상품상세 이미지 수정 성공";
			 loc="/market/enrollGood.do";				 
		 }else {
			 msg="상품상세 이미지 수정 실패";
			 loc="/market/enrollGood.do";	
		 }
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("common/msg");
		
		return mv;
	}
	
	
	/* 상품 상세 조건으로 등록되어있는지 확인 */
	@RequestMapping("/checkExistGoodDetail.do")
	@ResponseBody
	public int checkExistGoodDetail(GoodsDetails gd) {
		
		int result = service.checkExistGoodDetail(gd);
		
		return result;
	}
	
	@RequestMapping("/enrollGoodsDetails.do")
	public ModelAndView enrollGoodsDetails(GoodsDetails gd,ModelAndView mv) {
		
		int result = service.enrollGoodsDetails(gd);
		
		String msg="";
		String loc="";
		 if(result>0) {
			 msg="상품상세 등록 성공";
			 loc="/market/enrollGood.do";				 
		 }else {
			 msg="상품상세 등록 실패";
			 loc="/market/enrollGood.do";	
		 }
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("common/msg");
		
		return mv;
		
	}
	
	/* 상품 상세 조건으로 등록되어있는지 확인 */
	@RequestMapping("/checkExistGoodName.do")
	@ResponseBody
	public int checkExistGoodName(Goods good) {
		
		int result = service.checkExistGoodName(good);
		
		return result;
	}
	
	/* 상품 등록하기 */
	@RequestMapping("/enrollGoods.do")
	public ModelAndView enrollGoods(Goods good,ModelAndView mv) {

		int result = service.enrollGoods(good);
		
		String msg="";
		String loc="";
		 if(result>0) {
			 msg="상품 등록 성공";
			 loc="/market/enrollGood.do";			 
		 }else {
			 msg="상품 등록 실패";
			 loc="/market/enrollGood.do";	
		 }
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("common/msg");
		
		return mv;
		
	}
	
	/* 상품 삭제하기 */
	@RequestMapping("/deleteTitleGood.do")
	public ModelAndView deleteTitleGood(Goods good,ModelAndView mv) {
		System.out.println(good);
		int result = service.deleteTitleGood(good);
		
		String msg="";
		String loc="";
		 if(result>0) {
			 msg="상품 삭제 성공";
			 loc="/market/enrollGood.do";			 
		 }else {
			 msg="상품 삭제 실패";
			 loc="/market/enrollGood.do";	
		 }
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("common/msg");
		
		return mv;
		
	}
	
	
}
