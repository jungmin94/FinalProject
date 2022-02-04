package com.pai.spring.admin.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.pai.spring.board.model.vo.BoardDeclare;

@Repository
public class AdminDaoImpl implements AdminDao {

	@Override
	public List<BoardDeclare> boardDeclareList(SqlSessionTemplate session, int cPage, int numPerPage) { 
		RowBounds rb=new RowBounds((cPage-1)*numPerPage,numPerPage);
		return session.selectList("admin.boardDeclareList", null, rb);
	}

	@Override
	public int boardDeclareCount(SqlSessionTemplate session) { 
		return session.selectOne("admin.boardDeclareCount");
	}

	@Override
	public List<BoardDeclare> commentDeclareList(SqlSessionTemplate session, int cPage, int numPerPage) { 
		RowBounds rb=new RowBounds((cPage-1)*numPerPage,numPerPage);
		return session.selectList("admin.commentDeclareList", null, rb);
	}

	@Override
	public int commentDeclareCount(SqlSessionTemplate session) { 
		return session.selectOne("admin.commentDeclareCount");
	}

}
