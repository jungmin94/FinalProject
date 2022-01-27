package com.pai.spring.board.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.pai.spring.board.model.service.BoardService;
import com.pai.spring.board.model.vo.AttachFile;
import com.pai.spring.board.model.vo.Board;
import com.pai.spring.common.PageFactory;
import com.pai.spring.member.model.vo.Member;

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
		//System.out.println(list);
		mv.addObject("pageBar",PageFactory.getPageBar(totalDate, cPage, numPerPage, 5, "boardList.do",""));
		mv.addObject("list", list); 
		return mv;
	}
	
	@RequestMapping("/insertBoard.do")
	public String insertBoard() {
		
		return "board/insertBoard";
	}
	
	@RequestMapping("/searchBoard.do")
	public ModelAndView searchBoard(ModelAndView mv,@RequestParam(value="category") String category
										,@RequestParam(value="searchType") String searchType,@RequestParam(value="keyword") String keyword
										,@RequestParam(value="cPage",defaultValue="1") int cPage, @RequestParam(value="numPerPage",defaultValue="10") int numPerPage) {
		
		//System.out.println(category);
		//System.out.println(searchType);
		//System.out.println(keyword);
		Map<String,Object> param=new HashMap();
		param.put("category", category);
		param.put("keyword", keyword);
		param.put("searchType", searchType);
		param.put("cPage", cPage);
		param.put("numPerPage", numPerPage);
		List<Board> list=service.searchBoard(param,cPage,numPerPage);
		int totalDate=service.searchBoardCount(param);
		mv.addObject("pageBar", PageFactory.getPageBar(totalDate, cPage, numPerPage, 5, "searchBoard.do","&category="+category+"&searchType="+searchType+"&keyword="+keyword));
		mv.addObject("list", list);
		mv.setViewName("board/boardList");
		return mv;
	}
	
	@RequestMapping("/boardView.do")
	public ModelAndView boardView(ModelAndView mv,@RequestParam(value="boardNo") int boardNo) {
		//System.out.println(boardNo);
		Board b=service.selectBoard(boardNo);
		//System.out.println(b);
		mv.addObject("board", b);
		return mv;
	}
	
	@RequestMapping("/ajax/boardView.do")
	@ResponseBody
	public Boolean selectBoardView(@RequestParam(value="boardNo") int boardNo) {
		//System.out.println(boardNo);
		Board b=service.selectBoard(boardNo);
		//System.out.println(b);
		return b==null;
	}
	
	
	@RequestMapping("/insertBoardEnd.do")
	@ResponseBody
	public Boolean insertBoardEnd(@RequestParam(value="upFile",required=false) MultipartFile[] upFile,
									@RequestParam(value="boardTitle") String boardTitle, @RequestParam(value="boardCategory") String boardCategory,
									@RequestParam(value="boardContent") String boardContent,@RequestParam(value="memberId") String memberId ,ModelAndView mv,HttpServletRequest req) {
		 
		String path=req.getServletContext().getRealPath("/resources/upload/board/");
		File file=new File(path);
		if(!file.exists()) file.mkdirs();
		for(MultipartFile mf : upFile) {
			if(!mf.isEmpty()) {
				try {
					mf.transferTo(new File(path+mf.getOriginalFilename()));
				}catch(IOException e) {
					e.printStackTrace();
				}
			}
		}
		
		Member m=Member.builder().member_id(memberId).build();
		List<AttachFile> filenames=new ArrayList();
		AttachFile f=null;
		for(int i=0;i<upFile.length;i++) {
			f=AttachFile.builder().attachFileName(upFile[i].getOriginalFilename()).build();
			filenames.add(f); 
		}
		
		Board b=Board.builder().boardTitle(boardTitle).boardCategory(boardCategory).boardContent(boardContent).boardWriter(m).attachFile(filenames).build();
		int result=service.insertBoard(b);
		return result>0;
	}
}
