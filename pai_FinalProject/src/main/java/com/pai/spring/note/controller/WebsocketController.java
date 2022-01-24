package com.pai.spring.note.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class WebsocketController {

	@RequestMapping("/note/sendNote")
	public String sendNote() {
		return "note/sendNote";
	}
	
}
