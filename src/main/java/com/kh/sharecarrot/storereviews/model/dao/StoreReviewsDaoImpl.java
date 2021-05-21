package com.kh.sharecarrot.storereviews.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.sharecarrot.storereviews.model.vo.ReviewImage;
import com.kh.sharecarrot.storereviews.model.vo.StoreReviews;

@Repository
public class StoreReviewsDaoImpl implements StoreReviewsDao {

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public List<StoreReviews> selectStoreReviewsList(String shopId) {
		return session.selectList("storereviews.selectStoreReviewsList",shopId);
	}

	@Override
	public List<ReviewImage> selectReviewImageList(int reviewNo) {
		return session.selectList("storereviews.selectReviewImageList", reviewNo);
	}
	
	
}
