package com.kh.sharecarrot.utils.model;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.sharecarrot.utils.model.service.UtilsService;
import com.kh.sharecarrot.utils.model.vo.jjimListExt;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class UtilsController {

	@Autowired
	private UtilsService utilsService;
	
	@GetMapping("/jjim/jjimList.do")
	public void jjimList(Principal principal, Model model) {
		List<jjimListExt> jjimList = null;
		if(principal != null) {
			String memberId = principal.getName();
			jjimList = utilsService.selectJjimList(memberId);
		}
		
		model.addAttribute("jjimList", jjimList);
		
		
	}
	
	@PostMapping("/jjim/deleteJjim.do")
	public String deleteJjim(String memberId, String productId, RedirectAttributes redirectAttr) {
		log.info("productId = {}, memberId = {}", productId, memberId);
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("productId", productId);
		param.put("memberId", memberId);
		int result = utilsService.deleteJjim(param);
		
		return "redirect:jjimList.do";
	}
}
