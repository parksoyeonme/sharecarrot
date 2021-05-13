package com.kh.sharecarrot.member.controller;

import java.beans.PropertyEditor;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.sharecarrot.member.model.service.MemberService;
import com.kh.sharecarrot.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/member")
@SessionAttributes("loginMember")
public class MemberController {
	
	@Autowired
	private MemberService memberService;

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

}
