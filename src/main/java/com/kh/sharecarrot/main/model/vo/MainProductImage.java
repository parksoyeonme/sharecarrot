package com.kh.sharecarrot.main.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MainProductImage {
//	   "PRODUCT_IMG_NO"   NUMBER   ,
//	   "PRODUCT_IMG_ORIGIN"   VARCHAR2(200)      NOT NULL,
//	   "PRODUCT_IMG_RENAMED"   VARCHAR2(200)      NOT NULL,
//	   "PRODUCT_ID"   CHAR(15)      NOT NULL,
	
		private int productImgNo;
		private String productImgOrigin;
		private String productImgRenamed;
		private String productId;
	
}
