/** package com.pai.spring.taste.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.pai.spring.member.model.vo.Member;
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
	
	@RequestMapping(value="/selectTaste.do", method=RequestMethod.POST)
	public ModelAndView selectTaste(String member_id, ModelAndView mv) {
		Taste t = service.selectTasteOne(member_id);
		System.out.println(t);
		Map param = new HashMap();
		param.put("exam01", t.getExam01());
		param.put("exam02", t.getExam02());
		param.put("exam03", t.getExam03());
		param.put("exam04", t.getExam04());
		param.put("exam05", t.getExam05());
		List<Member> list = service.selectTasteList(param);
		System.out.println(list);
		mv.addObject("list", list);	
		mv.setViewName("taste/tasteList");
		return mv;
	}

	
	@RequestMapping(value="/insertTaste.do", method=RequestMethod.POST)
	public ModelAndView insertTaste(@RequestParam Map param, String member_id, ModelAndView mv) {
		//멤버 아이디로 먼저 데이터 조회해서 
		int result;
		
		//로그인한 아이디로 데이터 있는지 확인
		Taste t = service.selectTasteOne(member_id);
		if(t != null) {
			//있는 경우 기존 데이터 update
			result = service.updateTaste(param);
		} else {
			//없으면 insert
			result = service.insertTaste(param);
		}

		//1~5번 동일한 유저 리스트 가져오기
		List<Member> list = service.selectTasteList(param);
		
		mv.addObject("list", list);	
		mv.setViewName("taste/tasteList");
		return mv;
	}
	
} **/
