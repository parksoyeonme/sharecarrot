package com.kh.sharecarrot.transactionhistory.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.sharecarrot.member.model.vo.Member;

@Repository
public class TransactionHistoryDaoImpl implements TransactionHistoryDao {

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public List<Member> selectBuyer(String productId) {
		return session.selectList("transactionhistory.selectBuyer",productId);
	}
	
}
