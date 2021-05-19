package com.kh.security.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.sharecarrot.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class UserDetailsDaoImpl implements UserDetailsDao{

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public Member loadUserByUsername(String id) {
		return session.selectOne("security.loadUserByUsername", id);
	}

	
	
}
