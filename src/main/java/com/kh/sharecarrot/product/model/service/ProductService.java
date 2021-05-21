package com.kh.sharecarrot.product.model.service;

import java.util.List;

import com.kh.sharecarrot.product.model.vo.Product;
import com.kh.sharecarrot.product.model.vo.ProductImage;

public interface ProductService {





	List<Product> selectProductList(String shopId);

//	List<ProductImage> selectProductImageList(Product productId);

	List<ProductImage> selectProductImageList(String productId);

	int selectProductListSize(String shopId);





}
