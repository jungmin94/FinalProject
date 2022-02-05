package com.pai.spring.admin.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.pai.spring.board.model.vo.Board;
import com.pai.spring.board.model.vo.BoardDeclare;

public interface AdminDao {

	List<BoardDeclare> boardDeclareList(SqlSessionTemplate session,int cPage,int numPerPage);
	
	int boardDeclareCount(SqlSessionTemplate session);
	
	List<BoardDeclare> commentDeclareList(SqlSessionTemplate session,int cPage,int numPerPage);
	
	int commentDeclareCount(SqlSessionTemplate session);
	
	int updatePolice(SqlSessionTemplate session,String declareWriter);
	
	int updateBoardDeclare(SqlSessionTemplate session,BoardDeclare bd);
	
	int insertBlack(SqlSessionTemplate session,String declareWriter);
}
