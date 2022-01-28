package com.pai.spring.board.model.service;

import java.util.List;
import java.util.Map;

import com.pai.spring.board.model.vo.Board;
import com.pai.spring.board.model.vo.BoardComment;

public interface BoardService {
	List<Board> boardList(int cPage,int numPerPage);
	
	int selectBoardCount();
	
	List<Board> searchBoard(Map<String,Object> param,int cPage,int numPerPage);
	
	int searchBoardCount(Map<String,Object> param);
	
	Board selectBoard(int boardNo);
	
	int insertBoard(Board b);
	
	int updateBoard(Board b);
	
	int insertComment(BoardComment bc);
	
	int insertComment2(BoardComment bc);
	
	List<BoardComment> boardCommentList(int boardNo);
	
	int deleteBoard(int boardNo);
	
	int commentDelete(int commentNo);
	
}
