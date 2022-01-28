package com.pai.spring.board.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.pai.spring.board.model.vo.AttachFile;
import com.pai.spring.board.model.vo.Board;
import com.pai.spring.board.model.vo.BoardComment;

public interface BoardDao {

	List<Board> boardList(SqlSessionTemplate session,int cPage,int numPerPage);
	
	int selectBoardCount(SqlSessionTemplate session);
	
	List<Board> searchBoard(SqlSessionTemplate session,Map<String,Object> param,int cPage, int numPerPage);
	
	int searchBoardCount(SqlSessionTemplate session,Map<String,Object>param);
	
	Board selectBoard(SqlSessionTemplate session,int boardNo);
	
	int insertBoard(SqlSessionTemplate session,Board b);
	
	int insertAttachment(SqlSessionTemplate session,AttachFile f);
	
	int updateBoard(SqlSessionTemplate session,Board b);
	
	int deleteFile(SqlSessionTemplate session,int boardNo);
	
	int insertComment(SqlSessionTemplate session,BoardComment bc);
	
	int insertComment2(SqlSessionTemplate session,BoardComment bc);
	
	List<BoardComment> boardCommentList(SqlSessionTemplate session,int boardNo);
	
	int deleteBoard(SqlSessionTemplate session,int boardNo);
	
	int commentDelete(SqlSessionTemplate session,int commentNo);
	
}
