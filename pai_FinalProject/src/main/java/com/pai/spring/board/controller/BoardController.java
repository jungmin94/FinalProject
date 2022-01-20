package com.pai.spring.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/board")
public class BoardController {

	@RequestMapping("/boardList.do")
	public String BoardList() {
	
		return "board/boardMain";
	}
	
	@RequestMapping("/insertBoard.do")
	public String insertBoard() {
		
		return "board/insertBoard";
	}
	
	
}
