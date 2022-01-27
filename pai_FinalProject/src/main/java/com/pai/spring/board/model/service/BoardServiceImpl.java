package com.pai.spring.board.model.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pai.spring.board.model.dao.BoardDao;
import com.pai.spring.board.model.vo.AttachFile;
import com.pai.spring.board.model.vo.Board;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDao dao;
	
	@Autowired
	private SqlSessionTemplate session;
	
	@Override
	public List<Board> boardList(int cPage,int numPerPage) { 
		return dao.boardList(session,cPage,numPerPage);
	}

	@Override
	public int selectBoardCount() { 
		return dao.selectBoardCount(session);
	}

	@Override
	public List<Board> searchBoard(Map<String, Object> param,int cPage,int numPerPage) { 
		return dao.searchBoard(session,param,cPage,numPerPage);
	}

	@Override
	public int searchBoardCount(Map<String,Object> param) { 
		return dao.searchBoardCount(session,param);
	}

	@Override
	public Board selectBoard(int boardNo) { 
		return dao.selectBoard(session,boardNo);
	}

	@Override
	@Transactional
	public int insertBoard(Board b) { 
		int result=dao.insertBoard(session,b);
		if(result>0&&!b.getAttachFile().isEmpty()) {
			for(AttachFile f : b.getAttachFile()) {
				f.setBoardNo(b.getBoardNo());
				result=dao.insertAttachment(session,f);
			}
				
		}
		return result;
		
	}

}
