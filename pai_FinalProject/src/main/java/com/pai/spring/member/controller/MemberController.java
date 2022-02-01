package com.pai.spring.member.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.pai.spring.member.model.service.MemberService;
import com.pai.spring.member.model.vo.Member;
import com.pai.spring.member.model.vo.Profile;

import lombok.extern.slf4j.Slf4j;

@Controller
@SessionAttributes({"loginMember"})
@RequestMapping("/member")
@Slf4j
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	@Autowired
	private BCryptPasswordEncoder encoder;
	
	private Logger logger=LoggerFactory.getLogger(MemberController.class);
	
	@RequestMapping("/loginMember.do")
	public String loginMember(){
		return "/member/loginMember";
	}
	
	@RequestMapping("/loginMemberEnd.do")
	public String login(@RequestParam Map param,Model model) {
		Member m=service.login(param);
		
		logger.debug("{}",m);
//		if(m!=null && encoder.matches((String)param.get("member_pw"),m.getMember_pw()))
			model.addAttribute("loginMember",m);
		return "redirect:/";
	}
	
	@RequestMapping("/logout.do")
	public String logout(HttpSession session,SessionStatus status) {
		if(!status.isComplete()) {
			status.setComplete();
		}
		session.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping("/enrollMember.do")
	public String enrollMember() {
		return "/member/enrollMember";
	}
	
	@RequestMapping(value="/enrollMemberEnd.do",
			method=RequestMethod.POST)
	public ModelAndView enrollMemberEnd(Member m,ModelAndView mv,
			@RequestParam(value="member_profile", required=false) MultipartFile[] member_profile, HttpServletRequest req) {
//		logger.debug("변경 전 패스워드 : {}",m.getMember_pw());
//		logger.debug("변경 후 패스워드 : {}",encoder.encode(m.getMember_pw()));
		
//		m.setMember_pw(encoder.encode(m.getMember_pw()));
		
		
        String path = req.getServletContext().getRealPath("/resources/upload/member/");
        File f = new File(path);
        if(!f.exists()) f.mkdirs();
        
        m.setProfile(new ArrayList<Profile>());
        for(MultipartFile mf:member_profile) {
        	
        	if(!mf.isEmpty()) {
        		String originFileName = mf.getOriginalFilename(); // 원본 파일 명
        		String ext = originFileName.substring(originFileName.lastIndexOf("."));
        		String renamedFileName = UUID.randomUUID().toString().replaceAll("-", "") + ext;
        		
        		try {
        			mf.transferTo(new File(path+renamedFileName));
        			Profile p=new Profile();
        			p.setOriginalFileName(originFileName);
        			p.setRenamedFileName(renamedFileName);
        			m.getProfile().add(p);
        		} catch (IOException e) {
        			e.printStackTrace();
        		}
        }
        	
        }
        
		log.debug("memberData : {}",m);
		String msg="";
		String loc="";
		try {
			int result=service.insertMember(m);
			msg="회원가입성공";
			loc="/member/loginMember.do";
		}catch(RuntimeException e) {
			msg="회원가입실패"+e.getMessage();
			loc="/member/enrollMember.do";
		}
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("common/msg");
		return mv;
	}
	
	 //아이디 중복체크
	 @RequestMapping(value="/checkId.do",method=RequestMethod.POST)
	 @ResponseBody 
	 public int checkId(@RequestParam("member_id") String member_id){ 
		 logger.info("userIdCheck 진입");
		 logger.info("전달받은 id:"+member_id);
		 int result = service.checkId(member_id);
		 logger.info("확인 결과:"+result);
		 return result; 
	}
	 
	 //닉네임 중복체크
	 @RequestMapping(value="/checkNick.do",method=RequestMethod.POST)
	 @ResponseBody 
	 public int checkNick(@RequestParam("member_nick") String member_nick){ 
		 logger.info("checkNick 진입"); 
		 logger.info("전달받은 nick:"+member_nick);
		 int result = service.checkNick(member_nick); 
		 logger.info("확인 결과:"+result); 
		 return result; 
	 }
	 
	 //비밀번호 유효성평가
	 @RequestMapping(value = "/checkPw.do", method = RequestMethod.POST)
		@ResponseBody
		public boolean checkPw(String member_pw) {		
			logger.info("checkPw");		
			
			boolean check = false;	

			String pw_chk = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*[0-9])(?=.*[$@$!%*?&`~'\"+=])[A-Za-z[0-9]$@$!%*?&`~'\"+=]{8,15}$";
			Pattern pattern_symbol = Pattern.compile(pw_chk);		
			Matcher matcher_symbol = pattern_symbol.matcher(member_pw);		
			
			if(matcher_symbol.find()) {	
				check = true;
			}		
			return check;
		}
	
	
	
	
	
}
