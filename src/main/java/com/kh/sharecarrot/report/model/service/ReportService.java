package com.kh.sharecarrot.report.model.service;

import java.util.List;

import com.kh.sharecarrot.report.model.vo.Report;

public interface ReportService {
	List<Report> selectReportList();

	Report selectOneReprotDetail(int no);

	int updateReportYn(int no);
}
