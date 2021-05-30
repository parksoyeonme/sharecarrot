package com.kh.sharecarrot.storereviews.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReviewImage {
//	REVIEW_IMG_NO      NOT NULL NUMBER        
//	REIVEW_IMG_ORIGIN  NOT NULL VARCHAR2(200) 
//	REIVEW_IMG_RENAMED NOT NULL VARCHAR2(200) 
//	REVIEW_NO          NOT NULL NUMBER  
	private int reviewImgNo;
	private String reviewImgOrigin;
	private String reviewImgRenamed;
	private int reviewNo;
	
}
