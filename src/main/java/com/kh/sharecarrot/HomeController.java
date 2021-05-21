package com.kh.sharecarrot;


import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kh.sharecarrot.main.model.service.MainService;
import com.kh.sharecarrot.main.model.vo.MainProduct;
import com.kh.sharecarrot.member.model.vo.Member;
import com.kh.sharecarrot.product.model.vo.Product;
import com.kh.sharecarrot.utils.model.service.UtilsService;
import com.kh.sharecarrot.utils.model.vo.Category;
import com.kh.sharecarrot.utils.model.vo.Location;


/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	@Autowired
	private UtilsService utilsService;

	@Autowired
	private MainService mainService;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) { 
//			@RequestParam(defaultValue = "1") int cPage,
//			int numPerPage, 
//			@RequestParam(defaultValue = "") `String locCode,
//			@RequestParam(defaultValue = "") String Category,
//			@RequestParam(defaultValue = "") String option) {

//		//locCode 공백제거
//		locCode = locCode.trim();
//		
		Map<String, Object> param = new HashMap<>();
//		param.put("cPage", cPage);
//		param.put("numPerPage", numPerPage);
//		param.put("locCode", locCode);
//		param.put("category", Category);
//		param.put("option", option);
//		
		List<Location> locationList = utilsService.selectLocationList();
		List<Category> categoryList = utilsService.selectCategoryList();
		logger.info("locList={}, cateList={}", locationList, categoryList);

		List<MainProduct> productList = mainService.selectProductList(param);
		
		model.addAttribute("productList", productList);
//		
		
		model.addAttribute("locationList", locationList);
		model.addAttribute("categoryList", categoryList);
		return "forward:/index.jsp";
	}
	
	@GetMapping("/error/accessDenied.do")
	public void accessDenied() {
		
	}
	

}
