package com.pai.spring.member.model.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.pai.spring.member.model.vo.Member;
import com.pai.spring.member.model.vo.Profile;
@Repository
public class MemberDaoImpl implements MemberDao {

	@Override
	public Member login(SqlSessionTemplate session, Map param) {
		// TODO Auto-generated method stub
		return session.selectOne("member.selectMember",param);
	}

	@Override
	public int insertMember(SqlSessionTemplate session, Member m) {
		// TODO Auto-generated method stub
		return session.insert("member.insertMember",m);
	}

	@Override
	public int checkId(SqlSessionTemplate session, String member_id) {
		// TODO Auto-generated method stub
		return session.selectOne("member.checkId",member_id);
	}

	@Override
	public int checkNick(SqlSessionTemplate session, String member_nick) {
		// TODO Auto-generated method stub
		return session.selectOne("member.checkNick",member_nick);
	}

	@Override
	public int insertProfile(SqlSessionTemplate session, Profile p) {
		// TODO Auto-generated method stub
		return session.insert("member.insertProfile", p);
	}

	@Override
	public int updateAuthKey(SqlSessionTemplate session, Member m) {
		// TODO Auto-generated method stub
		return session.update("member.updateAuthKey",m);
	}

	@Override
	public int updateAuthStatus(SqlSessionTemplate session, String member_email) {
		// TODO Auto-generated method stub
		return session.update("member.updateAuthStatus",member_email);
	}

	@Override
	public Member findId(SqlSessionTemplate session, Member m) {
		// TODO Auto-generated method stub
		return session.selectOne("member.findId",m);
	}

	@Override
	public Member findIdResult(SqlSessionTemplate session, Member m) {
		// TODO Auto-generated method stub
		return session.selectOne("member.findIdResult", m);
	}

	@Override
	public Member findPwd(SqlSessionTemplate session, Member m) {
		// TODO Auto-generated method stub
		return session.selectOne("member.findPwd",m);
	}

	@Override
	public int findPwdUpdate(SqlSessionTemplate session, Member m) {
		// TODO Auto-generated method stub
		return session.update("member.findPwdUpdate",m);
	}

	
	
	

}
