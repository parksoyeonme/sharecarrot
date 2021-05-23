package com.kh.sharecarrot.reviewcomment.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.sharecarrot.reviewcomment.model.dao.ReviewCommentDao;
import com.kh.sharecarrot.reviewcomment.model.vo.ReviewComment;



@Service
public class ReviewCommentServiceImpl implements ReviewCommentService {

	@Autowired
	private ReviewCommentDao reviewCommentDao;

	@Override
	public int insertReviewComment(ReviewComment reviewComment) {
		return reviewCommentDao.insertReviewComment(reviewComment);
	}
}
