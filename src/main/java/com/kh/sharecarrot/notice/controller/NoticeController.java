package com.kh.sharecarrot.notice.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.sharecarrot.notice.model.service.NoticeService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/notice")
public class NoticeController {
	//notice는 board를 공유
	@Autowired
	private NoticeService noticeService;
	

	@GetMapping("/noticeList.do")
	public void noticeList() {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		UserDetails userDetails = (UserDetails)principal; 
		String username = ((UserDetails) principal).getUsername(); 
		String password = ((UserDetails) principal).getPassword();
		log.info("username = {}", username);
		log.info("password = {}", password);
	}

	
	
}
