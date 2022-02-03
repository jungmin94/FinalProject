package com.pai.spring.message.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.pai.spring.common.PageBar;
import com.pai.spring.message.model.service.MessageService;
import com.pai.spring.message.model.vo.Message;

@Controller
@RequestMapping("/message")
public class MessageController {
	
	@Autowired
	private MessageService service;

	@RequestMapping(value="/sendMessage", method=RequestMethod.POST)
	public ModelAndView sendMessage(@RequestParam Map param, ModelAndView mv) {
		mv.addObject("param", param);
		mv.setViewName("message/sendMessage");
		return mv;
	}
	
	@RequestMapping(value="/messageBox.do", produces="text/plain;charset=UTF-8")
	public ModelAndView messageBox(ModelAndView mv, String memberId, @RequestParam(value="cPage",defaultValue="1") int cPage,
			@RequestParam(value="numPerpage",defaultValue="10") int numPerpage) {
		
		Map<String,Object> param = new HashMap();
		param.put("memberId", memberId);
		param.put("cPage", cPage);
		param.put("numPerpage", numPerpage);
		
		List<Message> list = service.selectRecvMessage(memberId, cPage, numPerpage);
		int totalData = service.selectRecvMessageCount(memberId);
		
		mv.addObject("totalContents",totalData);
		mv.addObject("pageBar",PageBar.getPageBar(totalData, cPage, numPerpage, 10, "messageBox.do"));
		//new Gson().toJson(list);
		mv.addObject("list",list);
		mv.setViewName("message/messageBox");
		return mv;
	}
	
	
	@RequestMapping(value="/recvMsgDetail.do")
	public String recvMsgDetail(int msgNo) {
		Message msg = service.selectRecvMsgDetail(msgNo);
		System.out.println(msgNo);
		System.out.println(msg);
		return new Gson().toJson(msg);
	}
	
}
