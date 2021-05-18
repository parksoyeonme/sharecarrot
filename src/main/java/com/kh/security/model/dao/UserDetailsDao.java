package com.kh.security.model.dao;

import com.kh.sharecarrot.member.model.vo.Member;

public interface UserDetailsDao {

	Member loadUserByUsername(String id);

}
