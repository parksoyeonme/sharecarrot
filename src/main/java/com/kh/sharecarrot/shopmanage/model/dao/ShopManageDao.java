package com.kh.sharecarrot.shopmanage.model.dao;

import java.util.List;

import com.kh.sharecarrot.product.model.vo.Product;
import com.kh.sharecarrot.product.model.vo.ProductImage;
import com.kh.sharecarrot.shop.model.vo.Shop;

public interface ShopManageDao {
	
	//상품 등록
	int productEnroll(Product product);
	
	//상품 이미지 리스트 등록
	int productImageEnroll(ProductImage list);

	//상점정보
	Shop selectShopInfo(String memberId);
	
	//상품 조회
	Product selectProduct(Product product);

	//상품리스트 조회
	List<Product> selectProductList(Product product);
	
	//상품리스트 카운트
	int selectProductListCount(Product product);
	
	//상품이미지리스트 조회
	List<ProductImage> selectProductImageList(Product product);

	//상품 상태 변경
	int updateProductYnh(Product product);

	//상품 삭제
	int deleteProduct(Product product);
	
	//상품 이미지 삭제
	int deleteProductImage(Product product);

	//상품 변경
	int updateProduct(Product product);

	//거래내역 리스트
	List<Product> selectTransactionList(Product product);
	
	//거래내역 카운트
	int selectTransactionListCount(Product product);

}
