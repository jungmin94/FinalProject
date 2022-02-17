package com.pai.spring;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.pai.spring.board.model.service.BoardService;
import com.pai.spring.board.model.vo.Board;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	 
	@Autowired
	private BoardService service;
	 
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) { 
		List<Board> infoList=service.infoList();
		List<Board> topList=service.topList(); 
		List<Board> list=service.mainList(); 
		model.addAttribute("list", list);
		model.addAttribute("top", topList);
		model.addAttribute("info", infoList);
		return "home";
	}
	
	@RequestMapping("/searchMainBoard.do")
	public String searchMainBoard(String category, Model model) {
		List<Board> infoList=service.infoList();
		List<Board> topList=service.topList(); 
		List<Board> list=service.searchMainBoard(category);
		
		model.addAttribute("category", category);
		model.addAttribute("list", list);
		model.addAttribute("top", topList);
		model.addAttribute("info", infoList);
		return "home";
	}
	
}
