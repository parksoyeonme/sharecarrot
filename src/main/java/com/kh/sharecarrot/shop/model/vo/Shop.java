package com.kh.sharecarrot.shop.model.vo;

import java.sql.Date;
import java.util.List;
import java.util.Set;

import org.springframework.security.core.authority.SimpleGrantedAuthority;

import com.kh.sharecarrot.member.model.vo.Member;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Shop {
		private String shopId;
		private int shopTotalScore;
		private int shopVisitCount;
		private int shopSellCount;
		private String shopMemo;
		private String memberId;
		
		private List<Member> member;
}
