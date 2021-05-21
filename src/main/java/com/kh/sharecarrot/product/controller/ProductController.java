package com.kh.sharecarrot.product.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.sharecarrot.product.model.service.ProductService;
import com.kh.sharecarrot.product.model.vo.Product;
import com.kh.sharecarrot.product.model.vo.ProductDetail;
import com.kh.sharecarrot.utils.model.service.UtilsService;
import com.kh.sharecarrot.utils.model.vo.Category;
import com.kh.sharecarrot.utils.model.vo.JjimList;
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
	public void productDetail(@RequestParam String productId, Principal principal,Model model) {
		
		ProductDetail product = productService.selectProduct(productId);
		String locCode = productService.selectLocCode(productId);
		product.setLocName(locCode);
		
		List<Category> categoryList = utilsService.selectCategoryList();
		
		String category = "";
		for(Category c : categoryList) {
			if(c.getCategoryCode().equals(product.getCategoryCode())) {
				category = c.getCategoryName();
			}
		}
		
		//로그인 회원에 한해서 찜목록 불러오기
		List<JjimList> jjimList = null;
		if(principal != null) {
			String memberId = principal.getName();
			
			jjimList = utilsService.selectJjimList(memberId);
			log.info("jjimList = {}", jjimList);
		}
		
		model.addAttribute("product", product);
		model.addAttribute("category", category);
		model.addAttribute("jjimList", jjimList);
	}
	
	@PostMapping("/insertJjim.do")
	public String insertJjim(@RequestParam String memberId, @RequestParam String productId
							, RedirectAttributes redirectAttr) {
		try {
			Map<String, Object> param = new HashMap<>();
			param.put("memberId", memberId);
			param.put("productId", productId);
			
			int result = productService.insertJjim(param);
			redirectAttr.addFlashAttribute("msg", "찜등록이 완료되었습니다.");
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return "redirect:/product/productDetail.do?productId="+productId;
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
		
		//페이징 처리
	}
}