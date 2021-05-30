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
	public ReviewComment selectReviewCommentOne(int reviewNo) {
		return reviewCommentDao.selectReviewCommentOne(reviewNo);
	}


}
