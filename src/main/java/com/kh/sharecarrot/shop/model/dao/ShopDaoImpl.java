package com.kh.sharecarrot.shop.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.sharecarrot.shop.model.vo.Shop;

@Repository
public class ShopDaoImpl implements ShopDao{

	@Autowired
	private SqlSessionTemplate session;
	
	@Override
	public void shopEnroll(Shop shop) {
		session.insert("shop.shopEnroll", shop);
	}

	@Override
	public int updateVisitCount(String shopId) {
		// TODO Auto-generated method stub
		return session.update("shop.updateVisitCount", shopId);
	}

	@Override
	public Shop selectShopOne(String memberId) {
		// TODO Auto-generated method stub
		return session.selectOne("shop.selectShopOne", memberId);
	}

	

}
