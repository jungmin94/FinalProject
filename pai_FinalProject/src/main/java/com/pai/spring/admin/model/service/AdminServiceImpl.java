package com.pai.spring.admin.model.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pai.spring.admin.model.dao.AdminDao;
import com.pai.spring.board.model.vo.Board;
import com.pai.spring.board.model.vo.BoardDeclare;
import com.pai.spring.board.model.vo.CommentDeclare;
import com.pai.spring.member.model.vo.Member;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminDao dao;
	
	@Autowired
	SqlSessionTemplate session;
	
	
	@Override
	public List<BoardDeclare> boardDeclareList(int cPage, int numPerPage) { 
		return dao.boardDeclareList(session,cPage,numPerPage);
	}


	@Override
	public int boardDeclareCount() { 
		return dao.boardDeclareCount(session);
	}


	@Override
	public List<BoardDeclare> commentDeclareList(int cPage, int numPerPage) { 
		return dao.commentDeclareList(session,cPage,numPerPage);
	}


	@Override
	public int commentDeclareCount() {
		// TODO Auto-generated method stub
		return dao.commentDeclareCount(session);
	}


	@Override
	@Transactional
	public int updatePolice(String declareWriter) { 
		return dao.updatePolice(session,declareWriter);
	}


	@Override
	@Transactional
	public int updateBoardDeclare(BoardDeclare bd) { 
		return dao.updateBoardDeclare(session,bd);
	}


	@Override
	@Transactional
	public int insertBlack(String declareWriter) { 
		return dao.insertBlack(session,declareWriter);
	}


	@Override
	public BoardDeclare selectBoardDeclare(Map param) { 
		return dao.selectBoardDeclare(session,param);
	}


	@Override
	public CommentDeclare selectCommentDeclare(Map param) { 
		return dao.selectCommentDeclare(session,param);
	}


	@Override
	@Transactional
	public int updateCommentDeclare(CommentDeclare cd) { 
		return dao.commentDeclareCount(session,cd);
	}


	@Override
	public Member selectMember(String commentWriter) { 
		return dao.selectMember(session,commentWriter);
	}

}
