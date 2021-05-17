package com.kh.sharecarrot.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.sharecarrot.member.model.service.MemberService;
import com.kh.sharecarrot.member.model.vo.Member;
import com.kh.sharecarrot.shop.model.service.ShopService;

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
	public void memberDetail(Authentication authentication, @AuthenticationPrincipal Member member, Model model) { //principal로 부터 멤버 정보를 가져오는 2가지방법
		//1. secuirty context holder bean 빈으로 부터 직접 가져오는 방법
		//2. handler의 매개인자로 Authenticaiton을 기재하면 자동으로 받아온다.
		//3. @AuthenticationPrincipal 어노테이션을 붙혀주면 멤버값을 바로 불러올수 있다. Member가 userDetails를 상속받고 있기때문이다.
//		Authentication authentication =
//		SecurityContextHolder.getContext().getAuthentication(); // 여기에 인증된 사용자 정보가있다.
		log.debug("authentication = {}", authentication); 
		//UsernamePasswordAuthenticationToken 
		log.debug("member = {}",authentication.getPrincipal());

		model.addAttribute("loginMember", authentication.getPrincipal());
		
	}

	@GetMapping("/memberEnroll.do") //2
	public void memberEnroll() {
	}
	
	@PostMapping("/memberEnroll.do")
	public String memberEnroll(Member member, RedirectAttributes redirectAttr) {
		log.info("member = {}", member);
		try {
			//0. 암호화처리
			String rawPassword = member.getPassword();
			String encodedPassword = bcryptPasswordEncoder.encode(rawPassword);
			log.info("rawPassword = {}", rawPassword);
			log.info("encodedPassword = {}", encodedPassword);			
			member.setMemberPassword(encodedPassword);
			
			//1. 업무로직
			int result = memberService.memberEnroll(member);
			Shop 
			shopService.shopEnroll(shop);
		}catch(Exception e) {
			//1. 로깅작업
			log.error(e.getMessage(), e);
			//2. 다시 spring container에 던질 것.
			throw e;
		}
		return "redirect:/";
	}
	
	
}
