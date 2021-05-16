package com.kh.sharecarrot;


import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		List<Location> locationList = utilsService.selectLocationList();
		List<Category> categoryList = utilsService.selectCategoryList();
		logger.info("찍혀라");
		logger.info("locList={}, cateList={}", locationList, categoryList);
		model.addAttribute("locationList", locationList);
		model.addAttribute("categoryList", categoryList);
		
		return "forward:/index.jsp";
	}
	
	
}
