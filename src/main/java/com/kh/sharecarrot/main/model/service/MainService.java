package com.kh.sharecarrot.main.model.service;

import java.util.List;
import java.util.Map;

import com.kh.sharecarrot.main.model.vo.MainProduct;


public interface MainService {

	List<MainProduct> selectProductList(Map<String, Object> param);
	
}
