package com.kh.sharecarrot.main.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.sharecarrot.main.model.vo.MainProduct;

@Repository
public class MainDaoImpl implements MainDao {

	@Autowired
	SqlSessionTemplate session;

	@Override
	public List<MainProduct> selectProductList(Map<String, Object> param) {
		
		return session.selectList("main.selectProductList", param);
	}
	
	
}
