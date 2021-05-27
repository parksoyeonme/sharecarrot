package com.kh.sharecarrot.notice.controller;

import java.io.File;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.sharecarrot.common.ShareCarrotUtils;
import com.kh.sharecarrot.member.model.service.MemberService;
import com.kh.sharecarrot.notice.model.service.NoticeService;
import com.kh.sharecarrot.notice.model.vo.Notice;
import com.kh.sharecarrot.notice.model.vo.NoticeImage;





import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/notice")
public class NoticeController {

	@Autowired
	private NoticeService NoticeService;
	
	@GetMapping("/noticeList.do")
	public void NoticeList(Model model, @RequestParam(defaultValue = "1") int cPage, HttpServletRequest request) {
		
		Map<String, Object> param = new HashMap<>();
		int numPerPage = 10;
		
		param.put("numPerPage", numPerPage);
		param.put("cPage", cPage);
		
		List<Notice> NoticetList = null;
		NoticetList = NoticeService.selectNoticeList(param);
		
		int totalContents = NoticeService.getTotalContents();
		String url = request.getRequestURI();
		String pageBar = ShareCarrotUtils.getPageBar(totalContents, cPage, numPerPage, url);

		model.addAttribute("noticeList", NoticetList);
		model.addAttribute("pageBar", pageBar);
	}
	
	@GetMapping("/noticeDetail.do")
	public void noticeDetail(@RequestParam int no, Model model) {
		Notice notice = NoticeService.selectOneNoticeDetail(no);
		
		model.addAttribute("notice", notice);
	}
	
	@GetMapping("/noticeListGo.do")
	public String noticeListGo(@RequestParam int no, Model model) {

		int notice = NoticeService.updatenoticeYn(no);
		
		// model.addAttribute("notice", notice);
		
		return "redirect:/notice/noticeList.do";
	}
	@GetMapping("/noticeForm.do")
	public void noticeForm() {
		
	}
	
	@PostMapping("/noticeEnroll.do")
	public String noticeEnroll(@ModelAttribute Notice notice,
							  HttpServletRequest request,
							  RedirectAttributes redirectAttr) throws IllegalStateException, IOException {

		try {
			
			System.out.println("################################################### notice.getBoardTitle() : " + notice.getBoardDeleteYn());
			
			
			int reuslt = NoticeService.insertNotice(notice);
			redirectAttr.addFlashAttribute("msg", "게시글 등록이 완료되었습니다.");	
		} catch (Exception e) {
			log.error("게시물 등록 오류!", e);
			throw e; // spring container에게 예외 전파
		}
			
		return "redirect:/notice/noticeList.do";
	}
	
}
	
