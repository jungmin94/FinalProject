package com.pai.spring.member.model.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.pai.spring.member.model.vo.Member;
import com.pai.spring.member.model.vo.Profile;

public interface MemberDao {

	Member login(SqlSessionTemplate session, Map param);
	
	int insertMember(SqlSessionTemplate session,Member m);
	
	int insertProfile(SqlSessionTemplate session,Profile p);
	
	int checkId(SqlSessionTemplate session,String member_id);
	
	int checkNick(SqlSessionTemplate session,String member_nick);
}
