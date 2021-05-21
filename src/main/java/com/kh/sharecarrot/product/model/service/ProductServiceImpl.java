package com.kh.sharecarrot.product.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.sharecarrot.product.model.dao.ProductDao;
import com.kh.sharecarrot.product.model.vo.Product;
import com.kh.sharecarrot.product.model.vo.ProductImage;

@Service
public class ProductServiceImpl implements ProductService {
	
	@Autowired
	private ProductDao productDao;

	

	@Override
	public List<Product> selectProductList(String shopId) {
		// TODO Auto-generated method stub
		return productDao.selectProductList(shopId);
	}



//	@Override
//	public List<ProductImage> selectProductImageList(Product productId) {
//		// TODO Auto-generated method stub
//		return productDao.selectProductImageList(productId);
//	}



	@Override
	public List<ProductImage> selectProductImageList(String productId) {
		return productDao.selectProductImageList(productId);
	}



	@Override
	public int selectProductListSize(String shopId) {
		return productDao.selectProductListSize(shopId);
	}

	
}
