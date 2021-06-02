package com.kh.sharecarrot.member.model.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.kh.sharecarrot.member.model.dao.MemberDao;
import com.kh.sharecarrot.member.model.vo.Authority;
import com.kh.sharecarrot.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;

	/**
	 * UserDetails를 상속한 Member객체 return
	 */
	@Override
	public UserDetails loadUserByUsername(String id) throws UsernameNotFoundException {
		Member member = memberDao.selectOneMember(id);
		if(member == null) 
			throw new UsernameNotFoundException(id);
		return member;
	}

	@Override
	public int memberEnroll(Member member) {
		return memberDao.memberEnroll(member);
	}

	@Override
	public Member selectOneMember(String id) {
		return memberDao.selectOneMember(id);
	}

	@Override
	public int memberUpdate(Member updateMember) {
		return memberDao.memberUpdate(updateMember);
	}

	@Override
	public int memberPasswordUpdate(Member updateMember) {
		return memberDao.memberPasswordUpdate(updateMember);
	}
	
	@Override
	public int setAuthority(Authority auth) {
		return memberDao.setAuthority(auth);
	}

	@Override
	public String selectShopMember(String memberId) {
		return memberDao.selectShopMember(memberId);
	}

	@Override
	public String findId(Map<String, Object> param) {
		return memberDao.findId(param);
	}

	@Override
	public Member searchPassword(Map<String, Object> param) {
		
		return memberDao.searchPassword(param);
	}

	

	
	
	
}
