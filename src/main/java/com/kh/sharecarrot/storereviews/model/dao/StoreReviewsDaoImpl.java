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
	public List<StoreReviews> selectStoreReviewsList(String shopId, Map<String, Object> param) {
		int cPage =(int)param.get("cPage");
		
		int limit = (int)param.get("numPerPage");
		int offset = (cPage -1)* limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return session.selectList("storereviews.selectStoreReviewsList",shopId,rowBounds);
	}

	@Override
	public int getTotalContents(String shopId) {
		// TODO Auto-generated method stub
		return session.selectOne("storereviews.getTotalContents",shopId);
	}

	
	
}
