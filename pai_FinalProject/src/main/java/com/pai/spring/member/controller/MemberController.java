package com.pai.spring.member.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.pai.spring.member.model.service.MemberService;
import com.pai.spring.member.model.vo.Member;

@Controller
@SessionAttributes({"loginMember"})
@RequestMapping("/member/")
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	@Autowired
	private BCryptPasswordEncoder encoder;
	
	private Logger logger=LoggerFactory.getLogger(MemberController.class);
	
	@RequestMapping("memberLogin.do")
	public String login(@RequestParam Map param,Model model) {
		Member m=service.login(param);
		
		logger.debug("{}",m);
		if(m!=null && encoder.matches((String)param.get("member_pw"),m.getMember_pw()))
			model.addAttribute("loginMember",m);
		return "redirect:/";
	}
	
	@RequestMapping("logout.do")
	public String logout(HttpSession session,SessionStatus status) {
		if(!status.isComplete()) {
			status.setComplete();
		}
		session.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping("/member/enrollMember.do")
	public String enrollMember() {
		return "/member/enrollMember";
	}
	
	@RequestMapping(value="enrollMemberEnd.do",
			method=RequestMethod.POST)
	public String enrollMemberEnd(Member m,Model model) {
		logger.debug("변경 전 패스워드 : {}",m.getMember_pw());
		logger.debug("변경 후 패스워드 : {}",encoder.encode(m.getMember_pw()));
		
		m.setMember_pw(encoder.encode(m.getMember_pw()));
		
		int result=service.insertMember(m);
		String msg="";
		String loc="";
		if(result>0) {
			msg="회원가입성공";
			loc="/";
		}else {
			msg="회원가입실패";
			loc="/member/enrollMember.do";
		}
		model.addAttribute("msg",msg);
		model.addAttribute("loc",loc);
		return "common/msg";
	}
}
