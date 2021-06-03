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
	
	
	//header의 내상점으로 들어오기
	@RequestMapping(value="/myshopHead.do", method={RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public String myshophead(String memeberId) {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		//로그인한 memberId
	    String memberId = ((UserDetails) principal).getUsername();		
		//현재 로그인한 memberId의 shop_Id
		String shopId = shopService.selectMembershopId(memberId);
		
		return shopId;
		
	}
	
	//상점 들어가기
	@GetMapping("/myshop.do")
	public void mystore(Member member, Model model,Map<String, Object> param,
			@RequestParam String shopId) {
		
//		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
//		//로그인한 memberId
//	    String loginMemberId = ((UserDetails) principal).getUsername();		
//	
		Shop shop = shopService.selectShop(shopId);
		log.debug("shop = {}", shop);
		
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
//		model.addAttribute("loginMemberId", loginMemberId);
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
			@RequestParam Map<String,Object> param,
			Model model,			
			HttpServletResponse response, HttpServletRequest request) throws IOException {

		
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
		
		JSONObject obj = new JSONObject();
				
		obj.put("productList", productList);
		obj.put("productImageList", productImageList);
		obj.put("productListSize", productListSize);
		String resp = obj.toString();
				
		return resp;
		
	}
	
	//내상점-리뷰
	@ResponseBody
	@RequestMapping(value="/myshopReviewList.do", method=RequestMethod.GET,
			produces ="application/text; charset=utf8")
	public String myshopReviewList(@RequestParam String shopId, Model model,
			HttpServletResponse responset,HttpServletRequest request) throws IOException {
		
		List<StoreReviews> storeReviewList = storeReviewsService.selectStoreReviewsList(shopId);
		List<ReviewImage> reviewImageList = new ArrayList<>();
		List<Member> buyerList = new ArrayList<>();
		//List<ReviewComment> reviewCommentlist = new ArrayList<>();

		String shopMemberId = shopService.selectMemberId(shopId);
		
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		//로그인한 memberId
	    String loginMemberId = ((UserDetails) principal).getUsername();	
		
		
	    int storeReviewListSize = storeReviewsService.selectStoreReviewListSize(shopId);

		

		Iterator<StoreReviews> iter = storeReviewList.iterator();
		while(iter.hasNext()) {
			StoreReviews reviews = (StoreReviews)iter.next();
			List<ReviewImage> imgList = storeReviewsService.selectReviewImageList(reviews.getReviewNo());
			List<Member> bList = transactionHistoryService.selectBuyer(reviews.getProductId());
			buyerList.addAll(bList);
			reviewImageList.addAll(imgList);

			
		}
		
		List<ReviewComment> reviewCommentlist = reviewCommentService.selectReviewCommentOne();

		JSONObject obj = new JSONObject();
		log.info("@@buyerList : {}",buyerList);
	
		obj.put("shopMemberId", shopMemberId);
		obj.put("loginMemberId",loginMemberId);
		obj.put("storeReviewList", storeReviewList);
		obj.put("reviewImageList", reviewImageList);
		obj.put("storeReviewListSize", storeReviewListSize);
		obj.put("buyerList", buyerList);
		obj.put("reviewCommentlist", reviewCommentlist);
		String resp = obj.toString();
		
		return resp;
	}
	
	//내상점 댓글등록
	@ResponseBody
	@RequestMapping(value="/reviewComment.do", method= RequestMethod.POST,produces ="text/plain; charset=utf8")
	 public void reviewComment(@RequestParam Map<String,Object> param) {
		System.out.println(param);
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		String memberId = ((UserDetails) principal).getUsername(); 	
		param.put("memberId", memberId);
		int result = reviewCommentService.insertReviewComment(param);
		
	}
	
	//내상점 댓글삭제
	@ResponseBody
	@RequestMapping(value="/deleteReviewComment.do",method= RequestMethod.POST)
	public int deleteReviewComment(ReviewComment reviewComment) {
		
		return reviewCommentService.deleteReviewComment(reviewComment);
	}

}