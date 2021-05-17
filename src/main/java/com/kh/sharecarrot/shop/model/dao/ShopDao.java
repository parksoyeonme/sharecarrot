package com.kh.sharecarrot.shop.model.dao;

import com.kh.sharecarrot.shop.model.vo.Shop;

public interface ShopDao {

	void shopEnroll(Shop shop);

	int updateVisitCount(String shopId);

	Shop selectShopOne(String memberId);



}
