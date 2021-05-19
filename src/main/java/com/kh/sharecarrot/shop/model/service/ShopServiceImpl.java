package com.kh.sharecarrot.shop.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.sharecarrot.product.model.vo.Product;
import com.kh.sharecarrot.shop.model.dao.ShopDao;
import com.kh.sharecarrot.shop.model.vo.Shop;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ShopServiceImpl implements ShopService{
	
	@Autowired
	private ShopDao shopDao;
	
	public void shopEnroll(Shop shop) {
		shopDao.shopEnroll(shop);
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	@Override
	public int updateVisitCount(String shopId) {
		// TODO Auto-generated method stub
		return shopDao.updateVisitCount(shopId);
	}

	@Override
	public Shop selectShopOne(String memberId) {
		// TODO Auto-generated method stub
		return shopDao.selectShopOne(memberId);
	}



	@Override
	public List<Product> selectProductList(String shopId) {
		// TODO Auto-generated method stub
		return shopDao.selectProductList(shopId);
	}



	


	
}
