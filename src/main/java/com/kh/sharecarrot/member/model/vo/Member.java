package com.kh.sharecarrot.member.model.vo;

import java.io.Serializable;
import java.sql.Date;
import java.util.Collection;
import java.util.Set;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Member implements Serializable, UserDetails {
	
	private static final long serialVersionUID = 1L;
	
	private String memberId;
	private String memberPassword;
	private String memberName;
	private Date birthday;
	private String email;
	private String phone;
	private boolean enabled;
	private char quitYn;
	private Date memberEnrollDate;
	private String profileOriginal;
	private String profileRenamed;
	private String memberAddr;
	private String locCode;
	
	private Set<SimpleGrantedAuthority> authorities;
	

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return authorities;
	}

	@Override
	public String getUsername() {
		return memberId;
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public String getPassword() {
		return memberPassword;
	}
	
	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return true;
	}
}
