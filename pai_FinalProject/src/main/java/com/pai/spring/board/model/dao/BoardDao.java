package com.pai.spring.board.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.pai.spring.board.model.vo.AttachFile;
import com.pai.spring.board.model.vo.Board;
import com.pai.spring.board.model.vo.BoardComment;
import com.pai.spring.board.model.vo.BoardDeclare;
import com.pai.spring.board.model.vo.BoardLike;
import com.pai.spring.member.model.vo.Member;

public interface BoardDao {

	List<Board> boardList(SqlSessionTemplate session,int cPage,int numPerPage);
	
	List<Board> boardReadList(SqlSessionTemplate session,int cPage,int numPerPage);
	
	List<Board> boardLikeList(SqlSessionTemplate session,int cPage,int numPerPage);
	
	int selectBoardCount(SqlSessionTemplate session);
	
	List<Board> searchBoard(SqlSessionTemplate session,Map<String,Object> param,int cPage, int numPerPage);
	
	int searchBoardCount(SqlSessionTemplate session,Map<String,Object>param);
	
	Board selectBoard(SqlSessionTemplate session,int boardNo);
	
	int insertBoard(SqlSessionTemplate session,Board b);
	
	int insertAttachment(SqlSessionTemplate session,AttachFile f);
	
	int updateBoard(SqlSessionTemplate session,Board b);
	
	int deleteFile(SqlSessionTemplate session,int boardNo);
	
	int insertComment(SqlSessionTemplate session,BoardComment bc);
	
	int insertComment2(SqlSessionTemplate session,BoardComment bc);
	
	List<BoardComment> boardCommentList(SqlSessionTemplate session,int boardNo);
	
	int deleteBoard(SqlSessionTemplate session,int boardNo);
	
	int commentDelete(SqlSessionTemplate session,int commentNo);
	
	int updateBoardReadCount(SqlSessionTemplate session,int boardNo);
	
	List<Board> readList(SqlSessionTemplate session);
	
	Member selectMember(SqlSessionTemplate session,String memberId);	
	
	BoardLike selectBoardLike(SqlSessionTemplate session,Map param);
	
	int insertBoardLike(SqlSessionTemplate session,Map param);
	
	int updateRecommendCount(SqlSessionTemplate session, Map param);
	
	int deleteBoardLike(SqlSessionTemplate session,Map param);
	
	int deleteRecommendCount(SqlSessionTemplate session, Map param);
	
	List<Board> likeList(SqlSessionTemplate session);
	
	int insertDeclare(SqlSessionTemplate session,BoardDeclare bd);
	
	List<Board> previewBoardList(SqlSessionTemplate session,String memberId);
	
	List<BoardComment> previewCommentList(SqlSessionTemplate session,String memberNick);
	
	List<Board> myboardList(SqlSessionTemplate session,int cPage,int numPerPage,String memberId);
	
	int selectMyBoardCount(SqlSessionTemplate session,String memberId);
	
	List<BoardComment> myboardCommentList(SqlSessionTemplate session,int cPage,int numPerPage,String memberId);
	
	int selectCommentAll(SqlSessionTemplate session,String memberNick);
	
	List<BoardDeclare> declareList(SqlSessionTemplate session,int cPage,int numPerPage,String memberId );
	
	int selectDeclareCount(SqlSessionTemplate session,String memberId);
	
	List<Board> infoList(SqlSessionTemplate session);
	
	List<Board> topList(SqlSessionTemplate session);
	
	List<Board> mainList(SqlSessionTemplate session);
}
