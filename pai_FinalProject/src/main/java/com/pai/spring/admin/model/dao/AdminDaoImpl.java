package com.pai.spring.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.pai.spring.board.model.vo.Board;
import com.pai.spring.board.model.vo.BoardDeclare;
import com.pai.spring.board.model.vo.CommentDeclare;
import com.pai.spring.member.model.vo.Member;

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

	@Override
	public int updatePolice(SqlSessionTemplate session, String declareWriter) { 
		return session.update("admin.updatePolice", declareWriter);
	}

	@Override
	public int updateBoardDeclare(SqlSessionTemplate session, BoardDeclare bd) { 
		return session.update("admin.updateBoardDeclare", bd);
	}

	@Override
	public int insertBlack(SqlSessionTemplate session, String declareWriter) { 
		return session.update("admin.insertBlack",declareWriter);
	}

	@Override
	public BoardDeclare selectBoardDeclare(SqlSessionTemplate session, Map param) { 
		return session.selectOne("admin.selectBoardDeclare", param);
	}

	@Override
	public CommentDeclare selectCommentDeclare(SqlSessionTemplate session, Map param) { 
		return session.selectOne("admin.selectCommentDeclare", param);
	}

	@Override
	public int commentDeclareCount(SqlSessionTemplate session, CommentDeclare cd) { 
		return session.update("admin.updateCommentDeclare", cd);
	}

	@Override
	public Member selectMember(SqlSessionTemplate session, String CommentWriter) { 
		return session.selectOne("admin.selectMember", CommentWriter);
	}

}
