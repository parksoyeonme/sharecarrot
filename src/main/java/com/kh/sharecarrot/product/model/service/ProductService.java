package com.kh.sharecarrot.product.model.service;

import java.util.List;
import java.util.Map;

import com.kh.sharecarrot.product.model.vo.Product;
import com.kh.sharecarrot.product.model.vo.ProductDetail;
import com.kh.sharecarrot.product.model.vo.ProductImage;

public interface ProductService {

	List<Product> searchLocation(String locName);

	List<Product> searchTitle(String productName);

	ProductDetail selectProductDetail(String productId);

	String selectLocCode(String productId);

	int insertJjim(Map<String, Object> param);





	List<Product> selectProductList(Map<String, Object> param);

//	List<ProductImage> selectProductImageList(Product productId);

	List<ProductImage> selectProductImageList(String productId);

	int selectProductListSize(String shopId);

	int getTotalContents(String shopId);

	Product selectProduct(String productId);

	List<Product> selectProductList(String categoryCode);





}
