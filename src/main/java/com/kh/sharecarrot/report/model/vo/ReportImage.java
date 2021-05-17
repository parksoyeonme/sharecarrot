package com.kh.sharecarrot.report.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReportImage {
//	   "REPORT_IMG_ID"   NUMBER   ,
//	   "REPORT_IMG_ORIGIN"   VARCHAR2(200)      NOT NULL,
//	   "REPORT_IMG_REAMED"   VARCHAR2(200)      NOT NULL,
//	   "REPORT_NO"   NUMBER      NOT NULL,	
		private int reportImgId;
		private String reportImgOrigin;
		private String reportImgRenamed;
		private int reportNo;
	
}
