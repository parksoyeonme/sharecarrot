package com.kh.sharecarrot.storereviews.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
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
	public List<ReviewImage> selectReviewImageList(int reviewNo) {
		return session.selectList("storereviews.selectReviewImageList", reviewNo);
	}

	@Override
	public List<StoreReviews> selectStoreReviewsList(String shopId) {
		
		return session.selectList("storereviews.selectStoreReviewsList",shopId);
	}

	@Override
	public int getTotalContents(String shopId) {
		return session.selectOne("storereviews.getTotalContents",shopId);
	}

	@Override
	public int selectStoreReviewListSize(String shopId) {
		// TODO Auto-generated method stub
		return session.selectOne("storereviews.selectStoreReviewListSize",shopId);
	}

	
}
