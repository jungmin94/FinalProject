package com.pai.spring.message.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MessageController {

	@RequestMapping(value="/message/sendMessage", method=RequestMethod.POST)
	public ModelAndView sendMessage(@RequestParam Map param, ModelAndView mv) {
		mv.addObject("param", param);
		mv.setViewName("message/sendMessage");
		return mv;
	}
	
	@RequestMapping(value="/message/messageBox.do")
	public ModelAndView messageBox(ModelAndView mv) {
		mv.setViewName("message/messageBox");
		return mv;
	}
	
}
