package com.kh.sharecarrot.shop.model.service;

import java.util.List;
import java.util.Map;

import com.kh.sharecarrot.member.model.vo.Member;
import com.kh.sharecarrot.product.model.vo.Product;
import com.kh.sharecarrot.shop.model.vo.Shop;

public interface ShopService {

	void shopEnroll(Shop shop);
	
	int updateVisitCount(String shopId);

	Shop selectShopOne(Map<String, Object> param);

	List<Product> selectshopProductList(String shopId);


	int selectOpenDay(String shopId);

	String selectMemberId(String shopId);

	Shop selectShop(String shopId);

	Member selectProfilOne(String shopId);

	String selectMembershopId(String memberId);

	int selectsellCount(String shopId);




}
