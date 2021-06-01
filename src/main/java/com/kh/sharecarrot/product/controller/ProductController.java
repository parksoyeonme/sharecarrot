package com.kh.sharecarrot.product.controller;

import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.sharecarrot.common.ShareCarrotUtils;
import com.kh.sharecarrot.product.model.service.ProductService;
import com.kh.sharecarrot.product.model.vo.Product;
import com.kh.sharecarrot.product.model.vo.ProductDetail;
import com.kh.sharecarrot.product.model.vo.ProductImage;
import com.kh.sharecarrot.utils.model.service.UtilsService;
import com.kh.sharecarrot.utils.model.vo.Category;
import com.kh.sharecarrot.utils.model.vo.JjimList;
import com.kh.sharecarrot.utils.model.vo.Location;
import com.kh.sharecarrot.utils.model.vo.jjimListExt;

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
	public String productDetail(@RequestParam String productId, Principal principal,Model model, 
			HttpServletRequest request, HttpServletResponse response) {

		Product pd = productService.selectProduct(productId);
		ProductDetail product = productService.selectProductDetail(productId);

		//ProductDetail 세팅
		ProductDetail productDetail = productService.selectProductDetail(productId);
		String locCode = productService.selectLocCode(productId);
		product.setLocName(locCode);
		
		//Shop_Product_Count 세팅
		int shopProductCount = productService.getTotalContents(productDetail.getShopId());
		productDetail.setShopProductCount(shopProductCount);
		
		//Category 셋팅
		List<Category> categoryList = utilsService.selectCategoryList();
		
		String category = "";
		for(Category c : categoryList) {
			if(c.getCategoryCode().equals(product.getCategoryCode())) {
				category = c.getCategoryName();
			}
		}
				
		//연관상품 불러오기
		List<Product> productList = productService.selectProductList(productDetail.getCategoryCode());
		
		
		//로그인 회원에 한해서 찜목록 불러오기
		List<jjimListExt> jjimList = null;
		if(principal != null) {
			String memberId = principal.getName();
			jjimList = utilsService.selectJjimList(memberId);
		}
		
		Cookie[] cookies = request.getCookies();
		log.info("cookie length : {}", cookies.length);
		log.info("cookie length : {}", cookies[0]);
//		Cookie[] cookies = request.getCookies();
//		log.info("cookie length : {}", cookies.length);
//        if(cookies.length == 3) {
//        	cookies[0] = new Cookie("latest0",
//                    cookies[1].toString());
//        	cookies[1] = new Cookie("latest1",
//        			cookies[2].toString());
//        	cookies[2] = new Cookie("latest2",
//        			product.toString());
//        }else if(cookies.length == 2) {
//        	cookies[2] = new Cookie("latest2",
//        			product.toString());
//        }else if(cookies.length == 1) {
//        	cookies[1] = new Cookie("latest1",
//        			product.toString());
//        }else if(cookies.length == 0) {
//        	cookies[0] = new Cookie("latest0",
//        			product.toString());
//        }
		
//		if(cookies.length == 4) {
//        	response.addCookie(new Cookie("latest0",
//                    cookies[2].toString()));
//        	response.addCookie(new Cookie("latest1",
//        			cookies[3].toString()));
//        	response.addCookie(new Cookie("latest2",
//        			product.toString()));
//        }else if(cookies.length == 3) {
//        	response.addCookie(new Cookie("latest2",
//        			product.toString()));
//        }else if(cookies.length == 2) {
//        	response.addCookie(new Cookie("latest1",
//        			product.toString()));
//        }else if(cookies.length == 1) {
//        	response.addCookie(new Cookie("latest0",
//        			product.toString()));
//        }
        
		model.addAttribute("product", product);
		model.addAttribute("category", category);
		model.addAttribute("jjimList", jjimList);
		model.addAttribute("productList", productList);
		
		return "/product/productDetail";
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
			@RequestParam(value = "searchkeyword") String searchKeyword, @RequestParam(defaultValue ="1" ) int cPage
			, @RequestParam Map<String,Object> param, Model model, HttpServletRequest request) {
		
		//페이징 처리
		int numPerPage = 20;
		log.debug("cPage = {}", cPage);
		param.put("numPerPage", numPerPage);
		param.put("cPage", cPage);
				
		List<Location> locationList = utilsService.selectLocationList();
//		log.info("list = {}", locationList);
//		log.info("searchkeyword = {}", searchkeyword);
		boolean locFlag = false;
		List<Product> productList = null;
		int productListSize = 0;
		
		Iterator<Location> iter = locationList.iterator();
		while(iter.hasNext()) {
			Location loc = (Location)iter.next();
			if(loc.getLocName().contains(searchKeyword)) {
				locFlag = true;
				break;
			}
		}

		if(locFlag) {
			param.put("locName", searchKeyword);
			productList = productService.searchLocation(param);
			productListSize = productService.searchLocationSize(searchKeyword);
			log.debug("locSearch : {}", productList);
		}else {
			param.put("productName", searchKeyword);
			productList = productService.searchTitle(param);
			productListSize = productService.searchTitleSize(searchKeyword);
			log.debug("titleSearch : {}", productList);
		}
		
		List<ProductImage> productImageList = new ArrayList<>();
		Iterator<Product> iter2 = productList.iterator();
	
		while(iter2.hasNext()) {
			Product product = (Product)iter2.next();
			List<ProductImage> proimgList =  productService.selectProductImageList(product.getProductId());
			if(proimgList.size() > 0) {
				productImageList.addAll(proimgList);				
			}else{
				productImageList.add(new ProductImage());
			}
		}
		
		//pagebar
		int totalContents = productListSize;
		String url = request.getRequestURI();
		log.debug("totalContents = {}",totalContents);
		log.debug("url = {}", url);
		
		//if(!"".equals(searchKeyword)) {
			url = url + "?searchkeyword=" + searchKeyword;
		//}
		
		String pageBar = ShareCarrotUtils.getPageBar(productListSize, cPage, numPerPage, url);
		
		model.addAttribute("searchkeyword", searchKeyword);
		model.addAttribute("productList", productList);
		model.addAttribute("productImageList", productImageList);
		model.addAttribute("productListSize", productListSize);
		model.addAttribute("pageBar", pageBar);
	}
}