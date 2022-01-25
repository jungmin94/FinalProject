package com.pai.spring.message.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class WebsocketController {

	@RequestMapping("/message/sendMessage")
	public ModelAndView sendMessage(@RequestParam Map param, ModelAndView mv) {
		System.out.println(param);
		mv.setViewName("message/sendMessage");
		return mv;
	}
	
}
