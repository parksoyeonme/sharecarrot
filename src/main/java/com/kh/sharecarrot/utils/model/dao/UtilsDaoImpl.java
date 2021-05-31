package com.kh.sharecarrot.utils.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.sharecarrot.utils.model.vo.Category;
import com.kh.sharecarrot.utils.model.vo.JjimList;
import com.kh.sharecarrot.utils.model.vo.Location;
import com.kh.sharecarrot.utils.model.vo.jjimListExt;

@Repository
public class UtilsDaoImpl implements UtilsDao {
	@Autowired
	private SqlSessionTemplate session;

	@Override
	public List<Location> selectLocationList() {
		return session.selectList("utils.selectLocationList");
	}

	@Override
	public List<Category> selectCategoryList() {
		return session.selectList("utils.selectCategoryList");
	}

	@Override
	public List<jjimListExt> selectJjimList(String memberId) {
		return session.selectList("utils.selectJjimList", memberId);
	}

	@Override
	public int selectTotalJjimNo(String memberId) {
		return session.selectOne("utils.selectTotalJjimNo", memberId);
	}

	@Override
	public String selectLocationCode(String loginId) {
		
		return session.selectOne("utils.selectLocationCode", loginId);
	}

	@Override
	public int deleteJjim(Map<String, Object> param) {
		return session.delete("utils.deleteJjim", param);
	}
	

}
