package com.kh.sharecarrot.product.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
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
	public ProductDetail selectProductDetail(String productId) {
		return session.selectOne("product.selectProductDetail", productId);
	}

	@Override
	public String selectLocCode(String productId) {
		return session.selectOne("product.selectLocCode", productId);
	}

	@Override
	public int insertJjim(Map<String, Object> param) {
		return session.insert("product.insertJjim", param);
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

	@Override
	public List<Product> selectProductList(Map<String, Object> param) {
		int cPage =(int)param.get("cPage");
		
		int limit = (int)param.get("numPerPage");
		int offset = (cPage -1)* limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("product.selectProductList", param, rowBounds);
	}

	@Override
	public int getTotalContents(String shopId) {
		// TODO Auto-generated method stub
		return session.selectOne("product.getTotalContents", shopId);
	}

	@Override
	public Product selectProduct(String productId) {
		return session.selectOne("product.selectProduct", productId);
	}

	
}
