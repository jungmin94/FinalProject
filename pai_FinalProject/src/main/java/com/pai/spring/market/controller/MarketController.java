package com.pai.spring.market.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/market")
public class MarketController {

	@RequestMapping("/mainView.do")
	public ModelAndView mainView(ModelAndView mv) {
		
		mv.setViewName("market/mainView");
		
		return mv;
		
	}
	
	
}
