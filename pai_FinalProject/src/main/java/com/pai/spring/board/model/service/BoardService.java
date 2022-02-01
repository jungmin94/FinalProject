package com.pai.spring.board.model.service;

import java.util.List;
import java.util.Map;

import com.pai.spring.board.model.vo.Board;
import com.pai.spring.board.model.vo.BoardComment;
import com.pai.spring.board.model.vo.BoardDeclare;
import com.pai.spring.board.model.vo.BoardLike;
import com.pai.spring.member.model.vo.Member;

public interface BoardService {
	List<Board> boardList(int cPage,int numPerPage);
	
	List<Board> boardReadList(int cPage,int numPerPage);
	
	List<Board> boardLikeList(int cPage,int numPerPage);
	
	int selectBoardCount();
	
	List<Board> searchBoard(Map<String,Object> param,int cPage,int numPerPage);
	
	int searchBoardCount(Map<String,Object> param);
	
	Board selectBoard(int boardNo, boolean isRead);
	
	Board selectBoard(int boardNo);
	
	int insertBoard(Board b);
	
	int updateBoard(Board b);
	
	int insertComment(BoardComment bc);
	
	int insertComment2(BoardComment bc);
	
	List<BoardComment> boardCommentList(int boardNo);
	
	int deleteBoard(int boardNo);
	
	int commentDelete(int commentNo);
	
	List<Board> readList();
	
	Member selectMember(String memberId);
	
	BoardLike selectBoardLike(Map param);
	
	int insertBoardLike(Map param);
	
	int deleteBoardLike(Map param);
	
	List<Board> likeList();
	
	int insertDeclare(BoardDeclare bd);
	

}
