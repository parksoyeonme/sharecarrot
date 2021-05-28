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
import com.kh.sharecarrot.reviewcomment.model.vo.ReviewComment;
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
	
	

	@RequestMapping(value="/myshopHead.do", method={RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public String myshophead(String memeberId) {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		//로그인한 memberId
	    String memberId = ((UserDetails) principal).getUsername();		
		//loginmember로 정보 받아오기
		System.out.println("########여기요#####"+memberId);

		//현재 로그인한 memberId의 shop_Id
		String shopId = shopService.selectMembershopId(memberId);
		
		return shopId;
		
	}
	
	
	@GetMapping("/myshop.do")
	public void mystore(Member member, Model model,Map<String, Object> param,
			@RequestParam String shopId) {

		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		//로그인한 memberId
	    String loginMemberId = ((UserDetails) principal).getUsername();		
		//loginmember로 정보 받아오기
		System.out.println("##############"+loginMemberId);

		//넘어온 shopId 임시로 적어둠
		//String shopId1 = "p9";
		
		Shop shop = shopService.selectShop(shopId);
		log.info("shop = {}", shop);
		
		//현재 상점 주인의 memberId
		String memberId = shopService.selectMemberId(shopId);

		//현재 상점 id로 현재 shop 객체 받아옴
		
		String profile = memberService.selectShopMember(memberId);

		//방문자수(조회수)
		int result = shopService.updateVisitCount(shopId);
		//상점오픈일
		int openday = shopService.selectOpenDay(shopId);
		//상품판매횟수
		int sellCount = shopService.selectsellCount(shopId);
		
		model.addAttribute("memberId", memberId);
		model.addAttribute("loginMemberId", loginMemberId);
		model.addAttribute("openday", openday);
		model.addAttribute("shop", shop);
		model.addAttribute("profile", profile);
		model.addAttribute("sellCount", sellCount);
	}
	
	//내상점-상품
	@ResponseBody
	@RequestMapping(value="/myshopProductList.do", method={RequestMethod.POST,RequestMethod.GET},
			produces ="application/text; charset=utf8")
	public String myshopProductList(@RequestParam(required = false) String shopId,
			@RequestParam(defaultValue ="1" ) int cPage,@RequestParam Map<String,Object> param,
			Model model,			
			HttpServletResponse response, HttpServletRequest request) throws IOException {

		int numPerPage = 5;
		log.debug("cPage = {}", cPage);
			param.put("numPerPage", numPerPage);
			param.put("cPage", cPage);
			param.put("shopId", shopId);
			
			
			
		List<Product> productList = productService.selectProductList(param);
		int productListSize = productService.selectProductListSize(shopId);
		

		List<ProductImage> productImageList = new ArrayList<>();
		Iterator<Product> iter = productList.iterator();
	
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
		

		JSONObject obj = new JSONObject();
				
		//data: 뒤에 들어갈 값인 jArray 생성
		obj.put("productList", productList);
		obj.put("productImageList", productImageList);
		obj.put("productListSize", productListSize);
		obj.put("pageBar", pageBar);
		String resp = obj.toString();
				
		return resp;
		
	}
	
	//내상점-리뷰
	@ResponseBody
	@RequestMapping(value="/myshopReviewList.do", method=RequestMethod.GET,
			produces ="application/text; charset=utf8")
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

		String shopMemberId = shopService.selectMemberId(shopId);
		
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		//로그인한 memberId
	    String loginMemberId = ((UserDetails) principal).getUsername();	
		
		//List<ReviewComment> reviewCommList = new ArrayList<>();
		
		int totalReviewComment = reviewCommentService.selectTotalCommentsNo();
		ReviewComment[] reviewCommArray = new ReviewComment[totalReviewComment];

		int reviewListSize = reviewList.size();
		
		//댓글이 존재하면 1, 없으면 0
		int j = 0;
		Integer[] isExistArray = new Integer[reviewListSize];
		Iterator<StoreReviews> iter = reviewList.iterator();
		while(iter.hasNext()) {
			StoreReviews reviews = (StoreReviews)iter.next();
			List<ReviewImage> imgList = storeReviewsService.selectReviewImageList(reviews.getReviewNo());
			List<Member> bList = transactionHistoryService.selectBuyer(reviews.getProductId());
//			List<ReviewComment> list = reviewCommentService.reviewCommentlist(reviews.getReviewNo());
			reviewCommArray[j] = reviewCommentService.selectReviewCommentOne(reviews.getReviewNo());
			log.info("@@@reviewCommArray[j] : {}", reviewCommArray[j]);
			buyerList.addAll(bList);
			reviewImageList.addAll(imgList);
//			reviewCommList.addAll(list);
			j++;
		}
		
		int totalContents = storeReviewsService.getTotalContents(shopId);
		String url = request.getRequestURI();

		String pageBar2 = ShareCarrotUtils.getPageBar(totalContents, cPage, numPerPage, url);

		JSONObject obj = new JSONObject();
		log.info("@@buyerList : {}",buyerList);
		//data: 뒤에 들어갈 값인 jArray 생성
		log.info("@@@reviewCommArraylength : {}", reviewCommArray.length);
		log.info("@@@reviewCommArray : {}", reviewCommArray);
		
		for(int i = 0; i < 2; i++) {
			if(reviewCommArray[i]==null) {
				isExistArray[i] = 0;
//				isExistList.add(0);
			}else if(reviewCommArray[i]!=null) {
				isExistArray[i] = 1;
//				isExistList.add(1);
			}
			log.info("@@@isExistArray[i] = {}", isExistArray[i]);			
		}

		//배열로 변경

		
//		obj.put("isExistList", isExistList);
//		if(reviewCommList.size() >= 1) {
//			//있을 때
//			obj.put("isExist", true);
//		}else {
//			//없을 때
//			obj.put("isExist", false);
//		
		
		obj.put("shopMemberId", shopMemberId);
		obj.put("loginMemberId",loginMemberId);
		obj.put("reviewList", reviewList);
		obj.put("reviewImageList", reviewImageList);
		obj.put("reviewListSize", reviewListSize);
		obj.put("buyerList", buyerList);
		obj.put("pageBar2", pageBar2);
		obj.put("isExistArray", isExistArray);
		obj.put("reviewCommArray", reviewCommArray);
		String resp = obj.toString();
//		
		return resp;
	}
	
	//내상점 상점리뷰에 댓글등록
	@ResponseBody
	@RequestMapping(value="/reviewComment.do", method= RequestMethod.POST,produces ="text/plain; charset=utf8")
	 public void reviewComment(HttpServletRequest request, HttpServletResponse response ,@RequestParam Map<String,Object> param) {
		System.out.println(param);
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		String memberId = ((UserDetails) principal).getUsername(); 	
		param.put("memberId", memberId);
		int result = reviewCommentService.insertReviewComment(param);
		
	}
	

	
}