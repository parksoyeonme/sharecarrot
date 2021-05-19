package com.kh.sharecarrot.report.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.sharecarrot.report.model.dao.ReportDao;

@Service
public class ReportServiceImpl implements ReportService {

	@Autowired
	private ReportDao reportDao;
}
