package com.kh.sharecarrot.shop.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.sharecarrot.member.model.vo.Member;
import com.kh.sharecarrot.product.model.vo.Product;
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
	public int updateVisitCount(String myShopId) {
		// TODO Auto-generated method stub
		return session.update("shop.updateVisitCount", myShopId);
	}



	@Override
	public Shop selectShopOne(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return session.selectOne("shop.selectShopOne", param);
	}

	@Override
	public List<Product> selectshopProductList(String shopId) {
		// TODO Auto-generated method stub
		return session.selectList("shop.selectshopProductList", shopId);
	}

	@Override
	public int selectOpenDay(String memberId) {
		// TODO Auto-generated method stub
		return session.selectOne("shop.selectOpenDay", memberId);
	}

	@Override
	public String selectMemberId(String shopId) {
		return session.selectOne("shop.selectMemberId", shopId);
	}

	@Override
	public Shop selectShop(String shopId) {
		return session.selectOne("shop.selectShop", shopId);
	}

//	@Override
//	public Member selectProfilOne(String myshopId) {
//		// TODO Auto-generated method stub
//		return session.selectOne("shop.selectProfilOne", myshopId);
//	}



}
