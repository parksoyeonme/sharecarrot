package com.kh.security.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.kh.security.model.dao.UserDetailsDao;
import com.kh.sharecarrot.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Service("securityService")
@Slf4j
public class UserDetailsServiceImpl implements UserDetailsService {

	@Autowired
	private UserDetailsDao userDetailsDao;
	
	@Override
	public UserDetails loadUserByUsername(String id) throws UsernameNotFoundException {
		Member user = userDetailsDao.loadUserByUsername(id);
		log.debug("user = {}", user);

		if(user == null)
            throw new UsernameNotFoundException(id);
        
		return user;
//		return new UserAdapter(user); // adapter객체 사용시
	}

}