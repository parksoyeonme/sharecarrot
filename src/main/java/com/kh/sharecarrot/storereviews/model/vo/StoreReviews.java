package com.kh.sharecarrot.storereviews.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class StoreReviews {

	
//	REVIEW_NO       NOT NULL NUMBER         
//	REVIEW_TITLE    NOT NULL VARCHAR2(200)  
//	REVIEW_CONTENT  NOT NULL VARCHAR2(1000) 
//	REVIEW_SCORE    NOT NULL NUMBER         
//	REVIEW_DEL_FLAG          CHAR(1)        
//	PRODUCT_ID               VARCHAR2(15)   
	private int reviewNo;
	private String reviewTitle;
	private String reviewContent;
	private int reviewScore;
	private boolean reviewDelFlag;
	private String productId;
	
	
	private String reviewCommentText;
	private String reviewCommentNo;
	
}
