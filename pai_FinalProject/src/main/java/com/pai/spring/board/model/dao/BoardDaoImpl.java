package com.pai.spring.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.pai.spring.board.model.vo.AttachFile;
import com.pai.spring.board.model.vo.Board;
import com.pai.spring.board.model.vo.BoardComment;
import com.pai.spring.board.model.vo.BoardDeclare;
import com.pai.spring.board.model.vo.BoardLike;
import com.pai.spring.member.model.vo.Member;

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
		return session.delete("board.deleteFile", boardNo);
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

	@Override
	public int deleteBoard(SqlSessionTemplate session, int boardNo) { 
		return session.delete("board.deleteBoard", boardNo);
	}

	@Override
	public int commentDelete(SqlSessionTemplate session, int commentNo) { 
		return session.delete("board.commentDelete", commentNo);
	}

	@Override
	public int updateBoardReadCount(SqlSessionTemplate session, int boardNo) { 
		return session.update("board.updateBoardReadCount",boardNo);
	}

	@Override
	public List<Board> readList(SqlSessionTemplate session) { 
		return session.selectList("board.readList");
	}

	@Override
	public Member selectMember(SqlSessionTemplate session, String memberId) { 
		return session.selectOne("board.selectMember",memberId);
	}

	@Override
	public BoardLike selectBoardLike(SqlSessionTemplate session, Map param) { 
		return session.selectOne("board.selectBoardLike",param);
	}

	@Override
	public int insertBoardLike(SqlSessionTemplate session, Map param) { 
		return session.insert("board.insertBoardKike", param);
	}

	@Override
	public int updateRecommendCount(SqlSessionTemplate session,Map param) { 
		return session.update("board.updateRecommendCount",param);
	}

	@Override
	public int deleteBoardLike(SqlSessionTemplate session, Map param) { 
		return session.delete("board.deleteBoardLike",param);
	}

	@Override
	public int deleteRecommendCount(SqlSessionTemplate session, Map param) { 
		return session.update("board.deleteRecommendCount", param);
	}

	@Override
	public List<Board> likeList(SqlSessionTemplate session) { 
		return session.selectList("board.likeList");
	}

	@Override
	public List<Board> boardReadList(SqlSessionTemplate session, int cPage, int numPerPage) {
		RowBounds rb=new RowBounds((cPage-1)*numPerPage,numPerPage);
		return session.selectList("board.boardReadList",null,rb);
	}
	
	@Override
	public List<Board> boardLikeList(SqlSessionTemplate session, int cPage, int numPerPage) {
		RowBounds rb=new RowBounds((cPage-1)*numPerPage,numPerPage);
		return session.selectList("board.boardLikeList",null,rb);
	}

	@Override
	public int insertDeclare(SqlSessionTemplate session, BoardDeclare bd) { 
		return session.insert("board.insertDeclare", bd);
	}

	@Override
	public List<Board> previewBoardList(SqlSessionTemplate session, String memberId) { 
		return session.selectList("board.previewBoardList", memberId);
	}

	@Override
	public List<BoardComment> previewCommentList(SqlSessionTemplate session, String memberNick) { 
		return session.selectList("board.previewCommentList",memberNick);
	}

	@Override
	public List<Board> myboardList(SqlSessionTemplate session, int cPage, int numPerPage, String memberId) { 
		RowBounds rb=new RowBounds((cPage-1)*numPerPage,numPerPage);
		return session.selectList("board.myboardList", memberId, rb);
	}

	@Override
	public int selectMyBoardCount(SqlSessionTemplate session, String memberId) { 
		return session.selectOne("board.selectMyBoardCount", memberId);
	}

	@Override
	public List<BoardComment> myboardCommentList(SqlSessionTemplate session, int cPage, int numPerPage,
			String memberId) { 
		RowBounds rb=new RowBounds((cPage-1)*numPerPage,numPerPage);
		return session.selectList("board.myboardCommentList", memberId, rb);
	}

	@Override
	public int selectCommentAll(SqlSessionTemplate session, String memberNick) { 
		return session.selectOne("board.selectCommentAll",memberNick);
	}

	@Override
	public List<BoardDeclare> declareList(SqlSessionTemplate session, int cPage, int numPerPage, String memberId) {
		RowBounds rb=new RowBounds((cPage-1)*numPerPage,numPerPage);
		return session.selectList("board.declareList",memberId,rb);
	}

	@Override
	public int selectDeclareCount(SqlSessionTemplate session, String memberId) { 
		return session.selectOne("board.selectDeclareCount", memberId);
	}

	@Override
	public List<Board> infoList(SqlSessionTemplate session) { 
		return session.selectList("board.infoList");
	}

	@Override
	public List<Board> topList(SqlSessionTemplate session) { 
		return session.selectList("board.topList");
	}

	@Override
	public List<Board> mainList(SqlSessionTemplate session) { 
		return session.selectList("board.mainList");
	}


	
}
