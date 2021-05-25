package com.kh.sharecarrot.shop.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.sharecarrot.member.model.vo.Member;
import com.kh.sharecarrot.product.model.vo.Product;
import com.kh.sharecarrot.shop.model.vo.Shop;

public interface ShopDao {

	void shopEnroll(Shop shop);


	int updateVisitCount(String myshopId);

	Shop selectShopOne(Map<String, Object> param);

	List<Product> selectshopProductList(String shopId);


	int selectOpenDay(String memberId);


	String selectMemberId(String shopId);


	Shop selectShop(String shopId);


//	Member selectProfilOne(String myshopId);
}

