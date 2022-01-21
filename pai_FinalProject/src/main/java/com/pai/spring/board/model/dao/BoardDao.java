package com.pai.spring.board.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.pai.spring.board.model.vo.Board;

public interface BoardDao {

	List<Board> boardList(SqlSessionTemplate session,int cPage,int numPerPage);
	
	int selectBoardCount(SqlSessionTemplate session);
}
