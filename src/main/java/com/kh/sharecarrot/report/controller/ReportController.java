package com.kh.sharecarrot.report.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.sharecarrot.report.model.service.ReportService;
import com.kh.sharecarrot.report.model.vo.Report;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/report")
public class ReportController {

	@Autowired
	private ReportService reportService;
	
	@GetMapping("/reportList.do")
	public void reportList(Model model, @RequestParam(defaultValue="") String memberId) {
		List<Report> reportList = null;
		reportList = reportService.selectReportList();
		model.addAttribute("reportList", reportList);
	}
	
	@GetMapping("/reportDetail.do")
	public void reportDetail(@RequestParam int no, Model model) {
		Report report = reportService.selectOneReprotDetail(no);
		
		model.addAttribute("report", report);
	}
	
	@GetMapping("/reportListGo.do")
	public String reportListGo(@RequestParam int no, Model model) {

		int report = reportService.updateReportYn(no);
		
		// model.addAttribute("report", report);
		
		return "redirect:/report/reportList.do";
	}
		
}
