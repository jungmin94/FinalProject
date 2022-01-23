package com.pai.spring.board.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.pai.spring.board.model.vo.Board;

public interface BoardDao {

	List<Board> boardList(SqlSessionTemplate session,int cPage,int numPerPage);
	
	int selectBoardCount(SqlSessionTemplate session);
	
	List<Board> searchBoard(SqlSessionTemplate session,Map<String,Object> param,int cPage, int numPerPage);
	
	int searchBoardCount(SqlSessionTemplate session,Map<String,Object>param);
	
	Board selectBoard(SqlSessionTemplate session,int boardNo);
}
