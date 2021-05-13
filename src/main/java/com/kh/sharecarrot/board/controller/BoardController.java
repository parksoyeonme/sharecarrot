package com.kh.sharecarrot.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.sharecarrot.board.model.service.BoardService;
import com.kh.sharecarrot.board.model.vo.Board;
import com.kh.sharecarrot.common.ShareCarrotUtils;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	private BoardService boardService;

	@GetMapping("/boardList.do")
	public void boardList(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {
		//사용자 입력값
		int numPerPage = 5;
		Map<String, Object> param = new HashMap<>();
		param.put("numPerPage", numPerPage);
		param.put("cPage", cPage);
		
		//select boardList
		List<Board> boardList = boardService.selectBoardList(param);
		
		//get pageBar
		int totalContents = boardService.getTotalContents();
		log.debug("totalContents = {}", totalContents);
		String url = request.getRequestURI();
		log.debug("url = {}", url);
		String pageBar = ShareCarrotUtils.getPageBar(totalContents, cPage, numPerPage, url);
		
		//jsp
		model.addAttribute("boardList", boardList);
		model.addAttribute("pageBar", pageBar);
	}
	
	@GetMapping("/boardEnroll.do")
	public void boardEnroll() {
	}
}
