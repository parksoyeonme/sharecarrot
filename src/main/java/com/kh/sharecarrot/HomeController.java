package com.kh.sharecarrot;


import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.sharecarrot.main.model.service.MainService;
import com.kh.sharecarrot.main.model.vo.MainProduct;
import com.kh.sharecarrot.utils.model.service.UtilsService;
import com.kh.sharecarrot.utils.model.vo.Category;
import com.kh.sharecarrot.utils.model.vo.Location;
import com.kh.sharecarrot.utils.model.vo.jjimListExt;

import lombok.extern.slf4j.Slf4j;


/**
 * Handles requests for the application home page.
 */
@Controller
@Slf4j
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	@Autowired
	private UtilsService utilsService;

	@Autowired
	private MainService mainService;
	
	Map<String, Object> param = new HashMap<>();
	int limit = 10;	// 한 번에 열 개 출력
	
	@Autowired
	SessionLocaleResolver localeResolver;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, 
			@RequestParam(defaultValue = "1") int cPage,
			@RequestParam(defaultValue = "") String locCode,
			@RequestParam(defaultValue = "") String category,
			HttpServletRequest request,
			Principal principal) { 
		//log.debug("locale from localeResolver = {}", localeResolver.resolveLocale(request));
		//log.debug("locale = {}", locale);
		
		List<jjimListExt> jjimList = null;
		if(principal != null) {
			//로그인을 한 경우에만 찜 목록 불러오는 코드
			String loginMemberId = principal.getName();
			jjimList = utilsService.selectJjimList(loginMemberId);
			log.info("jjim = {}" ,jjimList);
			
			//로그인을 한 경우에만 채팅방 목록을 불러오는 코드		
		}
		
		
		/* 더 보기 페이징*/
		param.put("limit", limit);
		param.put("cPage", cPage);
		param.put("categoryCode", category);
		param.put("locCode", locCode);
		if(principal != null) {
			
			logger.info("Member ={}", principal);
//			Member loginMember = (Member)principal;
			String loginId = principal.getName();
			logger.info("id={}", principal.getName());
			locCode = utilsService.selectLocationCode(loginId);
			logger.info("locCode={}", locCode);
			//locCode 공백제거
			locCode = locCode.trim();
			param.put("locCode", locCode);
//			param.put("category", Category);			
		}
		
		List<MainProduct> productList = mainService.selectProductList(param);
		int listLength = productList.size();
		logger.info("productList = {}", productList);
		logger.info("listLength ={}", listLength);
		
		List<Location> locationList = utilsService.selectLocationList();
		List<Category> categoryList = utilsService.selectCategoryList();
		logger.info("locList={}, cateList={}", locationList, categoryList);

		
		model.addAttribute("productList", productList);
		model.addAttribute("locationList", locationList);
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("jjimList", jjimList);
		model.addAttribute("locCode", locCode);
		model.addAttribute("listLength", listLength);
		return "forward:/index.jsp";
	}
	
	@ResponseBody
	@RequestMapping(value="/search/mainProductList.do", method = RequestMethod.POST)
	public List<MainProduct> mainProductList(
					@RequestParam(defaultValue = "1") int cPage,
					@RequestParam(defaultValue = "") String locCode,
					@RequestParam(defaultValue = "") String category, 
					Model model, 
					RedirectAttributes redirectAttributes) {
		param.put("cPage", cPage);
		param.put("limit", limit);
		param.put("locCode", locCode);
		param.put("categoryCode", category);
		
		List<MainProduct> productList = mainService.selectProductList(param);
		logger.info("List = {}", productList);
		
		return productList;
	}
	
	@GetMapping("/error/accessDenied.do")
	public void accessDenied() {
		
	}
	
	@GetMapping("/chat/selectRoomNo.do")
	@ResponseBody
	public List<Integer> selectRoomNo(String loginMemberId, Model model) {
		List<Integer> chattingRoomList = null;
		if(loginMemberId != null)
			chattingRoomList = utilsService.selectChattingRoomList(loginMemberId);
//		model.addAttribute("chattingRoomList", chattingRoomList);
		return chattingRoomList;
	}
	

}
