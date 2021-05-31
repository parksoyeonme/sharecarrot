  
package com.kh.sharecarrot.shop.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.sharecarrot.member.model.vo.Member;
import com.kh.sharecarrot.product.model.vo.Product;
import com.kh.sharecarrot.shop.model.vo.Shop;

public interface ShopDao {

	void shopEnroll(Shop shop);


	int updateVisitCount(String shopId);

	int selectOpenDay(String shopId);


	String selectMemberId(String shopId);


	Shop selectShop(String shopId);


	String selectMembershopId(String memberId);


	int selectsellCount(String shopId);

	String selectShopId(String loginMemberId);




}