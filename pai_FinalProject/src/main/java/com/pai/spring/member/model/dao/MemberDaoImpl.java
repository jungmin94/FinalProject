package com.pai.spring.member.model.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.pai.spring.member.model.vo.Member;
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

}
