package com.kh.sharecarrot.reviewcomment.model.vo;

import java.sql.Date;

import com.kh.sharecarrot.report.model.vo.Report;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReviewComment {

//	
//	REVIEW_COMMENT_NO          NOT NULL NUMBER        
//	REVIEW_CONTENT                      VARCHAR2(500) 
//	REVIEW_COMMENT_ENROLL_DATE          DATE          
//	REVIEW_COMMENT_DEL_FLAG             CHAR(1)       
//	MEMBER_ID                  NOT NULL VARCHAR2(20)  
//	REVIEW_NO                  NOT NULL NUMBER     
	
	private int reviewCommentNo;
	private String reviewContent;
	private Date reviewCommentEnrollDate;
	private boolean reviewCommentDelFlag;
	private String memeberId;
	private int reviewNo;
	
	
}
