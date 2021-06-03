package com.kh.sharecarrot.shopmanage.model.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;

import com.kh.sharecarrot.product.model.vo.Product;
import com.kh.sharecarrot.product.model.vo.ProductImage;
import com.kh.sharecarrot.storereviews.model.vo.StoreReviews;
import com.kh.sharecarrot.transactionhistory.model.vo.TransactionHistory;
import com.kh.sharecarrot.utils.model.vo.JjimList;

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

	//상품 수정
	int updateProduct(Product product);

	//상품 수정 신규 이미지
	int updateProductNewImage(HttpServletRequest request, Product product, List<MultipartFile> list);

	//상품 리스트 페이징
	Map<String,Integer> getProductListPaging(Product product);

	//거래내역 리스트
	List<Product> selectTransactionList(Product product);
	
	//거래내역 리스트 페이징
	Map<String,Integer> getTransactionListPaging(Product product);

	//거래완료시 찜리스트 조회
	List<JjimList> selectProductJjimList(Product product);
	
	//거래완료시 이력 저장
	int insertTransactionHistory(TransactionHistory history);
	
	//리뷰작성
	int insertStoreReview(StoreReviews review);

	//리뷰조회
	StoreReviews selectStoreReview(StoreReviews review);

}
