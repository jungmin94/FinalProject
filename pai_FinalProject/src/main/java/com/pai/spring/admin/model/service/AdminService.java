package com.pai.spring.admin.model.service;

import java.util.List;
import java.util.Map;

import com.pai.spring.board.model.vo.BoardDeclare;
import com.pai.spring.board.model.vo.CommentDeclare;
import com.pai.spring.member.model.vo.Member;

public interface AdminService {

	
	List<BoardDeclare> boardDeclareList(int cPage,int numPerPage);
	
	int boardDeclareCount();
	
	List<BoardDeclare> commentDeclareList(int cPage,int numPerPage);
	
	int commentDeclareCount();
	
	int updatePolice(String declareWriter);
	
	int updateBoardDeclare(BoardDeclare bd);
	
	int insertBlack(String declareWriter);
	
	BoardDeclare selectBoardDeclare(Map param);
	
	CommentDeclare selectCommentDeclare(Map param);
	
	int updateCommentDeclare(CommentDeclare cd);
	
	Member selectMember(String commentWriter);
}
