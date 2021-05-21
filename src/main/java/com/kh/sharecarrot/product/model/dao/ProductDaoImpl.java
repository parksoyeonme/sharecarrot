package com.kh.sharecarrot.product.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.sharecarrot.product.model.vo.Product;
import com.kh.sharecarrot.product.model.vo.ProductImage;

@Repository
public class ProductDaoImpl implements ProductDao {

	@Autowired
	private SqlSessionTemplate session;

	


	@Override
	public List<Product> selectProductList(String shopId) {
		// TODO Auto-generated method stub
		return session.selectList("product.selectProductList", shopId);
	}


//	@Override
//	public List<ProductImage> selectProductImageList(Product productId) {
//		// TODO Auto-generated method stub
//		return session.selectList("product.selectProductImageList", productId);
//	}

	@Override
	public List<ProductImage> selectProductImageList(String productId) {
		// TODO Auto-generated method stub
		return session.selectList("product.selectProductImageList", productId);
	}


	@Override
	public int selectProductListSize(String shopId) {
		return session.selectOne("product.selectProductListSize",shopId);
	}

	
}
