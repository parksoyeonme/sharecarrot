package com.kh.sharecarrot.report.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.sharecarrot.report.model.dao.ReportDao;
import com.kh.sharecarrot.report.model.vo.Report;

@Service
public class ReportServiceImpl implements ReportService {

	@Autowired
	private ReportDao reportDao;
	
	@Override
	public List<Report> selectReportList() {
		return reportDao.selectReportList();
	}

	@Override
	public Report selectOneReprotDetail(int no) {
		return reportDao.selectOneReprotDetail(no);
	}

	@Override
	public int updateReportYn(int no) {
		return reportDao.updateReportYn(no);
	}

}
