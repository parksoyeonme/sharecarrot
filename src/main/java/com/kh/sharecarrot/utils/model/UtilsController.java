package com.kh.sharecarrot.utils.model;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kh.sharecarrot.utils.model.service.UtilsService;
import com.kh.sharecarrot.utils.model.vo.JjimList;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class UtilsController {

	@Autowired
	private UtilsService utilsService;
	
	@GetMapping("/jjim/jjimList.do")
	public void jjimList(Principal principal, Model model) {
		List<JjimList> jjimList = null;
		if(principal != null) {
			String memberId = principal.getName();
			jjimList = utilsService.selectJjimList(memberId);
		}
		
		model.addAttribute("jjimList", jjimList);
	}
}
