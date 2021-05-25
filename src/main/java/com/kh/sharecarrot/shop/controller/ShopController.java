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
import com.kh.sharecarrot.member.model.service.MemberService;
import com.kh.sharecarrot.member.model.vo.Member;
import com.kh.sharecarrot.product.model.service.ProductService;
import com.kh.sharecarrot.product.model.vo.Product;
import com.kh.sharecarrot.product.model.vo.ProductImage;
import com.kh.sharecarrot.reviewcomment.model.service.ReviewCommentService;
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
	private MemberService memberService;
	@Autowired
	private ProductService productService;
	@Autowired
	private StoreReviewsService storeReviewsService;
	@Autowired
	private TransactionHistoryService transactionHistoryService;

	
	@Autowired
	private ReviewCommentService reviewCommentService;
	
	@RequestMapping(value="/enroll.do")
	public ModelAndView productReg() {
		ModelAndView mav = new ModelAndView("shopManage/shopManageBase");
		mav.addObject("tab","productEnroll");
		return mav;
	}
	
	@RequestMapping(value="/manage.do")
	public ModelAndView productManage() {
		ModelAndView mav = new ModelAndView("shopManage/shopManageBase");
		mav.addObject("tab","productManage");
		return mav;
	}
	
	@RequestMapping(value="/transactionHistory.do")
	public ModelAndView transactionHistory() {
		ModelAndView mav = new ModelAndView("shopManage/shopManageBase");
		mav.addObject("tab","transactionHistory");
		return mav;
	}

	@GetMapping("/myshop.do")
	public void mystore(Member member, Model model,Map<String, Object> param) {

		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		//로그인한 memberId
	    String loginMemberId = ((UserDetails) principal).getUsername();		
		//loginmember로 정보 받아오기
		System.out.println("##############"+loginMemberId);

		//넘어온 shopId 임시로 적어둠
		String shopId = "p9";
		
		Shop shop = shopService.selectShop(shopId);
		log.info("shop = {}", shop);
		
		//현재 상점 주인의 memberId
		String memberId = shopService.selectMemberId(shopId);
//		
//		if(loginMemberId.equals(memberId)) {
//			//상점 주인이 로그인한 경우
//		}else {
//			//구매자가 들어온 경우
//		}
		
		//현재 상점 id로 현재 shop 객체 받아옴
		
		String profile = memberService.selectShopMember(memberId);

		//방문자수(조회수)
		int result = shopService.updateVisitCount(shopId);
		int openday = shopService.selectOpenDay(loginMemberId);
		
		model.addAttribute("openday", openday);
		model.addAttribute("shop", shop);
		model.addAttribute("profile", profile);
	}
	
	@ResponseBody
	@RequestMapping(value="/myshopProductList.do", method={RequestMethod.POST,RequestMethod.GET},
			produces ="application/text; charset=utf8")
//	@GetMapping("/myshopProductList.do")
	public String myshopProductList(@RequestParam String shopId,
			@RequestParam(defaultValue ="1" ) int cPage,@RequestParam Map<String,Object> param,
			Model model,			
			HttpServletResponse response, HttpServletRequest request) throws IOException {
//		response.setCharacterEncoding("UTF-8");
		
		
		int numPerPage = 5;
		log.debug("cPage = {}", cPage);
		//Map<String, Object> param = new HashMap<>();
			param.put("numPerPage", numPerPage);
			param.put("cPage", cPage);
			param.put("shopId", shopId);
			
			
			
		List<Product> productList = productService.selectProductList(param);
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

//		log.info("productList : {}", productList);
//		log.info("productImageList : {}", productImageList);
//		log.info("productListSize : {}", productListSize);

		
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
	public String myshopReviewList(@RequestParam(defaultValue ="1") int cPage,
			@RequestParam String shopId,
			Model model,
			HttpServletResponse responset,HttpServletRequest request) throws IOException {
	
		//1. 사용자입력값
		int numPerPage = 2;
		log.debug("cPage = {}", cPage);
		Map<String, Object> param = new HashMap<>();
		param.put("numPerPage", numPerPage);
		param.put("cPage", cPage);
		
		List<StoreReviews> reviewList = storeReviewsService.selectStoreReviewsList(shopId,param);
		List<ReviewImage> reviewImageList = new ArrayList<>();
		List<Member> buyerList = new ArrayList<>();

//		log.info("storeReviews = {}", reviewList);
		int reviewListSize = reviewList.size();

		Iterator<StoreReviews> iter = reviewList.iterator();
		while(iter.hasNext()) {
			StoreReviews reviews = (StoreReviews)iter.next();
			List<ReviewImage> imgList = storeReviewsService.selectReviewImageList(reviews.getReviewNo());
			List<Member> bList = transactionHistoryService.selectBuyer(reviews.getProductId());
			buyerList.addAll(bList);
			reviewImageList.addAll(imgList);
		}
		
		int totalContents = storeReviewsService.getTotalContents(shopId);
		String url = request.getRequestURI();
		log.debug("totalContents = {}",totalContents);
		log.debug("url = {}", url);
		String pageBar2 = ShareCarrotUtils.getPageBar(totalContents, cPage, numPerPage, url);
	
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
		obj.put("pageBar2", pageBar2);
		String resp = obj.toString();
//		
		return resp;
	}
	
	//댓글등록
	@RequestMapping(value="/reviewComment.do", method= {RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	 public void reviewComment(HttpServletRequest request, HttpServletResponse response ,@RequestParam Map<String,Object> param) {
		System.out.println(param);
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		String memberId = ((UserDetails) principal).getUsername(); 	
		param.put("memberId", memberId);
		int result = reviewCommentService.insertReviewComment(param);
	
	}
	

	
}