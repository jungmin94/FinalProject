package com.pai.spring.board.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.pai.spring.board.model.vo.Board;

@Repository
public class BoardDaoImpl implements BoardDao {

	@Override
	public List<Board> boardList(SqlSessionTemplate session,int cPage,int numPerPage) { 
		RowBounds rb=new RowBounds((cPage-1)*numPerPage,numPerPage);
		return session.selectList("board.boardList",null,rb);
	}

	@Override
	public int selectBoardCount(SqlSessionTemplate session) { 
		return session.selectOne("board.selectBoardCount");
	}

}
