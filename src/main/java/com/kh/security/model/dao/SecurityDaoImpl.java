package com.kh.security.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import com.kh.sharecarrot.member.model.vo.Member;

public class SecurityDaoImpl implements SecurityDao{

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public Member loadUserByUsername(String memberId) {
		return session.selectOne("security.loadUserByUsername", memberId);
	}

	
	
}
