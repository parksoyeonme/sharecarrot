package com.kh.sharecarrot.shop.model.service;

import java.util.List;

import com.kh.sharecarrot.product.model.vo.Product;
import com.kh.sharecarrot.shop.model.vo.Shop;

public interface ShopService {

	void shopEnroll(Shop shop);

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	int updateVisitCount(String shopId);

	Shop selectShopOne(String memberId);

	List<Product> selectshopProductList(String shopId);


}
