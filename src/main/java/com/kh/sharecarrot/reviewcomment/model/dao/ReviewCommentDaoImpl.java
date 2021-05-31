package com.kh.sharecarrot.reviewcomment.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.sharecarrot.reviewcomment.model.vo.ReviewComment;

@Repository
public class ReviewCommentDaoImpl implements ReviewCommentDao {

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public int insertReviewComment(Map<String, Object> param) {
		return session.insert("reviewComment.insertReviewComment",param);
	}

	@Override
	public int selectTotalCommentsNo() {
		return session.selectOne("reviewComment.selectTotalCommentsNo");
	}




	@Override
	public int deleteReviewComment(ReviewComment reviewComment) {
		return session.update("reviewComment.deleteReviewComment", reviewComment);
	}

	@Override
	public List<ReviewComment> selectReviewCommentOne() {
		// TODO Auto-generated method stub
		return session.selectList("reviewComment.selectReviewCommentOne");
	}


	



}
