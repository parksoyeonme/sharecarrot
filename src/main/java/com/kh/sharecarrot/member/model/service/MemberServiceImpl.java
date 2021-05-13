package com.kh.sharecarrot.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.kh.sharecarrot.member.model.dao.MemberDao;
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
	
}
