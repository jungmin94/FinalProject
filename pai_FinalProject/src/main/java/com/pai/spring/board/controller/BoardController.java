package com.pai.spring.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.pai.spring.board.model.service.BoardService;
import com.pai.spring.board.model.vo.Board;
import com.pai.spring.common.PageFactory;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/board")
@Slf4j
public class BoardController {

	@Autowired
	private BoardService service;
	
	@RequestMapping("/boardList.do")
	public ModelAndView BoardList(ModelAndView mv,@RequestParam(value="cPage",defaultValue="1") int cPage, @RequestParam(value="numPerPage",defaultValue="10") int numPerPage) {
		List<Board> list=service.boardList(cPage,numPerPage); 
		int totalDate=service.selectBoardCount();
		mv.addObject("pageBar",PageFactory.getPageBar(totalDate, cPage, numPerPage, 5, "boardList.do"));
		mv.addObject("list", list); 
		return mv;
	}
	
	@RequestMapping("/insertBoard.do")
	public String insertBoard() {
		
		return "board/insertBoard";
	}
	
	@RequestMapping("/searchBoard.do")
	public ModelAndView searchBoard(ModelAndView mv,@RequestParam(value="category") String category
										,@RequestParam(value="searchType") String searchType,@RequestParam(value="keyword") String keyword) {
		System.out.println(category);
		System.out.println(searchType);
		System.out.println(keyword);
		
		Map<String,Object> param=new HashMap();
		param.put("category", category);
		param.put("keyword", keyword);
		param.put("searchType", searchType);
		List<Board> list=service.searchBoard(param);
		
		mv.addObject("list", list);
		mv.setViewName("board/boardList");
		return mv;
	}
	
	
}
