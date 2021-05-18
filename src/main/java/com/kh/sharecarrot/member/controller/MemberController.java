package com.kh.sharecarrot.member.controller;

import java.sql.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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

	@GetMapping("/memberEnroll.do")
	public void memberEnroll() {
	
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
			RedirectAttributes redirectAttr) {
		
		try {
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
			shop.setShopId(member.getMemberId().substring(0, 1) + String.valueOf(Math.random()*(90)+10));
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
	
}
