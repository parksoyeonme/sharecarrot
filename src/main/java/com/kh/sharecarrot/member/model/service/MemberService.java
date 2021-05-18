package com.kh.sharecarrot.member.model.service;

import org.springframework.security.core.userdetails.UserDetailsService;

import com.kh.sharecarrot.member.model.vo.Member;

public interface MemberService extends UserDetailsService {
	
	String ROLE_USER = "USER";
	String ROLE_ADMIN = "ADMIN";
	// 인터페이스에 선언한 변수는 public static final ~~ 과 같은 의미를 지닌다.
	int memberEnroll(Member member);
	Member selectOneMember(String id);

}
