package com.pai.spring.admin.model.service;

import java.util.List;

import com.pai.spring.board.model.vo.BoardDeclare;

public interface AdminService {

	
	List<BoardDeclare> boardDeclareList(int cPage,int numPerPage);
	
	int boardDeclareCount();
	
	List<BoardDeclare> commentDeclareList(int cPage,int numPerPage);
	
	int commentDeclareCount();
}
