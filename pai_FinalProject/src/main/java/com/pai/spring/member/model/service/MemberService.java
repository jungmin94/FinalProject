package com.pai.spring.member.model.service;

import java.util.Map;

import com.pai.spring.member.model.vo.Member;

public interface MemberService {
	
	Member login(Map param);
	int insertMember(Member m);
	int checkId(String member_id);
	int checkNick(String member_nick);
}
