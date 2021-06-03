package com.kh.sharecarrot.member.model.service;

import java.util.Map;

import org.springframework.security.core.userdetails.UserDetailsService;

import com.kh.sharecarrot.member.model.vo.Authority;
import com.kh.sharecarrot.member.model.vo.Member;

public interface MemberService extends UserDetailsService {
	
	String ROLE_USER = "USER";
	String ROLE_ADMIN = "ADMIN";
	// 인터페이스에 선언한 변수는 public static final ~~ 과 같은 의미를 지닌다.
	int memberEnroll(Member member);
	Member selectOneMember(String id);
	int memberUpdate(Member updateMember);
	int memberPasswordUpdate(Member updateMember);
	int setAuthority(Authority auth);
	String selectShopMember(String memberId);
	String findId(Map<String, Object> param);
	Member searchPassword(Map<String, Object> param);
	

}
