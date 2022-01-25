package com.pai.spring.message.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class WebsocketController {

	@RequestMapping("/message/sendMessage")
	public String sendNote() {
		return "message/sendMessage";
	}
	
}
