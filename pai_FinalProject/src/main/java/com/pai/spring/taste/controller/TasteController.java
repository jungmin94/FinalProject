package com.pai.spring.taste.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.pai.spring.taste.model.service.TasteService;
import com.pai.spring.taste.model.vo.Taste;

@Controller
@RequestMapping("/taste")
public class TasteController {
	
	@Autowired
	private TasteService service;
	
	@RequestMapping("/taste.do")
	public String tasteTest() {
		return "taste/tasteTest";
	}
	
	@RequestMapping(value="/insertTaste.do", method=RequestMethod.POST)
	public ModelAndView insertTaste(Taste t, ModelAndView mv) {
		//멤버 아이디로 먼저 데이터 조회해서 있으면 기존 데이터 삭제 후 insert
		//없으면 insert
		int result = service.insertTaste(t);
		
		return mv;
	}
	
}
