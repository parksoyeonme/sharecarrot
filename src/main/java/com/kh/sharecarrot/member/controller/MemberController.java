package com.kh.sharecarrot.member.controller;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.sharecarrot.member.model.service.MemberService;
import com.kh.sharecarrot.member.model.vo.Member;
import com.kh.sharecarrot.shop.model.service.ShopService;
import com.kh.sharecarrot.shop.model.vo.Shop;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/member")
@SessionAttributes("loginMember")
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private ShopService shopService;

	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@GetMapping("/memberLogin.do")
	public void memberLogin() {
	}
	
	@GetMapping("/memberDetail.do")
	public void memberDetail(Authentication authentication, Model model) { //principal로 부터 멤버 정보를 가져오는 2가지방법
		//1. secuirty context holder bean 빈으로 부터 직접 가져오는 방법
		//2. handler의 매개인자로 Authenticaiton을 기재하면 자동으로 받아온다.
		//3. @AuthenticationPrincipal 어노테이션을 붙혀주면 멤버값을 바로 불러올수 있다. Member가 userDetails를 상속받고 있기때문이다.
//		Authentication authentication =
//		SecurityContextHolder.getContext().getAuthentication(); // 여기에 인증된 사용자 정보가있다.
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		//UsernamePasswordAuthenticationToken 
		log.debug("member = {}",member);

		model.addAttribute("loginMember", member);
	}

	@GetMapping("/memberEnroll.do")
	public void memberEnroll() {
		
	}

    @PostMapping("/memberUpdate.do")
    public String memberUpdate(
			@RequestParam(value = "id") String memberId,
			@RequestParam(value = "name") String memberName,
			@RequestParam(value = "birthday") Date birthday,
			@RequestParam(value = "email") String email,
			@RequestParam(value = "phone") String phone,
			@RequestParam(value = "address") String address,
    		Authentication oldAuthentication,
 		    RedirectAttributes redirectAttr) {
 	    //1. 업무로직 : db 반영
    	Member updateMember = new Member(memberId, ((Member)oldAuthentication.getPrincipal()).getPassword(), memberName,
				birthday, email, phone, ((Member)oldAuthentication.getPrincipal()).isEnabled(), 
				((Member)oldAuthentication.getPrincipal()).getQuitYn(), ((Member)oldAuthentication.getPrincipal()).getMemberEnrollDate()
				, ((Member)oldAuthentication.getPrincipal()).getProfileOriginal(), ((Member)oldAuthentication.getPrincipal()).getProfileRenamed()
				, address, ((Member)oldAuthentication.getPrincipal()).getLocCode(), null);
		log.info("member = {}", updateMember);
 	    //updateMember에 authorities setting
 	    List<SimpleGrantedAuthority> authorities = new ArrayList<>();
 	    for(GrantedAuthority auth : oldAuthentication.getAuthorities()) {
 		    SimpleGrantedAuthority simpleGrantedAuthority = 
 				    new SimpleGrantedAuthority(auth.getAuthority());
 		    authorities.add(simpleGrantedAuthority);
 	    }
	   
	    updateMember.setAuthorities(authorities); 
	    //누락된 데이터처리
	   
	    //2. security context에서 principal 갱신
	    Authentication newAuthentication = 
	  		    new UsernamePasswordAuthenticationToken(
				 	    updateMember, 
					    oldAuthentication.getCredentials(),
					    oldAuthentication.getAuthorities()
					    );
	    SecurityContextHolder.getContext().setAuthentication(newAuthentication);
	   
	    //3. 사용자 피드백
	    redirectAttr.addFlashAttribute("msg", "사용자 정보 수정 성공");
	   
	    return "redirect:/member/memberDetail.do";
    }	
	
	@PostMapping("/memberEnroll.do")
	public String memberEnroll(
			@RequestParam(value = "id") String memberId,
			@RequestParam(value = "password") String memberPassword,
			@RequestParam(value = "name") String memberName,
			@RequestParam(value = "phone") String phone,
			@RequestParam(value = "email") String email,
			@RequestParam(value = "birthday") Date birthday,
			@RequestParam(value = "address2") String addr2,
			@RequestParam(value = "address3") String addr3,
			RedirectAttributes redirectAttr
//			,HttpServletRequest request
			) {
		
		try {
//			//MultipartRequest객체 생성
//			String saveDirectory = getServletContext().getRealPath("/upload/memberProfile");// / -> Web Root Directory
//			int maxPostSize = 30 * 1024 * 1024;
//			String encoding = "utf-8";
//			FileRenamePolicy policy = new MvcFileRenamePolicy();
//			MultipartRequest multipartReq = 
//					new MultipartRequest(request, saveDirectory, maxPostSize, encoding, policy);
//		
			
			String address = addr2 + addr3;
			Member member = new Member(memberId, memberPassword, memberName,
					birthday, email, phone, true, 'n', null, null, null, address, "L1", null);
			log.info("member = {}", member);
			
			Shop shop = new Shop();
			String rawPassword = member.getPassword();
			String encodedPassword = bcryptPasswordEncoder.encode(rawPassword);
			log.info("rawPassword = {}", rawPassword);
			log.info("encodedPassword = {}", encodedPassword);			
			member.setMemberPassword(encodedPassword);
			
			//1. 업무로직
			int result = memberService.memberEnroll(member);
			shop.setShopId(member.getMemberId().substring(0, 1) + String.valueOf((int)(Math.random()*9)+1));
			shop.setMemberId(memberId);
			shopService.shopEnroll(shop);
		}catch(Exception e) {
			//1. 로깅작업
			log.error(e.getMessage(), e);
			//2. 다시 spring container에 던질 것.
			throw e;
		}
		return "redirect:/";
	}
	
	@GetMapping("/checkIdDuplicate.do")
//	public ResponseEntity<Map<String, Object>> checkIdDuplicate4(@RequestParam String id){
	public ResponseEntity<?> checkIdDuplicate4(@RequestParam String id){
		//업무 로직
		Member member = memberService.selectOneMember(id);
		boolean usable = (member == null);

		//2. json 변환 객체
		Map<String, Object> map = new HashMap<>();
		map.put("usable", usable);
			
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON_UTF8);
		return new ResponseEntity<>(map, headers, HttpStatus.OK);
	}
	
    /* 이메일 인증 */
	@GetMapping("/emailCheck.do")
	@ResponseBody
    public String emailCheck(String email) throws Exception{
        
//        log.info("이메일 데이터 전송 확인");
//        log.info("인증번호 : " + email);
                
	    Random random = new Random();
	    int checkNum = random.nextInt(888888) + 111111;
        log.info("인증번호 " + checkNum);
        
        /* 이메일 보내기 */
        String host = "smtp.naver.com";
        final String username = "testyongdo1";
        final String password = "sharecarrot";
        int port = 465;
        
        String recipient = email;
        String subject = "회원가입 인증 이메일 입니다.";
        String body = 
                "홈페이지를 방문해주셔서 감사합니다." +
                "\n" + 
                "인증 번호는 " + checkNum + "입니다." + 
                "\n" + 
                "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
        
        Properties props = System.getProperties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.ssl.enable", "true");
        props.put("mail.smtp.ssl.tr ust", host);
        
        Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
        	String un=username;
        	String pw=password;
        	protected PasswordAuthentication getPasswordAuthentication() {
        		return new PasswordAuthentication(un, pw);
        	}
        });
        session.setDebug(true);
        
        Message mimeMessage = new MimeMessage(session);
        mimeMessage.setFrom(new InternetAddress("testyongdo1@naver.com"));
        mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
        mimeMessage.setSubject(subject);
        mimeMessage.setText(body);
        Transport.send(mimeMessage);
        
        return String.valueOf(checkNum);
	}	
}
