package com.pai.spring.admin.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.pai.spring.board.model.vo.BoardDeclare;

public interface AdminDao {

	List<BoardDeclare> boardDeclareList(SqlSessionTemplate session,int cPage,int numPerPage);
	
	int boardDeclareCount(SqlSessionTemplate session);
	
	List<BoardDeclare> commentDeclareList(SqlSessionTemplate session,int cPage,int numPerPage);
	
	int commentDeclareCount(SqlSessionTemplate session);
}
