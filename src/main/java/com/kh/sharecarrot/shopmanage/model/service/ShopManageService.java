package com.kh.sharecarrot.shopmanage.model.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;

import com.kh.sharecarrot.product.model.vo.Product;
import com.kh.sharecarrot.product.model.vo.ProductImage;

public interface ShopManageService {

	//상품등록
	int productEnroll(HttpServletRequest request, HttpServletResponse response, Product product, List<MultipartFile> list);

	//상품 불러오기
	Product selectProduct(Product product);

	//상품 리스트 불러오기
	List<Product> selectProductList(Product product);

	//상품 판매상태 변경
	int updateProductYnh(Product product);

	//상품 삭제
	int deleteProduct(Product product);

	//상품 이미지 리스트
	List<ProductImage> selectProductImageList(Product product);

}
