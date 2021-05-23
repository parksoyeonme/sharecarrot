package com.kh.sharecarrot.storereviews.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.sharecarrot.storereviews.model.dao.StoreReviewsDao;
import com.kh.sharecarrot.storereviews.model.vo.ReviewImage;
import com.kh.sharecarrot.storereviews.model.vo.StoreReviews;

@Service
public class StoreReviewsServiceImpl implements StoreReviewsService {

	@Autowired
	private StoreReviewsDao storeReviewsDao;

	
	@Override
	public List<ReviewImage> selectReviewImageList(int reviewNo) {
		return storeReviewsDao.selectReviewImageList(reviewNo);
	}

	@Override
	public List<StoreReviews> selectStoreReviewsList(String shopId, Map<String, Object> param) {
		// TODO Auto-generated method stub
		return storeReviewsDao.selectStoreReviewsList(shopId,param);
	}

	@Override
	public int getTotalContents(String shopId) {
		// TODO Auto-generated method stub
		return storeReviewsDao.getTotalContents(shopId);
	}
}
