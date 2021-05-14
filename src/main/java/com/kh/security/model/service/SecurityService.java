package com.kh.security.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.kh.security.model.dao.SecurityDao;
import com.kh.sharecarrot.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class SecurityService implements UserDetailsService {

	@Autowired
	SecurityDao securityDao;
	
	@Override
	public UserDetails loadUserByUsername(String memberId) throws UsernameNotFoundException {
		Member user = securityDao.loadUserByUsername(memberId);
		log.debug("user = {}", user);

		if(user == null)
            throw new UsernameNotFoundException(memberId);
        
		return user;
//		return new UserAdapter(user); // adapter객체 사용시
	}

}