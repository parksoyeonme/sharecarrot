package com.kh.sharecarrot.utils.model.service;

import java.util.List;

import com.kh.sharecarrot.utils.model.vo.Category;
import com.kh.sharecarrot.utils.model.vo.JjimList;
import com.kh.sharecarrot.utils.model.vo.Location;

public interface UtilsService {

	List<Location> selectLocationList();
	
	List<Category> selectCategoryList();

	List<JjimList> selectJjimList(String memberId);

	int selectTotalJjimNo(String memberId);

	String selectLocationCode(String loginId);

}
