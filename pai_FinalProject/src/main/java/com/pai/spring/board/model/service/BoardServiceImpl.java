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
import com.pai.spring.board.model.vo.BoardComment;
import com.pai.spring.board.model.vo.BoardDeclare;
import com.pai.spring.board.model.vo.BoardLike;
import com.pai.spring.member.model.vo.Member;

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
	@Transactional
	public Board selectBoard(int boardNo,boolean isRead) { 
		Board b=dao.selectBoard(session,boardNo);
		if(b!=null&&!isRead) {
			int result=dao.updateBoardReadCount(session,boardNo);
			if(result>0) {
				b=dao.selectBoard(session, boardNo);
			}
		}
		
		return b;
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

	@Override
	@Transactional
	public int updateBoard(Board b) { 
		int result=dao.updateBoard(session,b);
		if(result>0&&!b.getAttachFile().isEmpty()) {
			result=dao.deleteFile(session,b.getBoardNo());
			if(result>0) {
				for(AttachFile f : b.getAttachFile()) {
					f.setBoardNo(b.getBoardNo());
					result=dao.insertAttachment(session,f);
				}
			}
		} 
		return result;
	}

	@Override
	@Transactional
	public int insertComment(BoardComment bc) { 
		return dao.insertComment(session,bc);
	}

	@Override
	@Transactional
	public int insertComment2(BoardComment bc) { 
		return dao.insertComment2(session,bc);
	}
	
	@Override
	public List<BoardComment> boardCommentList(int boardNo) { 
		return dao.boardCommentList(session,boardNo);
	}

	@Override
	@Transactional
	public int deleteBoard(int boardNo) { 
		return dao.deleteBoard(session,boardNo);
	}

	@Override
	@Transactional
	public int commentDelete(int commentNo) { 
		return dao.commentDelete(session,commentNo);
	}

	@Override
	public List<Board> readList() { 
		return dao.readList(session);
	}

	@Override
	public Member selectMember(String memberId) { 
		return dao.selectMember(session,memberId);
	}

	@Override
	public BoardLike selectBoardLike(Map param) { 
		return dao.selectBoardLike(session,param);
	}

	@Override
	@Transactional
	public int insertBoardLike(Map param) { 
		int result=dao.insertBoardLike(session,param);
			if(result>0) {
				result=dao.updateRecommendCount(session,param);
			}
		return result;
	}

	@Override
	@Transactional
	public int deleteBoardLike(Map param) { 
		int result=dao.deleteBoardLike(session,param);
		if(result>0) {
			result=dao.deleteRecommendCount(session,param);
		}
		return result;
	}

	@Override
	public List<Board> likeList() { 
		return dao.likeList(session);
	}

	@Override
	public List<Board> boardReadList(int cPage, int numPerPage) {
		 return dao.boardReadList(session,cPage,numPerPage);
	}

	@Override
	public List<Board> boardLikeList(int cPage, int numPerPage) { 
		return dao.boardLikeList(session,cPage,numPerPage);
	}

	@Override
	@Transactional
	public int insertDeclare(BoardDeclare bd) { 
		return dao.insertDeclare(session,bd);
	}

	@Override
	public List<Board> previewBoardList(String memberId) { 
		return dao.previewBoardList(session,memberId);
	}

	@Override
	public List<BoardComment> previewCommentList(String memberNick) { 
		return dao.previewCommentList(session,memberNick);
	}

	@Override
	public List<Board> myboardList(int cPage, int numPerPage, String memberId) { 
		return dao.myboardList(session,cPage,numPerPage,memberId);
	}

	@Override
	public int selectMyBoardCount(String memberId) { 
		return dao.selectMyBoardCount(session,memberId);
	}

	@Override
	public List<BoardComment> myboardCommentList(int cPage, int numPerPage, String memberId) { 
		return dao.myboardCommentList(session,cPage,numPerPage,memberId);
	}

	@Override
	public int selectCommentAll(String memberNick) { 
		return dao.selectCommentAll(session,memberNick);
	}

	@Override
	public List<BoardDeclare> declareList(int cPage, int numPerPage, String memberId) { 
		return dao.declareList(session,cPage,numPerPage,memberId);
	}

	@Override
	public int selectDeclareCount(String memberId) { 
		return dao.selectDeclareCount(session,memberId);
	}

	@Override
	public List<Board> infoList() { 
		return dao.infoList(session);
	}

	@Override
	public List<Board> topList() { 
		return dao.topList(session);
	}

	@Override
	public List<Board> mainList() { 
		return dao.mainList(session);
	}

	@Override
	public List<Board> searchMainBoard(String category) { 
		return dao.searchMainBoard(session,category);
	}

	 


}
