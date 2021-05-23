package com.kh.sharecarrot.shopmanage.model.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;

import com.kh.sharecarrot.product.model.vo.Product;
import com.kh.sharecarrot.shop.model.vo.ShopProduct;

public interface ShopManageService {

	int productEnroll(HttpServletRequest request, HttpServletResponse response, Product product, List<MultipartFile> list);

	List<Product> selectProductList(Product product);
}
