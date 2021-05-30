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
	public List<Product> searchLocation(Map<String, Object> param) {
		return productDao.searchLocation(param);
	}
	
	@Override
	public int searchLocationSize(String locName) {
		return productDao.searchLocationSize(locName);
	}

	@Override
	public List<Product> searchTitle(Map<String, Object> param) {
		return productDao.searchTitle(param);
	}
	
	@Override
	public int searchTitleSize(String productName) {
		return productDao.searchTitleSize(productName);
	}

	@Override
	public ProductDetail selectProductDetail(String productId) {
		return productDao.selectProductDetail(productId);
	}

	@Override
	public String selectLocCode(String productId) {
		return productDao.selectLocCode(productId);
	}

	@Override
	public int insertJjim(Map<String, Object> param) {
		return productDao.insertJjim(param);
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

	@Override
	public List<Product> selectProductList(Map<String, Object> param) {
		return productDao.selectProductList(param);
	}

	@Override
	public int getTotalContents(String shopId) {
		// TODO Auto-generated method stub
		return productDao.getTotalContents(shopId);
	}

	@Override
	public Product selectProduct(String productId) {
		return productDao.selectProduct(productId);
	}

	@Override
	public List<Product> selectProductList(String categoryCode) {
		return productDao.selectProductList(categoryCode);
	}

	
}
