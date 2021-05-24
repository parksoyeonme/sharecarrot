package com.kh.sharecarrot.product.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
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
import net.sf.json.JSONObject;

@Controller
@Slf4j
@RequestMapping("/product")
public class ProductController {

	@Autowired
	private ProductService productService;
	
	@Autowired
	private UtilsService utilsService;

	@GetMapping("/productDetail.do")
	public void productDetail(@RequestParam String productId, Principal principal,Model model, 
			HttpServletRequest request, HttpServletResponse response) {
		Product product = productService.selectProduct(productId);
		ProductDetail productDetail = productService.selectProductDetail(productId);
		String locCode = productService.selectLocCode(productId);
		productDetail.setLocName(locCode);
		
		List<Category> categoryList = utilsService.selectCategoryList();
		
		String category = "";
		for(Category c : categoryList) {
			if(c.getCategoryCode().equals(productDetail.getCategoryCode())) {
				category = c.getCategoryName();
			}
		}
		
		//로그인 회원에 한해서 찜목록 불러오기
		List<JjimList> jjimList = null;
		if(principal != null) {
			String memberId = principal.getName();
			jjimList = utilsService.selectJjimList(memberId);
		}
		
		Cookie[] cookies = request.getCookies();
		log.info("cookie length : {}", cookies.length);
        if(cookies.length == 3) {
        	cookies[0] = new Cookie("latest0",
                    cookies[1].toString());
        	cookies[1] = new Cookie("latest1",
        			cookies[2].toString());
        	cookies[2] = new Cookie("latest2",
        			product.toString());
        }else if(cookies.length == 2) {
        	cookies[2] = new Cookie("latest2",
        			product.toString());
        }else if(cookies.length == 1) {
        	cookies[1] = new Cookie("latest1",
        			product.toString());
        }else if(cookies.length == 0) {
        	cookies[0] = new Cookie("latest0",
        			product.toString());
        }
		
//		Cookie latestProductCookie = new Cookie("latest2", mall.getGender());

//        if(mall.isCookieDel()) {
//        genderCookie.setMaxAge(0);
//        mall.setGender(null);
//        } else {
//        genderCookie.setMaxAge(60*60*24*30);
//        }
//        response.addCookie(genderCookie);
		
		model.addAttribute("product", productDetail);
		model.addAttribute("category", category);
		model.addAttribute("jjimList", jjimList);
	}
	
	@GetMapping("/getTotalJjimNo.do")
	public String getTotalJjimNo(Model model,
			HttpServletResponse response) {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		log.info("@@principal : {}",principal);
		//로그인 회원에 한해서 찜목록 불러오기
		int totalJjim = 0;
		if(principal != null) {
			String memberId = ((UserDetails) principal).getUsername(); 			
			totalJjim = utilsService.selectTotalJjimNo(memberId);
			log.info("totalJjim = {}", totalJjim);
		}
		
		JSONObject obj = new JSONObject();
		
		//	model.addAttribute("productListSize", productListSize);
			//data: 뒤에 들어갈 값인 jArray 생성
		obj.put("totalJjim", totalJjim);
//		obj.put("pageBar", pageBar);
		String str = obj.toString();
		log.info("@@test = {}",str);	
		return str;
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