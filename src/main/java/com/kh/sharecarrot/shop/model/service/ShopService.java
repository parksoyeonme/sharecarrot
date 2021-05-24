package com.kh.sharecarrot.shop.model.service;

import java.util.List;
import java.util.Map;

import com.kh.sharecarrot.member.model.vo.Member;
import com.kh.sharecarrot.product.model.vo.Product;
import com.kh.sharecarrot.shop.model.vo.Shop;

public interface ShopService {

	void shopEnroll(Shop shop);
	
	int updateVisitCount(String myshopId);

	Shop selectShopOne(Map<String, Object> param);

	List<Product> selectshopProductList(String shopId);


	int selectOpenDay(String memberId);

//	Member selectProfilOne(String myshopId);


}
