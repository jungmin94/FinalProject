package com.pai.spring.admin.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.pai.spring.admin.model.service.AdminService;
import com.pai.spring.board.model.service.BoardService;
import com.pai.spring.board.model.vo.Board;
import com.pai.spring.board.model.vo.BoardDeclare;
import com.pai.spring.board.model.vo.CommentDeclare;
import com.pai.spring.common.PageFactory;
import com.pai.spring.member.model.vo.Member;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private AdminService service;
	
	@Autowired
	private BoardService boardService;
	
	@RequestMapping("/adminView.do")
	public String adminView() {
		return "admin/adminView";
	}
	
	@RequestMapping("/declareAdminView.do")
	public ModelAndView declareAdmin(ModelAndView mv,@RequestParam(value="cPage",defaultValue="1") int cPage, @RequestParam(value="numPerPage",defaultValue="10") int numPerPage) {
		List<BoardDeclare> list=service.boardDeclareList(cPage,numPerPage);
		int totalDate=service.boardDeclareCount();
		// System.out.println(list);
		mv.addObject("list", list);
		mv.addObject("pageBar",PageFactory.getPageBar(totalDate, cPage, numPerPage, 5, "declareAdminView.do",""));
		return mv;
	}
	
	@RequestMapping("/commentDeclare.do")
	public ModelAndView commentDeclareAdmin(ModelAndView mv,@RequestParam(value="cPage",defaultValue="1") int cPage, @RequestParam(value="numPerPage",defaultValue="10") int numPerPage) {
		List<BoardDeclare> list=service.commentDeclareList(cPage,numPerPage);
		int totalDate=service.commentDeclareCount(); 
		//System.out.println(list);
		mv.addObject("list", list);
		mv.addObject("pageBar",PageFactory.getPageBar(totalDate, cPage, numPerPage, 5, "declareAdminView.do",""));
		return mv;
	}
	
	@RequestMapping("/updateBoardDeclare.do")
	public ModelAndView updateBoardDeclare(ModelAndView mv,BoardDeclare bd,String boardWriter ) {
		
		int result=0;
		int result2=0;
		System.out.println(bd.getBoardNo());
		System.out.println(bd);
		if(bd.getDeclareResult().contains("경고")) {
			//멤버테이블 member_police에 값 1 추가 
			result=service.updatePolice(boardWriter);
		}
		
		if(bd.getDeclareResult().contains("블랙")) {
			//멤버테이블 member_black에 값 1 추가
			result=service.insertBlack(boardWriter);
		}
		
		if(bd.getDeclareResult().contains("삭제")) {
			//해당 게시물 삭제
			result=boardService.deleteBoard(bd.getBoardNo());
			result2=1;
		}
		
		if(bd.getDeclareResult().contains("무효")) {
			result=1;
		}
		
		if(!bd.getDeclareResult().contains("삭제")) {
			result2=service.updateBoardDeclare(bd);
		}
		String msg="";
		String loc=""; 
	    if(result>0&&result2>0) {
			 msg="신고접수가 정상적으로 처리되었습니다.";
			 loc="/admin/declareAdminView.do";		 
	    }else {
			 msg="신고접수처리에 실패였습니다.";
			 loc="/admin/declareAdminView.do";		
		 }
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.setViewName("common/msg");	 
		return mv;
	}
	
 
	
	
	@RequestMapping("/updateCommentDeclare.do")
	public ModelAndView updateCommentDeclare(ModelAndView mv,CommentDeclare cd,String commentWriter ) {
		int result=0;
		int result2=0;
		System.out.println(cd);
		Member m=service.selectMember(commentWriter);
		System.out.println(m);
		if(cd.getDeclareResult().contains("경고")) {
			//멤버테이블 member_police에 값 1 추가 
			result=service.updatePolice(cd.getCommentWriter());
		}
		
		if(cd.getDeclareResult().contains("블랙")) {
			//멤버테이블 member_black에 값 1 추가
			if(m.getMember_black()==1) {
				result=1;	
			}else if(m.getMember_black()!=1) {
				result=service.insertBlack(cd.getCommentWriter());				
			}
			
		}
		
		if(cd.getDeclareResult().contains("삭제")) {
			//해당 댓글 삭제
			result=boardService.commentDelete(cd.getCommentNo());
			result2=1;
		}
		
		if(cd.getDeclareResult().contains("무효")) {
			result=1;
		}
		
		if(!cd.getDeclareResult().contains("삭제")) {
			result2=service.updateCommentDeclare(cd);
		}
		String msg="";
		String loc=""; 
	    if(result>0&&result2>0) {
			 msg="신고접수가 정상적으로 처리되었습니다.";
			 loc="/admin/commentDeclare.do";		 
	    }else {
			 msg="신고접수처리에 실패였습니다.";
			 loc="/admin/commentDeclare.do";		
		 }
	    
	    System.out.println(result);
	    System.out.println(result2);
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.setViewName("common/msg");	 
		return mv; 
	}
	
	
	
	
	
}
