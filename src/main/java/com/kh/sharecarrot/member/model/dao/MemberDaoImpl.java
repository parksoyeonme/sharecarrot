package com.kh.sharecarrot.member.model.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.sharecarrot.member.model.vo.Authority;
import com.kh.sharecarrot.member.model.vo.Member;

@Repository
public class MemberDaoImpl implements MemberDao{

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public Member selectOneMember(String id) {
		return session.selectOne("member.selectOneMember",id);
	}

	@Override
	public int memberEnroll(Member member) {
		return session.insert("member.memberEnroll",member);
	}

	@Override
	public int memberUpdate(Member updateMember) {
		return session.update("member.memberUpdate",updateMember);
	}	

	@Override
	public int memberPasswordUpdate(Member updateMember) {
		return session.update("member.memberPasswordUpdate",updateMember);
	}

	@Override
	public int setAuthority(Authority auth) {
		return session.insert("member.setAuthority", auth);
	}

	@Override
	public String selectShopMember(String memberId) {
		return session.selectOne("member.selectShopMember", memberId);
	}

	@Override
	public String findId(Map<String, Object> param) {
		
		return session.selectOne("member.findId", param);
	}

	@Override
	public Member searchPassword(Map<String, Object> param) {
		return session.selectOne("member.searchPassword", param);
	}


	
	
	
}
