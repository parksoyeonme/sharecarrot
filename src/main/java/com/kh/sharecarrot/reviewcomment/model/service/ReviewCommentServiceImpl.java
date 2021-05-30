package com.kh.sharecarrot.reviewcomment.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.sharecarrot.reviewcomment.model.dao.ReviewCommentDao;
import com.kh.sharecarrot.reviewcomment.model.vo.ReviewComment;



@Service
public class ReviewCommentServiceImpl implements ReviewCommentService {

	@Autowired
	private ReviewCommentDao reviewCommentDao;

	@Override
	public int insertReviewComment(Map<String, Object> param) {
		return reviewCommentDao.insertReviewComment(param);
	}

	@Override
	public int selectTotalCommentsNo() {
		return reviewCommentDao.selectTotalCommentsNo();
	}

	


	@Override
	public int deleteReviewComment(ReviewComment reviewComment) {
		// TODO Auto-generated method stub
		return reviewCommentDao.deleteReviewComment(reviewComment);
	}

	@Override
	public List<ReviewComment> selectReviewCommentOne() {
		// TODO Auto-generated method stub
		return reviewCommentDao.selectReviewCommentOne();
	}



}
