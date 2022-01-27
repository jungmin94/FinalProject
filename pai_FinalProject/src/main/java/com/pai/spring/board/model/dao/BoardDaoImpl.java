package com.pai.spring.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.pai.spring.board.model.vo.AttachFile;
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

	@Override
	public List<Board> searchBoard(SqlSessionTemplate session, Map<String, Object> param,int cPage, int numPerPage) { 
		RowBounds rb=new RowBounds((cPage-1)*numPerPage,numPerPage);
		return session.selectList("board.searchBoard",param,rb);
	}

	@Override
	public int searchBoardCount(SqlSessionTemplate session, Map<String, Object> param) { 
		return session.selectOne("board.searchBoardCount",param);
	}

	@Override
	public Board selectBoard(SqlSessionTemplate session, int boardNo) { 
		return session.selectOne("board.selectBoard",boardNo);
	}

	@Override
	public int insertBoard(SqlSessionTemplate session, Board b) { 
		return session.insert("board.insertBoard",b);
	}

	@Override
	public int insertAttachment(SqlSessionTemplate session, AttachFile f) { 
		return session.insert("board.insertAttachFile",f);
	}

	
}
