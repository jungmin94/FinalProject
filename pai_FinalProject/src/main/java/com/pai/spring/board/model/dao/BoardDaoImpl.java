package com.pai.spring.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.pai.spring.board.model.vo.AttachFile;
import com.pai.spring.board.model.vo.Board;
import com.pai.spring.board.model.vo.BoardComment;

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

	@Override
	public int updateBoard(SqlSessionTemplate session, Board b) { 
		return session.update("board.updateBoard",b);
	}

	@Override
	public int deleteFile(SqlSessionTemplate session, int boardNo) { 
		return session.delete("board.deleteBoard", boardNo);
	}

	@Override
	public int insertComment(SqlSessionTemplate session, BoardComment bc) { 
		return session.insert("board.insertComment",bc);
	}

	@Override
	public int insertComment2(SqlSessionTemplate session, BoardComment bc) { 
		return session.insert("board.insertComment2",bc);
	}
	
	@Override
	public List<BoardComment> boardCommentList(SqlSessionTemplate session, int boardNo) { 
		return session.selectList("board.boardCommentList", boardNo);
	}


	
}
