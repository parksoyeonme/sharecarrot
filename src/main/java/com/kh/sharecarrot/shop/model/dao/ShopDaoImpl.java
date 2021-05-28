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
	public int updateVisitCount(String shopId) {
		return session.update("shop.updateVisitCount", shopId);
	}



	@Override
	public Shop selectShopOne(Map<String, Object> param) {
		return session.selectOne("shop.selectShopOne", param);
	}

	@Override
	public List<Product> selectshopProductList(String shopId) {
		return session.selectList("shop.selectshopProductList", shopId);
	}

	@Override
	public int selectOpenDay(String shopId) {
		return session.selectOne("shop.selectOpenDay", shopId);
	}

	@Override
	public String selectMemberId(String shopId) {
		return session.selectOne("shop.selectMemberId", shopId);
	}

	@Override
	public Shop selectShop(String shopId) {
		return session.selectOne("shop.selectShop", shopId);
	}

	@Override
	public Member selectProfilOne(String shopId) {
		return session.selectOne("shop.selectProfilOne", shopId);
	}

	@Override

	public String selectMembershopId(String memberId) {
		return session.selectOne("shop.selectMembershopId", memberId);
	}

	public String selectShopId(String loginMemberId) {
		return session.selectOne("shop.selectShopId", loginMemberId);
	}



	@Override
	public int selectsellCount(String shopId) {
		return session.selectOne("shop.selectsellCount", shopId);
	}


}
