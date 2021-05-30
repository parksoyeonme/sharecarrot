package com.kh.sharecarrot.reviewcomment.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.sharecarrot.reviewcomment.model.vo.ReviewComment;

public interface ReviewCommentDao {

	int insertReviewComment(Map<String, Object> param);

	int selectTotalCommentsNo();

	ReviewComment selectReviewCommentOne(int reviewNo);



}
