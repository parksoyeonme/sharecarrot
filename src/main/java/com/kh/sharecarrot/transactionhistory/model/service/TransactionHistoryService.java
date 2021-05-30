package com.kh.sharecarrot.transactionhistory.model.service;

import java.util.List;

import com.kh.sharecarrot.member.model.vo.Member;

public interface TransactionHistoryService {

	List<Member> selectBuyer(String productId);

	
	
}
