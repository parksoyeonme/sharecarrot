package com.kh.sharecarrot.report.model.dao;

import java.util.List;

import com.kh.sharecarrot.report.model.vo.Report;

public interface ReportDao {

	List<Report> selectReportList();
	Report selectOneReprotDetail(int no);
	int updateReportYn(int no);

}
