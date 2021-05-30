package com.kh.sharecarrot.reviewcomment.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.sharecarrot.reviewcomment.model.service.ReviewCommentService;
import com.kh.sharecarrot.reviewcomment.model.vo.ReviewComment;


import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/reviewCommnet")
public class ReviewCommentController {

	@Autowired
	private ReviewCommentService reviewCommentService;
	
	
	
}
