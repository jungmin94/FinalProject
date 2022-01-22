package com.pai.spring.board.model.service;

import java.util.List;
import java.util.Map;

import com.pai.spring.board.model.vo.Board;

public interface BoardService {
	List<Board> boardList(int cPage,int numPerPage);
	
	int selectBoardCount();
	
	List<Board> searchBoard(Map<String,Object> param);
	
}
