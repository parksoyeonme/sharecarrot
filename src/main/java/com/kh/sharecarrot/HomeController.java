package com.kh.sharecarrot;


import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	
	Map<String, Object> param = new HashMap<>();
	int limit = 10;	// 한 번에 열 개 출력
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, 
			@RequestParam(defaultValue = "1") int cPage,
			HttpServletRequest request) { 
			
		/* 더 보기 페이징*/
		param.put("limit", limit);
		param.put("cPage", cPage);
		if(request.getSession().getAttribute("loginMember") != null) {
			logger.info("session ={}", request.getSession().getAttribute("loginMember"));
			Member loginMember = (Member)request.getSession().getAttribute("loginMember");
			String locCode = loginMember.getLocCode();
			logger.info("locCode={}", locCode);
			//locCode 공백제거
			locCode = locCode.trim();
			param.put("locCode", locCode);
//			param.put("category", Category);			
		}
		
		List<MainProduct> productList = mainService.selectProductList(param);
		logger.info("productList = {}", productList);
		
		List<Location> locationList = utilsService.selectLocationList();
		List<Category> categoryList = utilsService.selectCategoryList();
		logger.info("locList={}, cateList={}", locationList, categoryList);

		
		model.addAttribute("productList", productList);
		model.addAttribute("locationList", locationList);
		model.addAttribute("categoryList", categoryList);
		
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
	

}
