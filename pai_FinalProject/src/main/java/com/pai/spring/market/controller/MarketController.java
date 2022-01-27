package com.pai.spring.market.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

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
		
		System.out.println(topSellList);
		log.debug("{}"+topSellList);
		log.debug("{}"+topGradeList);
		
		mv.addObject("topSellList",topSellList);
		mv.addObject("topGradeList",topGradeList);
		mv.setViewName("market/mainView");
		
		return mv;
		
	}
	
	
}
