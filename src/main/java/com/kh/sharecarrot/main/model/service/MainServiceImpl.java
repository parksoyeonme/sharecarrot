package com.kh.sharecarrot.main.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.sharecarrot.main.model.dao.MainDao;
import com.kh.sharecarrot.main.model.vo.MainProduct;

@Service
public class MainServiceImpl implements MainService {

	@Autowired
	private MainDao maindao;
	
	@Override
	public List<MainProduct> selectProductList(Map<String, Object> param) {
	
		return maindao.selectProductList(param);
	}

}
