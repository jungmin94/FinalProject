package com.pai.spring.market.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.pai.spring.common.PageFactory;
import com.pai.spring.market.model.service.MarketService;
import com.pai.spring.market.model.vo.Goods;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/market")
@Slf4j
public class MarketController {
	
	@Autowired
	private MarketService service;

	@RequestMapping("/mainView.do")
	public ModelAndView mainView(ModelAndView mv) {
		
		List<Goods> topSellList = service.bestSell();
		List<Goods> topGradeList = service.bestReview();
		
		mv.addObject("topSellList",topSellList);
		mv.addObject("topGradeList",topGradeList);
		mv.setViewName("market/mainView");
		
		return mv;
		
	}
	
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
	
	
	@RequestMapping("/goodsDetailView.do")
	public ModelAndView goodsDetailView(String goodsName,ModelAndView mv) {
		
		
		System.out.println(goodsName);
		
		return mv;
		
	}
	
	
}
