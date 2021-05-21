package com.kh.sharecarrot.transactionhistory.model.dao;

import java.util.List;

import com.kh.sharecarrot.member.model.vo.Member;

public interface TransactionHistoryDao {

	List<Member> selectBuyer(String productId);

}
