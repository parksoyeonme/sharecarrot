package com.kh.sharecarrot.report.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.sharecarrot.report.model.vo.Report;
import com.kh.sharecarrot.report.model.vo.ReportImage;
import com.kh.sharecarrot.shop.model.vo.Shop;

public interface ReportDao {

	List<Report> selectReportList(Map<String, Object> param);
	Report selectOneReprotDetail(int no);
	int updateReportYn(int no);
	int getTotalContents();
	int insertReport(Report report);
	int insertReportImg(ReportImage reportImg);
	List<ReportImage> selectReprotImageDetail(int no);
	ReportImage selectOneReportImage(int no);
	List<Map<String, Object>> selectReportByDate(String searchDate);
	Shop selectOneShop(String shopId);
	

}
