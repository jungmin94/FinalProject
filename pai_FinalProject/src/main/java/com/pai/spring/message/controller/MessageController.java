package com.pai.spring.message.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.pai.spring.message.model.service.MessageService;
import com.pai.spring.message.model.vo.Message;

@Controller
public class MessageController {
	
	@Autowired
	private MessageService service;

	@RequestMapping(value="/message/sendMessage", method=RequestMethod.POST)
	public ModelAndView sendMessage(@RequestParam Map param, ModelAndView mv) {
		mv.addObject("param", param);
		mv.setViewName("message/sendMessage");
		return mv;
	}
	
	@RequestMapping(value="/message/messageBox.do", produces="text/plain;charset=UTF-8")
	public ModelAndView messageBox(ModelAndView mv, String memberId) {
		List<Message> list = service.selectRecvMessage(memberId);
		//new Gson().toJson(list);
		mv.addObject("list",list);
		mv.setViewName("message/messageBox");
		return mv;
	}
	
}
