package com.kh.sharecarrot.product.model.service;

import java.util.List;

import com.kh.sharecarrot.product.model.vo.Product;
import com.kh.sharecarrot.product.model.vo.ProductImage;

public interface ProductService {

	List<Product> searchLocation(String locName);

	List<Product> searchTitle(String productName);





}
