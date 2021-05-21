package com.kh.sharecarrot.transactionhistory.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.sharecarrot.member.model.vo.Member;
import com.kh.sharecarrot.transactionhistory.model.dao.TransactionHistoryDao;

@Service
public class TransactionHistoryServiceImpl implements TransactionHistoryService {

	@Autowired
	private TransactionHistoryDao transactionHistoryDao;

	@Override
	public List<Member> selectBuyer(String productId) {
		return transactionHistoryDao.selectBuyer(productId);
	}
}
