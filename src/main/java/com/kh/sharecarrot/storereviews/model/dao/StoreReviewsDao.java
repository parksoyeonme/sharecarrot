package com.kh.sharecarrot.storereviews.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.sharecarrot.storereviews.model.vo.ReviewImage;
import com.kh.sharecarrot.storereviews.model.vo.StoreReviews;

public interface StoreReviewsDao {

	List<StoreReviews> selectStoreReviewsList(String shopId, Map<String, Object> param);

	List<ReviewImage> selectReviewImageList(int reviewNo);

	int getTotalContents(String shopId);

}
