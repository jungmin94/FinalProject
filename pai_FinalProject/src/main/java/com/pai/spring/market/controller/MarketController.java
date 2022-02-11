package com.pai.spring.market.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.pai.spring.common.PageFactory;
import com.pai.spring.market.model.service.MarketService;
import com.pai.spring.market.model.vo.Goods;
import com.pai.spring.market.model.vo.GoodsDetailImage;
import com.pai.spring.market.model.vo.GoodsDetails;
import com.pai.spring.market.model.vo.Order;
import com.pai.spring.market.model.vo.OrderDetail;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/market")
@SessionAttributes({"loginMember"})
@Slf4j
public class MarketController {
	
	@Autowired
	private MarketService service;

	/*==============================================================================================
																								사용자 로직
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
	public ModelAndView goodsDetailView(String goodsName,ModelAndView mv) {
		
		// 해당 제품 정보 가져오기
		Goods good = service.selectGood(goodsName);
		
		// 해당 제품 제품 상세 사진 가져오기
		List<GoodsDetailImage> imageList = service.selectImageList(goodsName);
		System.out.println(imageList);
		// 해당 제품 컬러 모두 가져오기
		List<GoodsDetails> colorList = service.selectColorList(goodsName); 
		
		mv.addObject("good",good);
		mv.addObject("imageList",imageList);
		mv.addObject("colorList",colorList);
		System.out.println(colorList);
		System.out.println(good);
		mv.setViewName("market/goodsDetailView");
		
		return mv;
		
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
				if(updateInvenResult>0) {
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
	
	/* 대표 이미지 등록하기 */
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
