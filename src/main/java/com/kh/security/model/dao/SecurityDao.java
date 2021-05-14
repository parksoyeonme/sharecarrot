package com.kh.security.model.dao;

import com.kh.sharecarrot.member.model.vo.Member;

public interface SecurityDao {

	Member loadUserByUsername(String memberId);

}
