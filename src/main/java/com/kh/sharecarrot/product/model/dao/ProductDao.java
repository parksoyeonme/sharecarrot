package com.kh.sharecarrot.product.model.dao;

import java.util.List;

import com.kh.sharecarrot.product.model.vo.Product;
import com.kh.sharecarrot.product.model.vo.ProductImage;

public interface ProductDao {

	List<Product> searchLocation(String locName);

	List<Product> searchTitle(String productName);

	
}
