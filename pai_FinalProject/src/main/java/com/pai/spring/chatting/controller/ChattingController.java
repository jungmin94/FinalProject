package com.pai.spring.chatting.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.pai.spring.board.controller.BoardController;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/chatting")
@Slf4j
public class ChattingController {

	@RequestMapping("/toEnterChattingRoom.do")
	public String enterChattingRoom() {
		
		return "chatting/enterChattingRoom";
		
	}

}
