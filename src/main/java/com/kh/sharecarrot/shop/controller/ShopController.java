package com.kh.sharecarrot.shop.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.kh.sharecarrot.common.ShareCarrotUtils;
import com.kh.sharecarrot.member.model.vo.Member;
import com.kh.sharecarrot.product.model.service.ProductService;
import com.kh.sharecarrot.product.model.vo.Product;
import com.kh.sharecarrot.product.model.vo.ProductImage;
import com.kh.sharecarrot.shop.model.service.ShopService;
import com.kh.sharecarrot.shop.model.vo.Shop;
import com.kh.sharecarrot.storereviews.model.service.StoreReviewsService;
import com.kh.sharecarrot.storereviews.model.vo.ReviewImage;
import com.kh.sharecarrot.storereviews.model.vo.StoreReviews;
import com.kh.sharecarrot.transactionhistory.model.service.TransactionHistoryService;

import lombok.extern.slf4j.Slf4j;
import net.sf.json.JSONObject;

@Slf4j
@Controller
@RequestMapping(value = "/shop")
@SessionAttributes("loginMember")
public class ShopController {
	
	@Autowired
	private ShopService shopService;
	@Autowired
	private ProductService productService;
	@Autowired
	private StoreReviewsService storeReviewsService;
	@Autowired
	private TransactionHistoryService transactionHistoryService;

	@GetMapping("/myshop.do")
	public void mystore(Member member, Model model) {
		//shop_id로 정보 받아오기-아이디, 프로필
		//Shop shop = shopService.selectShopOne(shopId);

		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
	    String memberId = ((UserDetails) principal).getUsername(); 		
		//loginmember로 정보 받아오기
		System.out.println("##############"+memberId);
		Shop shop = shopService.selectShopOne(memberId);
		
		//나중에 shop_id 받아서 하는거로 할거임
		//지금 위에 shop을 가져왔으니,
		//저 shop_id를 이용해서 member를 가져와서
		//그 member를 사용해서 처리하게끔.
		
		
		//프로필
		//Member profile = shopService.selectProfilOne(memberId);
		//model.addAttribute("loginMember", authentication.getPrincipal());

		//shop_id에 해당하는 상품 가져오기
		//List<Product> Productlist = shopService.selectProductOne(shopId);
		//shop_id에 해당하는 상점후기 가져오기
		//List<StoreReview> Reviewlist = shopService.selectReviewtOne(shopId);
		//상점오픈일- 회원가입시 shop_id가 생기니깐 그날로부터 하면되지않을까?

		//판매횟수

		String shopId = shop.getShopId();
		//방문자수(조회수)
		int result = shopService.updateVisitCount(shopId);
		int openday = shopService.selectOpenDay(memberId);
		
		model.addAttribute("openday", openday);
		model.addAttribute("shop", shop);
		//model.addAttribute("profile", profile);
	}
	
	@ResponseBody
	@RequestMapping(value="/myshopProductList.do", method=RequestMethod.GET,
			produces ="application/text; charset=utf8")
//	@GetMapping("/myshopProductList.do")
	public String myshopProductList(@RequestParam(defaultValue="p9") String shopId,
			@RequestParam(defaultValue ="1") int cPage,
			Model model,			
			HttpServletResponse response, HttpServletRequest request) throws IOException {
//		response.setCharacterEncoding("UTF-8");
		
		
		int numPerPage = 5;
		log.debug("cPage = {}", cPage);
		Map<String, Object> param = new HashMap<>();
			param.put("numPerPage", numPerPage);
			param.put("cPage", cPage);
			
			
			
		List<Product> productList = productService.selectProductList(shopId,param);
		int productListSize = productService.selectProductListSize(shopId);
		
//		Product product = productlist.get(0);
		
		List<ProductImage> productImageList = new ArrayList<>();
		Iterator<Product> iter = productList.iterator();
		//ProductImage productImage = null;
		while(iter.hasNext()) {
			Product product = (Product)iter.next();
			List<ProductImage> proimgList =  productService.selectProductImageList(product.getProductId());
			productImageList.addAll(proimgList);
		}

		log.info("productList : {}", productList);
		log.info("productImageList : {}", productImageList);
		log.info("productListSize : {}", productListSize);
//		log.info("productlist = {}", productlist);
	//	log.info("productImageList = {}", productImageList);
		
		//pagebar
		int totalContents = productService.getTotalContents(shopId);
		String url = request.getRequestURI();
		log.debug("totalContents = {}",totalContents);
		log.debug("url = {}", url);
		String pageBar = ShareCarrotUtils.getPageBar(totalContents, cPage, numPerPage, url);
		
//		model.addAttribute("pageBar", pageBar);
		
		//상위 오브젝트 생성
		JSONObject obj = new JSONObject();
				
	//	model.addAttribute("productListSize", productListSize);
		//data: 뒤에 들어갈 값인 jArray 생성
		obj.put("productList", productList);
		obj.put("productImageList", productImageList);
		obj.put("productListSize", productListSize);
		obj.put("pageBar", pageBar);
		String resp = obj.toString();
				
		return resp;
		
	}
	
	@ResponseBody
	@RequestMapping(value="/myshopReviewList.do", method=RequestMethod.GET,
			produces ="application/text; charset=utf8")
//	@GetMapping("/myshopProductList.do")
	public String myshopReviewList(@RequestParam String shopId,
			Model model,
			HttpServletResponse response) throws IOException {

		List<StoreReviews> reviewList = storeReviewsService.selectStoreReviewsList(shopId);
		List<ReviewImage> reviewImageList = new ArrayList<>();
		List<Member> buyerList = new ArrayList<>();

		log.info("storeReviews = {}", reviewList);
		int reviewListSize = reviewList.size();

		Iterator<StoreReviews> iter = reviewList.iterator();
		while(iter.hasNext()) {
			StoreReviews reviews = (StoreReviews)iter.next();
			List<ReviewImage> imgList = storeReviewsService.selectReviewImageList(reviews.getReviewNo());
			List<Member> bList = transactionHistoryService.selectBuyer(reviews.getProductId());
			buyerList.addAll(bList);
			reviewImageList.addAll(imgList);
		}
	
//		log.info("reviewList : {}", reviewList);
//		log.info("reviewImageList : {}", reviewImageList);
//		log.info("reviewListSize : {}", reviewListSize);

		//		//상위 오브젝트 생성
		JSONObject obj = new JSONObject();
		log.info("@@buyerList : {}",buyerList);
		
//		model.addAttribute("productListSize", productListSize);
//		//data: 뒤에 들어갈 값인 jArray 생성
		obj.put("reviewList", reviewList);
		obj.put("reviewImageList", reviewImageList);
		obj.put("reviewListSize", reviewListSize);
		obj.put("buyerList", buyerList);
		String resp = obj.toString();
//				
		return resp;
	}
}