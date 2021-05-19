package com.kh.sharecarrot.shop.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.kh.sharecarrot.member.model.vo.Member;
import com.kh.sharecarrot.product.model.service.ProductService;
import com.kh.sharecarrot.product.model.vo.Product;
import com.kh.sharecarrot.product.model.vo.ProductImage;
import com.kh.sharecarrot.shop.model.service.ShopService;
import com.kh.sharecarrot.shop.model.vo.Shop;

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
	
	@RequestMapping(value="/enroll.do")
	public ModelAndView productReg() {
		ModelAndView mav = new ModelAndView("products/products");
		mav.addObject("tab","productEnroll");
		return mav;
	}
	
	@RequestMapping(value="/manage.do")
	public ModelAndView productManage() {
		ModelAndView mav = new ModelAndView("products/products");
		mav.addObject("tab","productManage");
		return mav;
	}
	
	@RequestMapping(value="/transactionHistory.do")
	public ModelAndView transactionHistory() {
		ModelAndView mav = new ModelAndView("products/products");
		mav.addObject("tab","transactionHistory");
		return mav;
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	@GetMapping("/myshop.do")
	public void mystore(Member member, Model model, HttpServletResponse rs) throws IOException {
		//shop_id로 정보 받아오기-아이디, 프로필
		//Shop shop = shopService.selectShopOne(shopId);
		
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
	      String memberId = ((UserDetails) principal).getUsername(); 		
		//loginmember로 정보 받아오기
		System.out.println("##############"+memberId);
		Shop shop = shopService.selectShopOne(memberId);
		
		
		
		//프로필
		//Member profile = shopService.selectProfilOne(memberId);
		//model.addAttribute("loginMember", authentication.getPrincipal());

		//shop_id에 해당하는 상품 가져오기 이거아님
		//List<Product> Productlist = shopService.selectProductOne(shopId);
		//shop_id에 해당하는 상점후기 가져오기
		//List<StoreReview> Reviewlist = shopService.selectReviewtOne(shopId);
		
		String shopId = shop.getShopId();
		//상점오픈일- 회원가입시 shop_id가 생기니깐 그날로부터 하면되지않을까?
		
		//판매횟수
		
		//방문자수(조회수)
		int result = shopService.updateVisitCount(shopId);
		
		//상품
		List<Product> prolist = shopService.selectProductList(shopId);
		model.addAttribute("shop", shop);
		model.addAttribute("prolist", prolist);
		//model.addAttribute("profile", profile);
		
		//상품 불러오가ㅣ
		
		//상점후기 불러우기
	}
	
}