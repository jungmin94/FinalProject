package com.pai.spring.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.pai.spring.admin.model.service.AdminService;
import com.pai.spring.board.model.vo.BoardDeclare;
import com.pai.spring.common.PageFactory;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private AdminService service;
	
	@RequestMapping("/adminView.do")
	public String adminView() {
		return "admin/adminView";
	}
	
	@RequestMapping("/declareAdminView.do")
	public ModelAndView declareAdmin(ModelAndView mv,@RequestParam(value="cPage",defaultValue="1") int cPage, @RequestParam(value="numPerPage",defaultValue="10") int numPerPage) {
		List<BoardDeclare> list=service.boardDeclareList(cPage,numPerPage);
		int totalDate=service.boardDeclareCount();
		
		System.out.println(list);
		mv.addObject("list", list);
		mv.addObject("pageBar",PageFactory.getPageBar(totalDate, cPage, numPerPage, 5, "declareAdminView.do",""));
		return mv;
	}
	
	@RequestMapping("/commentDeclare.do")
	public ModelAndView commentDeclareAdmin(ModelAndView mv,@RequestParam(value="cPage",defaultValue="1") int cPage, @RequestParam(value="numPerPage",defaultValue="10") int numPerPage) {
		List<BoardDeclare> list=service.commentDeclareList(cPage,numPerPage);
		int totalDate=service.commentDeclareCount();
		System.out.println(list);
		System.out.println(list);
		mv.addObject("list", list);
		mv.addObject("pageBar",PageFactory.getPageBar(totalDate, cPage, numPerPage, 5, "declareAdminView.do",""));
		return mv;
	}
	
}
