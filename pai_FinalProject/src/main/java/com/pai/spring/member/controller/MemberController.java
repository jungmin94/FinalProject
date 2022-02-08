package com.pai.spring.member.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.pai.spring.member.model.service.EmailSendService;
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
	private EmailSendService ess;
	
	@Autowired
	private BCryptPasswordEncoder encoder;
	
	private Logger logger=LoggerFactory.getLogger(MemberController.class);
	
	@RequestMapping("/loginMember.do")
	public String loginMember(){
		return "/member/loginMember";
	}
	
	@RequestMapping("/loginMemberEnd.do")
	public String login(@ModelAttribute Member m,Model model) {
		Member loginMember=service.login(m);
		if(loginMember!=null&&encoder.matches(m.getMember_pw(),loginMember.getMember_pw())) {
			if(loginMember.getStatus().equals("N")) {
				model.addAttribute("msg","회원님은 현재 이메일 미인증 상태입니다. 이메일 인증을 진행해 주세요 :->");
				model.addAttribute("loc","/member/loginMember.do");
				return "common/msg";
			}else if(loginMember.getStatus().equals("Y")){
				if(loginMember.getMember_mbti().equals("미입력")) {
					model.addAttribute("msg","이메일 인증이 확인되셨습니다. 커뮤니티를 본격적으로 즐기기 위해 mbti 입력 페이지로 이동됩니다.");
					model.addAttribute("loc","/member/mbti.do");
					return "common/msg";
				}else if(loginMember.getMember_mbti().equals("INTJ")||loginMember.getMember_mbti().equals("INTP")||loginMember.getMember_mbti().equals("INFJ")
						||loginMember.getMember_mbti().equals("INFP")||loginMember.getMember_mbti().equals("ISTJ")||loginMember.getMember_mbti().equals("ISTP")
						||loginMember.getMember_mbti().equals("ISFJ")||loginMember.getMember_mbti().equals("ISFP")||loginMember.getMember_mbti().equals("ENTJ")
						||loginMember.getMember_mbti().equals("ENTP")||loginMember.getMember_mbti().equals("ENFJ")||loginMember.getMember_mbti().equals("ENFP")
						||loginMember.getMember_mbti().equals("ESTJ")||loginMember.getMember_mbti().equals("ESTP")||loginMember.getMember_mbti().equals("ESFJ")
						||loginMember.getMember_mbti().equals("ESFP")){
					model.addAttribute("loginMember",loginMember);
					model.addAttribute("msg",loginMember.getMember_mbti()+"성격인 "+loginMember.getMember_nick()+"님! PAI에 접속을 환영합니다.");
					model.addAttribute("loc","/");
					return "common/msg";
				}else {
					model.addAttribute("msg","로그인에 실패하였습니다.");
					model.addAttribute("loc","/member/loginMember.do");
					return "common/msg";
				}
			}else {
				model.addAttribute("msg","로그인에 실패하였습니다.");
				model.addAttribute("loc","/member/loginMember.do");
				return "common/msg";
			}
		}else {
			model.addAttribute("msg","로그인에 실패하였습니다.");
			model.addAttribute("loc","/member/loginMember.do");
			return "common/msg";
		}
	}
	
	@RequestMapping("/logout.do")
	public String logout(HttpSession session,SessionStatus status) {
		if(!status.isComplete()) {
			status.setComplete();
		}
		session.invalidate();
		return "redirect:/home";
	}
	
	@RequestMapping("/enrollMember.do")
	public String enrollMember() {
		return "/member/enrollMember";
	}
	
	@RequestMapping(value="/enrollMemberEnd.do",
			method=RequestMethod.POST)
	public ModelAndView enrollMemberEnd(Member m,ModelAndView mv,
			@RequestParam(value="member_profile", required=false) MultipartFile[] member_profile, HttpServletRequest req)throws RuntimeException {
		logger.debug("변경 전 패스워드 : {}",m.getMember_pw());
		logger.debug("변경 후 패스워드 : {}",encoder.encode(m.getMember_pw()));
		
		m.setMember_pw(encoder.encode(m.getMember_pw()));
		
		
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
        int result=service.insertMember(m);
        
        // 이메일 인증
		String authKey = ess.sendAuthMail(m.getMember_email());
		m.setAuthKey(authKey);
			
		Map<String, String> map = new HashMap<String, String>();
		map.put("member_email", m.getMember_email());
		map.put("authKey", m.getAuthKey());
    		
		// DB 업데이트
	    int result2 = service.updateAuthKey(m);
        
		log.debug("memberData : {}",m);
		String msg="";
		String loc="";
		if(result>0) {
			msg="PAI의 회원이 되신것을 축하드립니다. 가입하신 이메일로 인증메일을 보내드렸습니다.";
			loc="/member/loginMember.do";
		}else {
			msg="회원가입실패";
			loc="/member/enrollMember.do";
		}
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.setViewName("common/msg");
		return mv;
	}
	
	// 이메일 인증 완료시
	@GetMapping("/signUpConfirm")
	public String signUpConfirm(@RequestParam Map<String, String> map, Model model){
		String member_email = map.get("member_email");
	    int result = service.updateAuthStatus(member_email);
	    
	    model.addAttribute("msg", "인증이 완료되었습니다. 로그인해주세요.");
	    model.addAttribute("loc","/member/loginMember.do");
	    return "common/msg";
	    
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
	
	// 아이디 찾기 페이지 이동
	@GetMapping("/findId")
	public String findIdViewPage() {
		return "member/findId";
	}
	
	// 아이디 찾기
	@PostMapping("/findId")
	public String findId(@RequestParam String member_email,
						 @RequestParam String member_name,
						 Model model) {
		Member m = new Member();
		m.setMember_email(member_email);
		m.setMember_name(member_name);
		Member findMember = service.findId(m);
		
		if(findMember != null) {
			String authKey = ess.sendFindIdMail(findMember.getMember_email());
			findMember.setAuthKey(authKey);
			
			Map<String, String> map = new HashMap<String, String>();
	        map.put("member_email", findMember.getMember_email());
	        map.put("authKey", findMember.getAuthKey());
			
			// DB 업데이트
			int result = service.updateAuthKey(findMember);
			
			model.addAttribute("msg", "인증 이메일을 발송했습니다. 이메일을 확인해주세요.");
			return "common/msg";
		} else {
			model.addAttribute("msg", "입력하신 정보에 해당하는 회원정보가 존재하지 않습니다.");
			return "common/msg";
		}
	}
	
	// 아이디 찾기 이메일 인증 완료시
	@GetMapping("/findIdResult")
	public String findIdResult(@RequestParam Map<String, String> map, Model model){
		String member_email = map.get("member_email");
		String authKey = map.get("authKey");
		Member m = new Member();
		m.setMember_email(member_email);
		m.setAuthKey(authKey);
		
		Member user = service.findIdResult(m);
	    
	    model.addAttribute("user", user);
	    model.addAttribute("msg", "인증이 완료되었습니다.");
	    return "member/findIdResult";
	}
	
	// 비밀번호찾기 페이지 이동
	@GetMapping("/findPwd")
	public String findPwdViewPage() {
		return "member/findPwd";
	}
	
	@PostMapping("/findPwd")
	public String findPwd(@ModelAttribute Member m,
						  Model model) {
		Member findMember = service.findPwd(m);
		
		if(findMember != null) {
			String authKey = ess.sendFindPwdMail(findMember.getMember_email());
			findMember.setAuthKey(authKey);
			
			Map<String, String> map = new HashMap<String, String>();
	        map.put("member_email", findMember.getMember_email());
	        map.put("authKey", findMember.getAuthKey());
	        
	        int result = service.updateAuthKey(findMember);
	        
	        model.addAttribute("msg", "인증 이메일을 발송했습니다. 이메일을 확인해주세요.");
			return "common/msg";
		} else {
			model.addAttribute("msg", "입력하신 정보에 해당하는 회원정보가 존재하지 않습니다.");
			return "common/msg";
		}
	}
	
	@GetMapping("/findPwdResult")
	public String findPwdResult(@RequestParam Map<String, String> map, Model model) {
		String member_email = map.get("member_email");
		String authKey = map.get("authKey");
		Member m = new Member();
		m.setMember_email(member_email);
		m.setAuthKey(authKey);
		
		
		Member user = service.findIdResult(m);
	    
	    model.addAttribute("user", user);
	    model.addAttribute("msg", "인증이 완료되었습니다.");
	    
		return "/member/findPwdResult";
	}
	@PostMapping("/findPwdUpdate")
	public String findPwdUpdate(@ModelAttribute Member m, Model model) {
		
		m.setMember_pw(encoder.encode(m.getMember_pw()));
		
		int result = service.findPwdUpdate(m);
		
		if(result > 0) {
			model.addAttribute("msg", "비밀번호 수정이 완료 되었습니다. 로그인 해주세요.");
			return "common/msg";
		} else {
			model.addAttribute("msg", "알 수 없는 오류 발생 !");
			return "common/msg";
		}
	}
	
	@RequestMapping("/mbti.do")
	public String mbtipage() {
		return "member/insertmbti";
	}
	
	@RequestMapping("/memberView.do")
	public String memberView() {
		return "member/memberView";
	}
	
}
