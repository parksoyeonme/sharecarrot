package com.kh.sharecarrot.report.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.sharecarrot.report.model.dao.ReportDao;
import com.kh.sharecarrot.report.model.vo.Report;
import com.kh.sharecarrot.report.model.vo.ReportImage;

@Service
public class ReportServiceImpl implements ReportService {

	@Autowired
	private ReportDao reportDao;


	@Override
	public Report selectOneReprotDetail(int no) {
		return reportDao.selectOneReprotDetail(no);
	}

	@Override
	public int updateReportYn(int no) {
		return reportDao.updateReportYn(no);
	}

	@Override
	public int getTotalContents() {
		return reportDao.getTotalContents();
	}

	@Override
	public List<Report> selectReportList(Map<String, Object> param) {
		return reportDao.selectReportList(param);
	}

	@Override
	public int insertReport(Report report) {
		int result = 0;
		//1. board객체 등록
		result = reportDao.insertReport(report);
		//2. attachment객체 등록
		if(!report.getReportImageList().isEmpty()) {
			for(ReportImage reportImg : report.getReportImageList()) {
				reportImg.setReportNo(report.getReportNo());
				result = reportDao.insertReportImg(reportImg);
			}
		}
		return result;
	}

	@Override
	public List<ReportImage> selectReprotImageDetail(int no) {
		return reportDao.selectReprotImageDetail(no);
	}

	@Override
	public ReportImage selectOneReportImage(int no) {
		return reportDao.selectOneReportImage(no);
	}

}
