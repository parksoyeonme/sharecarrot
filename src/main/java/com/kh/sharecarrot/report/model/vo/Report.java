package com.kh.sharecarrot.report.model.vo;

import java.sql.Date;
import java.util.Set;

import org.springframework.security.core.authority.SimpleGrantedAuthority;

import com.kh.sharecarrot.member.model.vo.Member;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Report {
	
//	   "REPORT_NO"   NUMBER      NOT NULL,
//	   "REPORT_TITLE"   VARCHAR2(100)      NOT NULL,
//	   "REPORT_DATE"   DATE   DEFAULT SYSDATE   NULL,
//	   "REPORT_CONTENT"   VARCHAR2(2000)      NOT NULL,
//	   "REPORT_REPORTED"   VARCHAR2(20)      NOT NULL,
//	   "REPORT_PROCESSING_DATE"   DATE   DEFAULT SYSDATE   NULL,
//	   "REPORT_PROCESS_YN"   CHAR(1)   DEFAULT 'N',
//	   "MEMBER_ID"   VARCHAR2(20)      NOT NULL,
//	   "SHOP_ID"   CHAR(15)      NOT NULL,
		private int reportNo;
		private String reportTitle;
		private Date reportDate;
		private String reportContent;
		private String reportReported;
		private Date reportProcessingDate;
		private boolean reportProcessYn;
		private String memberId;
		private String shopId;
	
}
