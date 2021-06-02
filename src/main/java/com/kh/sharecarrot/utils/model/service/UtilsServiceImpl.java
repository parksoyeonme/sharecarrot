package com.kh.sharecarrot.utils.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.sharecarrot.chatting.model.vo.ChattingRoom;
import com.kh.sharecarrot.utils.model.dao.UtilsDao;
import com.kh.sharecarrot.utils.model.vo.Category;
import com.kh.sharecarrot.utils.model.vo.JjimList;
import com.kh.sharecarrot.utils.model.vo.Location;
import com.kh.sharecarrot.utils.model.vo.jjimListExt;

@Service
public class UtilsServiceImpl implements UtilsService {
	@Autowired
	private UtilsDao utilsDao;

	@Override
	public List<Location> selectLocationList() {
		return utilsDao.selectLocationList();
	}

	@Override
	public List<Category> selectCategoryList() {
		return utilsDao.selectCategoryList();
	}

	@Override
	public List<jjimListExt> selectJjimList(String memberId) {
		return utilsDao.selectJjimList(memberId);
	}

	@Override
	public int selectTotalJjimNo(String memberId) {
		return utilsDao.selectTotalJjimNo(memberId);
	}

	@Override
	public String selectLocationCode(String loginId) {
		return utilsDao.selectLocationCode(loginId);
	}

	@Override
	public int deleteJjim(Map<String, Object> param) {
		return utilsDao.deleteJjim(param);
	}

	@Override
	public List<Integer> selectChattingRoomList(String loginMemberId) {
		return utilsDao.selectChattingRoomList(loginMemberId);
	}

}
