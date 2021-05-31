package com.kh.sharecarrot.utils.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.sharecarrot.utils.model.vo.Category;
import com.kh.sharecarrot.utils.model.vo.JjimList;
import com.kh.sharecarrot.utils.model.vo.Location;
import com.kh.sharecarrot.utils.model.vo.jjimListExt;

public interface UtilsDao {

	List<Location> selectLocationList();

	List<Category> selectCategoryList();

	List<jjimListExt> selectJjimList(String memberId);

	int selectTotalJjimNo(String memberId);

	String selectLocationCode(String loginId);

	int deleteJjim(Map<String, Object> param);

}
