package com.pai.spring.member.model.dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.pai.spring.member.model.vo.Member;
import com.pai.spring.member.model.vo.Profile;
@Repository
public class MemberDaoImpl implements MemberDao {

	@Override
	public Member login(SqlSessionTemplate session, Member m) {
		// TODO Auto-generated method stub
		return session.selectOne("member.login",m);
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

//	@Override
//	public int insertProfile(SqlSessionTemplate session, Profile p) {
//		// TODO Auto-generated method stub
//		return session.insert("member.insertProfile", p);
//	}

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

	@Override
	public int insertMbti(SqlSessionTemplate session, Member m) {
		// TODO Auto-generated method stub
		return session.update("member.insertMbti",m);
	}

	@Override
	public int insertNaverAccount(SqlSessionTemplate session, Member loginMember) {
		// TODO Auto-generated method stub
		return session.insert("member.insertNaverAccount", loginMember);
	}

	@Override
	public int updateNaverAccount(SqlSessionTemplate session, Member m) {
		// TODO Auto-generated method stub
		return session.update("member.updateNaverAccount", m);
	}

	@Override
	public int delete(SqlSessionTemplate session, String member_id) throws Exception {
		// TODO Auto-generated method stub
		return session.delete("member.delete",member_id);
	}

	@Override
	public String pwCheck(SqlSessionTemplate session, String member_id) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne("member.pwCheck",member_id);
	}

	@Override
	public int pwUpdate(SqlSessionTemplate session, String member_id, String hashedPw) throws Exception {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("member_id", member_id);
		map.put("member_pw", hashedPw);
		return session.update("member.pwUpdate", map);
	}
	@Override
	public int updateMember(SqlSessionTemplate session, Member m) {
		// TODO Auto-generated method stub
		return session.update("member.updateMember",m);
	}

	
	
	

}
