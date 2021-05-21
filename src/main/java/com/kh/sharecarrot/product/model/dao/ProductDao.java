package com.kh.sharecarrot.product.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.sharecarrot.product.model.vo.Product;
import com.kh.sharecarrot.product.model.vo.ProductDetail;
import com.kh.sharecarrot.product.model.vo.ProductImage;

public interface ProductDao {



	List<Product> selectProductList(String shopId);

//	List<ProductImage> selectProductImageList(Product productId);

	List<ProductImage> selectProductImageList(String productId);

	int selectProductListSize(String shopId);

	List<Product> searchLocation(String locName);

	List<Product> searchTitle(String productName);
	

	ProductDetail selectProduct(String productId);

	String selectLocCode(String productId);

	int insertJjim(Map<String, Object> param);


	
}
