package com.kh.sharecarrot.product.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.sharecarrot.product.model.dao.ProductDao;
import com.kh.sharecarrot.product.model.vo.Product;
import com.kh.sharecarrot.product.model.vo.ProductDetail;
import com.kh.sharecarrot.product.model.vo.ProductImage;

@Service
public class ProductServiceImpl implements ProductService {
	
	@Autowired
	private ProductDao productDao;

	@Override
	public List<Product> searchLocation(String locName) {
		return productDao.searchLocation(locName);
	}

	@Override
	public List<Product> searchTitle(String productName) {
		return productDao.searchTitle(productName);
	}

	@Override
	public ProductDetail selectProduct(String productId) {
		return productDao.selectProduct(productId);
	}

	@Override
	public String selectLocCode(String productId) {
		return productDao.selectLocCode(productId);
	}

	@Override
	public int insertJjim(Map<String, Object> param) {
		return productDao.insertJjim(param);
	}

	
}
