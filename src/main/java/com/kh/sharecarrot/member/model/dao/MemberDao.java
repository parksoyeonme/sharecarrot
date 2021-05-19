package com.kh.sharecarrot.member.model.dao;

import com.kh.sharecarrot.member.model.vo.Member;

public interface MemberDao {

	Member selectOneMember(String id);

	int memberEnroll(Member member);

}
