package com.kh.sharecarrot.utils.model.dao;

import java.util.List;

import com.kh.sharecarrot.utils.model.vo.Category;
import com.kh.sharecarrot.utils.model.vo.Location;

public interface UtilsDao {

	List<Location> selectLocationList();

	List<Category> selectCategoryList();

}
