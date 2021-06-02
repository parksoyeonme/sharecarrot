package com.kh.sharecarrot.product.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.sharecarrot.product.model.vo.Product;
import com.kh.sharecarrot.product.model.vo.ProductDetail;
import com.kh.sharecarrot.product.model.vo.ProductImage;

public interface ProductDao {



	List<Product> selectProductList(Map<String, Object> param);

//	List<ProductImage> selectProductImageList(Product productId);

	List<ProductImage> selectProductImageList(String productId);

	int selectProductListSize(String shopId);

	List<Product> searchLocation(Map<String, Object> param);
	int searchLocationSize(String locName);

	List<Product> searchTitle(Map<String, Object> param);
	int searchTitleSize(String productName);
	

	ProductDetail selectProductDetail(String productId);

	String selectLocCode(String productId);

	int insertJjim(Map<String, Object> param);

	int getTotalContents(String shopId);

	Product selectProduct(String productId);

	List<Product> selectProductList(String categoryCode);


	
}
