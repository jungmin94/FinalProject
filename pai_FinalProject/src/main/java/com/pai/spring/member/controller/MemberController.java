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

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.pai.spring.member.NaverLoginBO;
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
	
	//NaverLoginBO
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;
	
	@Autowired
	private void setNaverLoginBO(NaverLoginBO naerLoginBO, NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}
	
	private Logger logger=LoggerFactory.getLogger(MemberController.class);
	
	@RequestMapping(value="/loginMember.do",method= {RequestMethod.GET,RequestMethod.POST})
	public String loginMember(ModelMap model, HttpSession session){
		/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
        String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
        
        System.out.println("네이버:" + naverAuthUrl);
        
        //네이버 
        model.addAttribute("url", naverAuthUrl);
		
		return "/member/loginMember";
	}
	
	@RequestMapping("/loginMemberEnd.do")
	public String login(@ModelAttribute Member m,Model model) {
		Member loginMember=service.login(m);
		if(loginMember!=null&&encoder.matches(m.getMember_pw(),loginMember.getMember_pw())&&loginMember.getMember_black()==0) {
			if(loginMember.getStatus().equals("N")) {
				model.addAttribute("msg","회원님은 현재 이메일 미인증 상태입니다. 이메일 인증을 진행해 주세요 :->");
				model.addAttribute("loc","/member/loginMember.do");
				return "common/msg";
			}else if(loginMember.getStatus().equals("Y")){
				if(loginMember.getMember_mbti().equals("미입력")) {
					model.addAttribute("loginMember",loginMember);
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
		}else if(loginMember.getMember_black()==1) {
			model.addAttribute("msg","회원님은 블랙리스트에 등록되었습니다.");
			model.addAttribute("loc","/member/blacklist.do");
			return "common/msg";
		}else {
			model.addAttribute("msg","로그인에 실패하였습니다.");
			model.addAttribute("loc","/member/loginMember.do");
			return "common/msg";
		}
	}
	
//	@RequestMapping("/logout.do")
//	public String logout(HttpSession session,SessionStatus status) {
//		if(!status.isComplete()) {
//			status.setComplete();
//		}
//		session.invalidate();
//		return "redirect:/home";
//	}
	
	@GetMapping("/logout")
	public String logout(SessionStatus status) {
		status.setComplete();
		return "redirect:/";
	}
	
	@RequestMapping("/enrollMember.do")
	public String enrollMember() {
		return "/member/enrollMember";
	}
	
	@RequestMapping(value="/enrollMemberEnd.do",
			method=RequestMethod.POST)
	public ModelAndView enrollMemberEnd(Member m,ModelAndView mv,
			@RequestParam(value="upfile", required=false) MultipartFile[] upfile, HttpServletRequest req)throws RuntimeException {
		logger.debug("변경 전 패스워드 : {}",m.getMember_pw());
		logger.debug("변경 후 패스워드 : {}",encoder.encode(m.getMember_pw()));
		
		m.setMember_pw(encoder.encode(m.getMember_pw()));
		
        String path = req.getServletContext().getRealPath("/resources/upload/member/");
        File f = new File(path);
        if(!f.exists()) f.mkdirs();
        for(MultipartFile mf:upfile) {
        	if(!mf.isEmpty()) {
        		try {
        			mf.transferTo(new File(path+mf.getOriginalFilename()));
        			m.setMember_profile(mf.getOriginalFilename());
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
			model.addAttribute("msg", "비밀번호가 변경 되었습니다. 다시 로그인 해주세요.");
			return "common/msg";
		} else {
			model.addAttribute("msg", "알 수 없는 오류 발생 !");
			return "common/msg";
		}
	}
	
	@RequestMapping("/mbti.do")
	public String mbtiPage() {
		return "member/insertMbti";
	}
	
	@RequestMapping("/mbtiTest.do")
	public String mbtiTest() {
		return "member/mbtiTest";
	}
	
	@PostMapping("insertMbti.do")
	public String insertMbti(@ModelAttribute("loginMember")Member m, 
							@RequestParam String member_mbti, Model model) {
		m.setMember_mbti(member_mbti);
		int result=service.insertMbti(m);
		if(result > 0) {
			model.addAttribute("msg", "MBTI 입력이 완료 되었습니다. 이제 PAI의 정식회원이 된것을 환영합니다.");
			model.addAttribute("loc", "/");
			return "common/msg";
		} else {
			model.addAttribute("msg", "알 수 없는 오류 발생 !");
			model.addAttribute("loc","/member/mbti.do");
			return "common/msg";
		}
	}
	
	@RequestMapping("/memberView.do")
	public String memberView() {
		//메인 로그인 -> 내정보보기(memberId) -> memberId받아주고,-> service memberId넣어서 filedb에 memberId 로 row조회
		//file f = service.selectProfile
		//model, modelAndview //
		//mv.addAt("f",f)
		//${f.renamedfileNAme}
		return "member/memberView";
	}
	
	// 네이버 로그인
	
	//로그인 첫 화면 요청 메소드
    @RequestMapping(value = "/naverlogin.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String login(Model model, HttpSession session) {
        
        /* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
        String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
        
        System.out.println("네이버:" + naverAuthUrl);
        
        //네이버 
        model.addAttribute("url", naverAuthUrl);

        /* 생성한 인증 URL을 View로 전달 */
        return "member/loginMember";
    }
	
	@RequestMapping(value="/callback.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session) throws IOException, ParseException {
		OAuth2AccessToken oauthToken;
		
		oauthToken = naverLoginBO.getAccessToken(session, code, state);
		
		apiResult = naverLoginBO.getUserProfile(oauthToken);
		
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);
		JSONObject jsonObj = (JSONObject) obj;
		
		JSONObject response_obj = (JSONObject)jsonObj.get("response");

		String email = (String)response_obj.get("email");
		String phone = (String)response_obj.get("mobile");
		String name = (String)response_obj.get("name");
		Member m = new Member();
		m.setMember_id(email);
		m.setMember_email(email);
		m.setMember_phone(phone);
		m.setMember_name(name);
		
		String member_pw=m.getMember_pw();
		
		Member loginMember = service.login(m);
		int result = 0;
		if(loginMember == null) {
			result = service.insertNaverAccount(m);
			if(result > 0) {
				model.addAttribute("loginMember", m);
				model.addAttribute("msg","로그인 되었습니다.");
				return "/member/callbackPage";
			} else {
				model.addAttribute("msg", "회원 가입에 실패하였습니다.");
				return "common/msg";
			}
		} else if(loginMember!=null&&loginMember.getMember_pw()!=null){
			if(loginMember.getMember_mbti().equals("미입력")) {
				model.addAttribute("loginMember",loginMember);
				model.addAttribute("msg","어서오세요! 커뮤니티를 본격적으로 즐기기 위해 mbti 입력 페이지로 이동됩니다.");
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
		} else {
			model.addAttribute("loginMember", m);
			model.addAttribute("msg","로그인 되었습니다. 상세정보 입력을 위해 입력페이지로 이동합니다.");
			return "/member/callbackPage";
		}
		
	}
	@PostMapping("/updateNaver")
	public String updateNaverAccount(@ModelAttribute("loginMember") Member m,
									 @RequestParam String member_pw,
									 @RequestParam String member_addr,
									 @RequestParam String member_nick,
									 @RequestParam String member_date,
									 @RequestParam String member_gender,
									 Model model) {
		m.setMember_pw(encoder.encode(member_pw));
		m.setMember_addr(member_addr);
		m.setMember_nick(member_nick);
		m.setMember_date(member_date);
		m.setMember_gender(member_gender);
		int result = service.updateNaverAccount(m);
		if(result > 0) {
			model.addAttribute("msg", "PAI의 가족이 되신걸 환영합니다! 커뮤니티를 본격적으로 즐기기 위해 mbti 입력 페이지로 이동됩니다.");
			model.addAttribute("loc","/member/mbti.do");
			return "common/msg";
		} else {
			model.addAttribute("msg", "정보 수정에 실패하였습니다.");
			model.addAttribute("loc","/member/callbackPage");
			return "common/msg";
		}
	}
	
	
	//회원탈퇴
	@RequestMapping(value="/deleteView", method=RequestMethod.GET)
	public String deleteView() throws Exception{
		return "/member/deleteView";
	}
    
    @RequestMapping(value="/delete", method=RequestMethod.POST)
	public String delete(String member_id,RedirectAttributes rttr,HttpSession session)throws Exception{
		service.delete(member_id);
		session.invalidate();
		rttr.addFlashAttribute("msg", "이용해주셔서 감사합니다.");
		return "redirect:/";
	}
    
    @RequestMapping(value="/pwCheck" , method=RequestMethod.POST)
	@ResponseBody
	public int pwCheck(Member m) throws Exception{
		String member_pw = service.pwCheck(m.getMember_id());
		
		if(m == null || !BCrypt.checkpw(m.getMember_pw(), member_pw)) {
			return 0;
		}
		
		return 1;
	}
    
    @RequestMapping("/blacklist.do")
    public String blacklistPage(){
    	return "/member/blacklistPage";
    }
    
    //비밀번호 변경
    @RequestMapping("/pwUpdate.do")
    public String pwUpdatePage() {
    	return "/member/updatePw";
    }
    
    @RequestMapping(value="/pwUpdateEnd.do" , method=RequestMethod.POST)
	public String pwUpdate(String member_id,String member_pw1,RedirectAttributes rttr,HttpSession session,SessionStatus status)throws Exception{
		String hashedPw = BCrypt.hashpw(member_pw1, BCrypt.gensalt());
		service.pwUpdate(member_id, hashedPw);
		rttr.addFlashAttribute("msg", "정보 수정이 완료되었습니다. 다시 로그인해주세요.");
		status.setComplete();
		return "redirect:/";
	}
}
