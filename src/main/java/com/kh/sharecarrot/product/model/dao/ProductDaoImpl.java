package com.kh.sharecarrot.product.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.sharecarrot.product.model.vo.Product;
import com.kh.sharecarrot.product.model.vo.ProductDetail;
import com.kh.sharecarrot.product.model.vo.ProductImage;

@Repository
public class ProductDaoImpl implements ProductDao {

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public List<Product> searchLocation(String locName) {
		return session.selectList("product.searchLocation", locName);
	}

	@Override
	public List<Product> searchTitle(String productName) {
		return session.selectList("product.searchTitle", productName);
	}

	@Override
	public ProductDetail selectProduct(String productId) {
		return session.selectOne("product.selectProduct", productId);
	}

	@Override
	public String selectLocCode(String productId) {
		return session.selectOne("product.selectLocCode", productId);
	}

	@Override
	public int insertJjim(Map<String, Object> param) {
		return session.insert("product.insertJjim", param);
	}

	
}
