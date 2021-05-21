package com.kh.sharecarrot.product.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import java.util.Iterator;
import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.sharecarrot.product.model.service.ProductService;
import com.kh.sharecarrot.product.model.vo.Product;

import com.kh.sharecarrot.utils.model.service.UtilsService;
import com.kh.sharecarrot.utils.model.vo.Location;


import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/product")
public class ProductController {

	@Autowired
	private ProductService productService;
	
	@Autowired
	private UtilsService utilsService;

	@GetMapping("/productDetail.do")
	public void product() {
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	@GetMapping("/headerSearch.do")
	public void headerSearch(
			@RequestParam(value = "searchkeyword") String searchKeyword
			) {
		List<Location> locationList = utilsService.selectLocationList();
//		log.info("list = {}", locationList);
//		log.info("searchkeyword = {}", searchkeyword);
		boolean locFlag = false;
		List<Product> productList = null;
		
		Iterator<Location> iter = locationList.iterator();
		while(iter.hasNext()) {
			Location loc = (Location)iter.next();
			if(loc.getLocName().contains(searchKeyword)) {
				locFlag = true;
				break;
			}
		}

		if(locFlag) {
			String locName = searchKeyword;
			productList = productService.searchLocation(locName);
			log.debug("locSearch : {}", productList);
		}else {
			String productName = searchKeyword;
			productList = productService.searchTitle(productName);
			log.debug("titleSearch : {}", productList);
		}
	}
		//페이징 처리

















































































































































/* 이원빈 작업 영역 */
@GetMapping("/productList.do")
public List<Product> productList(
		@RequestParam(defaultValue = "1") int cPage,
		int numPerPage, 
		@RequestParam(defaultValue = "") String locCode,
		@RequestParam(defaultValue = "") String Category,
		@RequestParam(defaultValue = "") String option) {
	
	//locCode 공백제거
	locCode = locCode.trim();
	
	Map<String, Object> param = new HashMap<>();
	param.put("cPage", cPage);
	param.put("numPerPage", numPerPage);
	param.put("locCode", locCode);
	param.put("category", Category);
	param.put("option", option);
	
	List<Product> productList = productService.selectProductList(param);
	
	return productList;
}
}