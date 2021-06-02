package com.kh.sharecarrot.report.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.sharecarrot.common.ShareCarrotUtils;
import com.kh.sharecarrot.report.model.exception.ReportException;
import com.kh.sharecarrot.report.model.service.ReportService;
import com.kh.sharecarrot.report.model.vo.Report;
import com.kh.sharecarrot.report.model.vo.ReportImage;
import com.kh.sharecarrot.shop.model.vo.Shop;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/report")
public class ReportController {

	@Autowired
	private ReportService reportService;

	@Autowired
	private ResourceLoader resourceLoader;

	@Autowired
	private ServletContext servletContext; // application객체

	@GetMapping("/reportList.do")
	public void reportList(Model model, @RequestParam(defaultValue = "1") int cPage,
			@RequestParam(defaultValue = "") String searchKeyword,
			HttpServletRequest request) {
		

		Map<String, Object> param = new HashMap<>();
		int numPerPage = 10;
		param.put("searchKeyword", searchKeyword);
		param.put("numPerPage", numPerPage);
		param.put("cPage", cPage);
	
		List<Report> reportList = null;
		reportList = reportService.selectReportList(param);

		int totalContents = reportService.getTotalContents();
		String url = request.getRequestURI();
		String pageBar = ShareCarrotUtils.getPageBar(totalContents, cPage, numPerPage, url);
	
		model.addAttribute("reportList", reportList);
		model.addAttribute("pageBar", pageBar);
	}

	@GetMapping("/reportDetail.do")
	public void reportDetail(@RequestParam int no, Model model) {
		Report report = reportService.selectOneReprotDetail(no);
		List<ReportImage> reportImage = reportService.selectReprotImageDetail(no);

		model.addAttribute("report", report);
		model.addAttribute("reportImage", reportImage);
	}

	@GetMapping("/reportListGo.do")
	public String reportListGo(@RequestParam int no, Model model) {

		int report = reportService.updateReportYn(no);

		// model.addAttribute("report", report);

		return "redirect:/report/reportList.do";
	}

	
	  @GetMapping("/reportForm.do") 
	  public void reportForm(Model model, @RequestParam String shopId) {
	        //String shopId = pri.getName();
	       // model.addAttribute("shopId", shopId);

//	        log.info("@@@@shopId = {}",shopId);
	        
	        Shop shop = reportService.selectOneShop(shopId);
	        model.addAttribute("shop", shop);
	        log.debug("report = {}", shop);

		}
	
	 

	@PostMapping("/reportEnroll.do")
	public String reportEnroll(@ModelAttribute Report report,
			@RequestParam(value = "upfile", required = false) MultipartFile[] upFiles, HttpServletRequest request,
			RedirectAttributes redirectAttr) throws IllegalStateException, IOException {
		try {
			// 파일저장
			// saveDir
			String saveDirectory = request.getServletContext().getRealPath("/resources/upload/report");
			File dir = new File(saveDirectory);
			if (!dir.exists())
				dir.mkdirs(); // 지정경로 존재X 시 폴더 생성

			// ReportImageList
			List<ReportImage> reportImgList = new ArrayList<>();

			for (MultipartFile upFile : upFiles) {
				if (upFile.isEmpty())
					continue;

				// 저장할 파일명
				File renamedFile = ShareCarrotUtils.getRenamedFile(saveDirectory, upFile.getOriginalFilename());

				// 파일저장
				upFile.transferTo(renamedFile);
				ReportImage reportImg = new ReportImage();
				reportImg.setReportImgOrigin(upFile.getOriginalFilename());
				reportImg.setReportImgRenamed(renamedFile.getName());

				reportImgList.add(reportImg);
			}

			report.setReportImageList(reportImgList);
			int reuslt = reportService.insertReport(report);
			redirectAttr.addFlashAttribute("msg", "게시글 등록이 완료되었습니다.");

		} catch (IllegalStateException e) {
			log.error("첨부파일 저장 오류!", e);
			throw new ReportException("첨부파일 저장 오류!");
		} catch (Exception e) {
			log.error("게시물 등록 오류!", e);
			throw e; // spring container에게 예외 전파
		}

		return "redirect:/shop/myshop.do?shopId="+report.getShopId();
	}

	@GetMapping(value = "/fileDownload.do", produces = "application/octet-stream;charset=utf-8")
	@ResponseBody
	public Resource fileDownload(@RequestParam int no, HttpServletResponse response)
			throws UnsupportedEncodingException {

		// 1.업무조회
		ReportImage reportImg = reportService.selectOneReportImage(no);

		String originalFileName = reportImg.getReportImgOrigin();
		String renamedFileName = reportImg.getReportImgRenamed();

		// 2. Resource준비
		String saveDirectory = servletContext.getRealPath("/resources/upload/report");
		File downFile = new File(saveDirectory, renamedFileName);
		String location = "file:" + downFile;
		// log.debug("location = {}", location);
//		Resource resource = resourceLoader.getResource(location);
		Resource resource = new FileSystemResource(downFile);

		// 3. 응답헤더
		// 한글파일 깨짐 방지
		originalFileName = new String(originalFileName.getBytes("utf-8"), "iso-8859-1");
		response.setContentType("application/octet-stream;charset=utf-8");
		response.addHeader("Content-Disposition", "attachment;filename=\"" + originalFileName + "\"");

		return resource;
	}

	@GetMapping("/responseEntity/fileDownload.do")
	public ResponseEntity<Resource> fileDownload(@RequestParam int no) throws UnsupportedEncodingException {
		// 1. 업무로직
		ReportImage reportImg = reportService.selectOneReportImage(no);

		if (reportImg == null)
			return ResponseEntity.notFound().build();

		// 2. Resource객체
		String saveDirectory = servletContext.getRealPath("/resources/upload/report");
		File downFile = new File(saveDirectory, reportImg.getReportImgRenamed());
		Resource resource = resourceLoader.getResource("file:" + downFile);

		// 3. ResponseEntity객체
		// 한글파일 깨짐 방지
		String originalFileName = reportImg.getReportImgOrigin();
		originalFileName = new String(originalFileName.getBytes("utf-8"), "iso-8859-1");

		return ResponseEntity.ok() // statusCode : 200
				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_OCTET_STREAM_VALUE)
				.header(HttpHeaders.CONTENT_DISPOSITION, "attachment;fileName=\"" + originalFileName + "\"")
				.body(resource);
	}


}
