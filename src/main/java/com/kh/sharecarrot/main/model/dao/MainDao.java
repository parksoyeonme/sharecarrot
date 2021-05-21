package com.kh.sharecarrot.main.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.sharecarrot.main.model.vo.MainProduct;

public interface MainDao {

	List<MainProduct> selectProductList(Map<String, Object> param);

}
