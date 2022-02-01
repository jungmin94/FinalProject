package com.pai.spring.member.model.service;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pai.spring.member.model.dao.MemberDao;
import com.pai.spring.member.model.vo.Member;
import com.pai.spring.member.model.vo.Profile;
@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private SqlSessionTemplate session;
	
	@Autowired
	private MemberDao dao;
	
	@Override
	public Member login(Map param) {
		// TODO Auto-generated method stub
		return dao.login(session,param);
	}

	@Override
	public int insertMember(Member m) throws RuntimeException{
		// TODO Auto-generated method stub
		int result=dao.insertMember(session,m);
		if(result>0&&!m.getProfile().isEmpty()) {
			try {
				for(Profile p : m.getProfile()) {
					p.setMember_id(m.getMember_id());
					result=dao.insertProfile(session,p);
				}
			}catch(RuntimeException e) {
				throw new RuntimeException("등록실패!");
			}
		}
		return result;
	}

	@Override
	public int checkId(String member_id) {
		// TODO Auto-generated method stub
		return dao.checkId(session,member_id);
	}

	@Override
	public int checkNick(String member_nick) {
		// TODO Auto-generated method stub
		return dao.checkNick(session,member_nick);
	}
	

}
