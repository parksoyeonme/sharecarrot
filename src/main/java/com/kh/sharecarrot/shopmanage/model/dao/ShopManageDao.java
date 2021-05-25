package com.kh.sharecarrot.shopmanage.model.dao;

import java.util.List;

import com.kh.sharecarrot.product.model.vo.Product;
import com.kh.sharecarrot.product.model.vo.ProductImage;
import com.kh.sharecarrot.shop.model.vo.Shop;

public interface ShopManageDao {
	
	int productEnroll(Product product);
	
	int productImageEnroll(ProductImage list);

	Shop selectShopInfo(String memberId);

	List<Product> selectProductList(Product product);
	
	List<ProductImage> selectProductImageList(Product product);

	int updateProductYnh(Product product);

	int deleteProduct(Product product);

}
