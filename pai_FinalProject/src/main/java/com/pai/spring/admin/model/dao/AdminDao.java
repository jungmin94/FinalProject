package com.pai.spring.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.pai.spring.board.model.vo.BoardDeclare;
import com.pai.spring.board.model.vo.CommentDeclare;
import com.pai.spring.member.model.vo.Member;

public interface AdminDao {

	List<BoardDeclare> boardDeclareList(SqlSessionTemplate session,int cPage,int numPerPage);
	
	int boardDeclareCount(SqlSessionTemplate session);
	
	List<BoardDeclare> commentDeclareList(SqlSessionTemplate session,int cPage,int numPerPage);
	
	int commentDeclareCount(SqlSessionTemplate session);
	
	int updatePolice(SqlSessionTemplate session,String declareWriter);
	
	int updateBoardDeclare(SqlSessionTemplate session,BoardDeclare bd);
	
	int insertBlack(SqlSessionTemplate session,String declareWriter);
	
	BoardDeclare selectBoardDeclare(SqlSessionTemplate session, Map param);
	
	CommentDeclare selectCommentDeclare(SqlSessionTemplate session,Map param);
	
	int commentDeclareCount(SqlSessionTemplate session,CommentDeclare cd);
	
	Member selectMember(SqlSessionTemplate session,String CommentWriter);
	
	List<Member> memberList(SqlSessionTemplate session,int cPage,int numPerPage);
	
	int memberCount(SqlSessionTemplate session);
	
	List<Member> searchMemberList(SqlSessionTemplate session,Map param,int cPage,int numPerPage);
	
	int searchMemberCount(SqlSessionTemplate session);
}
